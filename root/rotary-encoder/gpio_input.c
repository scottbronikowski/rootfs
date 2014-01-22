<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title>drivers/input/misc/gpio_input.c - kernel/omap - Git at Google</title><link rel="stylesheet" type="text/css" href="//www.google.com/css/go.css" /><link rel="stylesheet" type="text/css" href="/+static/prettify/prettify.vf-M93Ay4IiiWRQSJKPGWQ.cache.css" /><link rel="stylesheet" type="text/css" href="/+static/gitiles.crLPUWVIreWn55oryoTFfA.cache.css" /><script src="/+static/prettify/prettify_compiled.GHRTDQJlSdpNotJivTmj9w.cache.js" type="text/javascript"></script></head><body onload="prettyPrint()"><h1><img src="//www.google.com/images/logo_sm.gif" alt="Google" />Git</h1><div class="menu"> <a href="https://www.google.com/a/SelectSession?service=gerritcodereview&amp;continue=https://android.googlesource.com/login/kernel/omap/%2B/glass-omap-xrr02/drivers/input/misc/gpio_input.c">Sign in</a> </div><div class="breadcrumbs"><a href="/?format=HTML">android</a> / <a href="/kernel/omap/">kernel/omap</a> / <a href="/kernel/omap/+/glass-omap-xrr02">glass-omap-xrr02</a> / <a href="/kernel/omap/+/glass-omap-xrr02/">.</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers">drivers</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input">input</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input/misc">misc</a> / gpio_input.c</div><div class="sha1">blob: 6a0c31510968566d678a09a7cadb8bf18929940b [<a href="/kernel/omap/+log/glass-omap-xrr02/drivers/input/misc/gpio_input.c">file history</a>]</div><pre class="git-blob prettyprint linenums lang-c">/* drivers/input/misc/gpio_input.c
 *
 * Copyright (C) 2007 Google, Inc.
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#include &lt;linux/kernel.h&gt;
#include &lt;linux/gpio.h&gt;
#include &lt;linux/gpio_event.h&gt;
#include &lt;linux/hrtimer.h&gt;
#include &lt;linux/input.h&gt;
#include &lt;linux/interrupt.h&gt;
#include &lt;linux/slab.h&gt;
#include &lt;linux/wakelock.h&gt;

enum {
	DEBOUNCE_UNSTABLE     = BIT(0),	/* Got irq, while debouncing */
	DEBOUNCE_PRESSED      = BIT(1),
	DEBOUNCE_NOTPRESSED   = BIT(2),
	DEBOUNCE_WAIT_IRQ     = BIT(3),	/* Stable irq state */
	DEBOUNCE_POLL         = BIT(4),	/* Stable polling state */

	DEBOUNCE_UNKNOWN =
		DEBOUNCE_PRESSED | DEBOUNCE_NOTPRESSED,
};

struct gpio_key_state {
	struct gpio_input_state *ds;
	uint8_t debounce;
};

struct gpio_input_state {
	struct gpio_event_input_devs *input_devs;
	const struct gpio_event_input_info *info;
	struct hrtimer timer;
	int use_irq;
	int debounce_count;
	spinlock_t irq_lock;
	struct wake_lock wake_lock;
	struct gpio_key_state key_state[0];
};

static enum hrtimer_restart gpio_event_input_timer_func(struct hrtimer *timer)
{
	int i;
	int pressed;
	struct gpio_input_state *ds =
		container_of(timer, struct gpio_input_state, timer);
	unsigned gpio_flags = ds-&gt;info-&gt;flags;
	unsigned npolarity;
	int nkeys = ds-&gt;info-&gt;keymap_size;
	const struct gpio_event_direct_entry *key_entry;
	struct gpio_key_state *key_state;
	unsigned long irqflags;
	uint8_t debounce;
	bool sync_needed;

#if 0
	key_entry = kp-&gt;keys_info-&gt;keymap;
	key_state = kp-&gt;key_state;
	for (i = 0; i &lt; nkeys; i++, key_entry++, key_state++)
		pr_info(&quot;gpio_read_detect_status %d %d\n&quot;, key_entry-&gt;gpio,
			gpio_read_detect_status(key_entry-&gt;gpio));
#endif
	key_entry = ds-&gt;info-&gt;keymap;
	key_state = ds-&gt;key_state;
	sync_needed = false;
	spin_lock_irqsave(&amp;ds-&gt;irq_lock, irqflags);
	for (i = 0; i &lt; nkeys; i++, key_entry++, key_state++) {
		debounce = key_state-&gt;debounce;
		if (debounce &amp; DEBOUNCE_WAIT_IRQ)
			continue;
		if (key_state-&gt;debounce &amp; DEBOUNCE_UNSTABLE) {
			debounce = key_state-&gt;debounce = DEBOUNCE_UNKNOWN;
			enable_irq(gpio_to_irq(key_entry-&gt;gpio));
			if (gpio_flags &amp; GPIOEDF_PRINT_KEY_UNSTABLE)
				pr_info(&quot;gpio_keys_scan_keys: key %x-%x, %d &quot;
					&quot;(%d) continue debounce\n&quot;,
					ds-&gt;info-&gt;type, key_entry-&gt;code,
					i, key_entry-&gt;gpio);
		}
		npolarity = !(gpio_flags &amp; GPIOEDF_ACTIVE_HIGH);
		pressed = gpio_get_value(key_entry-&gt;gpio) ^ npolarity;
		if (debounce &amp; DEBOUNCE_POLL) {
			if (pressed == !(debounce &amp; DEBOUNCE_PRESSED)) {
				ds-&gt;debounce_count++;
				key_state-&gt;debounce = DEBOUNCE_UNKNOWN;
				if (gpio_flags &amp; GPIOEDF_PRINT_KEY_DEBOUNCE)
					pr_info(&quot;gpio_keys_scan_keys: key %x-&quot;
						&quot;%x, %d (%d) start debounce\n&quot;,
						ds-&gt;info-&gt;type, key_entry-&gt;code,
						i, key_entry-&gt;gpio);
			}
			continue;
		}
		if (pressed &amp;&amp; (debounce &amp; DEBOUNCE_NOTPRESSED)) {
			if (gpio_flags &amp; GPIOEDF_PRINT_KEY_DEBOUNCE)
				pr_info(&quot;gpio_keys_scan_keys: key %x-%x, %d &quot;
					&quot;(%d) debounce pressed 1\n&quot;,
					ds-&gt;info-&gt;type, key_entry-&gt;code,
					i, key_entry-&gt;gpio);
			key_state-&gt;debounce = DEBOUNCE_PRESSED;
			continue;
		}
		if (!pressed &amp;&amp; (debounce &amp; DEBOUNCE_PRESSED)) {
			if (gpio_flags &amp; GPIOEDF_PRINT_KEY_DEBOUNCE)
				pr_info(&quot;gpio_keys_scan_keys: key %x-%x, %d &quot;
					&quot;(%d) debounce pressed 0\n&quot;,
					ds-&gt;info-&gt;type, key_entry-&gt;code,
					i, key_entry-&gt;gpio);
			key_state-&gt;debounce = DEBOUNCE_NOTPRESSED;
			continue;
		}
		/* key is stable */
		ds-&gt;debounce_count--;
		if (ds-&gt;use_irq)
			key_state-&gt;debounce |= DEBOUNCE_WAIT_IRQ;
		else
			key_state-&gt;debounce |= DEBOUNCE_POLL;
		if (gpio_flags &amp; GPIOEDF_PRINT_KEYS)
			pr_info(&quot;gpio_keys_scan_keys: key %x-%x, %d (%d) &quot;
				&quot;changed to %d\n&quot;, ds-&gt;info-&gt;type,
				key_entry-&gt;code, i, key_entry-&gt;gpio, pressed);
		input_event(ds-&gt;input_devs-&gt;dev[key_entry-&gt;dev], ds-&gt;info-&gt;type,
			    key_entry-&gt;code, pressed);
		sync_needed = true;
	}
	if (sync_needed) {
		for (i = 0; i &lt; ds-&gt;input_devs-&gt;count; i++)
			input_sync(ds-&gt;input_devs-&gt;dev[i]);
	}

#if 0
	key_entry = kp-&gt;keys_info-&gt;keymap;
	key_state = kp-&gt;key_state;
	for (i = 0; i &lt; nkeys; i++, key_entry++, key_state++) {
		pr_info(&quot;gpio_read_detect_status %d %d\n&quot;, key_entry-&gt;gpio,
			gpio_read_detect_status(key_entry-&gt;gpio));
	}
#endif

	if (ds-&gt;debounce_count)
		hrtimer_start(timer, ds-&gt;info-&gt;debounce_time, HRTIMER_MODE_REL);
	else if (!ds-&gt;use_irq)
		hrtimer_start(timer, ds-&gt;info-&gt;poll_time, HRTIMER_MODE_REL);
	else
		wake_unlock(&amp;ds-&gt;wake_lock);

	spin_unlock_irqrestore(&amp;ds-&gt;irq_lock, irqflags);

	return HRTIMER_NORESTART;
}

static irqreturn_t gpio_event_input_irq_handler(int irq, void *dev_id)
{
	struct gpio_key_state *ks = dev_id;
	struct gpio_input_state *ds = ks-&gt;ds;
	int keymap_index = ks - ds-&gt;key_state;
	const struct gpio_event_direct_entry *key_entry;
	unsigned long irqflags;
	int pressed;

	if (!ds-&gt;use_irq)
		return IRQ_HANDLED;

	key_entry = &amp;ds-&gt;info-&gt;keymap[keymap_index];

	if (ds-&gt;info-&gt;debounce_time.tv64) {
		spin_lock_irqsave(&amp;ds-&gt;irq_lock, irqflags);
		if (ks-&gt;debounce &amp; DEBOUNCE_WAIT_IRQ) {
			ks-&gt;debounce = DEBOUNCE_UNKNOWN;
			if (ds-&gt;debounce_count++ == 0) {
				wake_lock(&amp;ds-&gt;wake_lock);
				hrtimer_start(
					&amp;ds-&gt;timer, ds-&gt;info-&gt;debounce_time,
					HRTIMER_MODE_REL);
			}
			if (ds-&gt;info-&gt;flags &amp; GPIOEDF_PRINT_KEY_DEBOUNCE)
				pr_info(&quot;gpio_event_input_irq_handler: &quot;
					&quot;key %x-%x, %d (%d) start debounce\n&quot;,
					ds-&gt;info-&gt;type, key_entry-&gt;code,
					keymap_index, key_entry-&gt;gpio);
		} else {
			disable_irq_nosync(irq);
			ks-&gt;debounce = DEBOUNCE_UNSTABLE;
		}
		spin_unlock_irqrestore(&amp;ds-&gt;irq_lock, irqflags);
	} else {
		pressed = gpio_get_value(key_entry-&gt;gpio) ^
			!(ds-&gt;info-&gt;flags &amp; GPIOEDF_ACTIVE_HIGH);
		if (ds-&gt;info-&gt;flags &amp; GPIOEDF_PRINT_KEYS)
			pr_info(&quot;gpio_event_input_irq_handler: key %x-%x, %d &quot;
				&quot;(%d) changed to %d\n&quot;,
				ds-&gt;info-&gt;type, key_entry-&gt;code, keymap_index,
				key_entry-&gt;gpio, pressed);
		input_event(ds-&gt;input_devs-&gt;dev[key_entry-&gt;dev], ds-&gt;info-&gt;type,
			    key_entry-&gt;code, pressed);
		input_sync(ds-&gt;input_devs-&gt;dev[key_entry-&gt;dev]);
	}
	return IRQ_HANDLED;
}

static int gpio_event_input_request_irqs(struct gpio_input_state *ds)
{
	int i;
	int err;
	unsigned int irq;
	unsigned long req_flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;

	for (i = 0; i &lt; ds-&gt;info-&gt;keymap_size; i++) {
		err = irq = gpio_to_irq(ds-&gt;info-&gt;keymap[i].gpio);
		if (err &lt; 0)
			goto err_gpio_get_irq_num_failed;
		err = request_irq(irq, gpio_event_input_irq_handler,
				  req_flags, &quot;gpio_keys&quot;, &amp;ds-&gt;key_state[i]);
		if (err) {
			pr_err(&quot;gpio_event_input_request_irqs: request_irq &quot;
				&quot;failed for input %d, irq %d\n&quot;,
				ds-&gt;info-&gt;keymap[i].gpio, irq);
			goto err_request_irq_failed;
		}
		if (ds-&gt;info-&gt;info.no_suspend) {
			err = enable_irq_wake(irq);
			if (err) {
				pr_err(&quot;gpio_event_input_request_irqs: &quot;
					&quot;enable_irq_wake failed for input %d, &quot;
					&quot;irq %d\n&quot;,
					ds-&gt;info-&gt;keymap[i].gpio, irq);
				goto err_enable_irq_wake_failed;
			}
		}
	}
	return 0;

	for (i = ds-&gt;info-&gt;keymap_size - 1; i &gt;= 0; i--) {
		irq = gpio_to_irq(ds-&gt;info-&gt;keymap[i].gpio);
		if (ds-&gt;info-&gt;info.no_suspend)
			disable_irq_wake(irq);
err_enable_irq_wake_failed:
		free_irq(irq, &amp;ds-&gt;key_state[i]);
err_request_irq_failed:
err_gpio_get_irq_num_failed:
		;
	}
	return err;
}

int gpio_event_input_func(struct gpio_event_input_devs *input_devs,
			struct gpio_event_info *info, void **data, int func)
{
	int ret;
	int i;
	unsigned long irqflags;
	struct gpio_event_input_info *di;
	struct gpio_input_state *ds = *data;

	di = container_of(info, struct gpio_event_input_info, info);

	if (func == GPIO_EVENT_FUNC_SUSPEND) {
		if (ds-&gt;use_irq)
			for (i = 0; i &lt; di-&gt;keymap_size; i++)
				disable_irq(gpio_to_irq(di-&gt;keymap[i].gpio));
		hrtimer_cancel(&amp;ds-&gt;timer);
		return 0;
	}
	if (func == GPIO_EVENT_FUNC_RESUME) {
		spin_lock_irqsave(&amp;ds-&gt;irq_lock, irqflags);
		if (ds-&gt;use_irq)
			for (i = 0; i &lt; di-&gt;keymap_size; i++)
				enable_irq(gpio_to_irq(di-&gt;keymap[i].gpio));
		hrtimer_start(&amp;ds-&gt;timer, ktime_set(0, 0), HRTIMER_MODE_REL);
		spin_unlock_irqrestore(&amp;ds-&gt;irq_lock, irqflags);
		return 0;
	}

	if (func == GPIO_EVENT_FUNC_INIT) {
		if (ktime_to_ns(di-&gt;poll_time) &lt;= 0)
			di-&gt;poll_time = ktime_set(0, 20 * NSEC_PER_MSEC);

		*data = ds = kzalloc(sizeof(*ds) + sizeof(ds-&gt;key_state[0]) *
					di-&gt;keymap_size, GFP_KERNEL);
		if (ds == NULL) {
			ret = -ENOMEM;
			pr_err(&quot;gpio_event_input_func: &quot;
				&quot;Failed to allocate private data\n&quot;);
			goto err_ds_alloc_failed;
		}
		ds-&gt;debounce_count = di-&gt;keymap_size;
		ds-&gt;input_devs = input_devs;
		ds-&gt;info = di;
		wake_lock_init(&amp;ds-&gt;wake_lock, WAKE_LOCK_SUSPEND, &quot;gpio_input&quot;);
		spin_lock_init(&amp;ds-&gt;irq_lock);

		for (i = 0; i &lt; di-&gt;keymap_size; i++) {
			int dev = di-&gt;keymap[i].dev;
			if (dev &gt;= input_devs-&gt;count) {
				pr_err(&quot;gpio_event_input_func: bad device &quot;
					&quot;index %d &gt;= %d for key code %d\n&quot;,
					dev, input_devs-&gt;count,
					di-&gt;keymap[i].code);
				ret = -EINVAL;
				goto err_bad_keymap;
			}
			input_set_capability(input_devs-&gt;dev[dev], di-&gt;type,
					     di-&gt;keymap[i].code);
			ds-&gt;key_state[i].ds = ds;
			ds-&gt;key_state[i].debounce = DEBOUNCE_UNKNOWN;
		}

		for (i = 0; i &lt; di-&gt;keymap_size; i++) {
			ret = gpio_request(di-&gt;keymap[i].gpio, &quot;gpio_kp_in&quot;);
			if (ret) {
				pr_err(&quot;gpio_event_input_func: gpio_request &quot;
					&quot;failed for %d\n&quot;, di-&gt;keymap[i].gpio);
				goto err_gpio_request_failed;
			}
			ret = gpio_direction_input(di-&gt;keymap[i].gpio);
			if (ret) {
				pr_err(&quot;gpio_event_input_func: &quot;
					&quot;gpio_direction_input failed for %d\n&quot;,
					di-&gt;keymap[i].gpio);
				goto err_gpio_configure_failed;
			}
		}

		ret = gpio_event_input_request_irqs(ds);

		spin_lock_irqsave(&amp;ds-&gt;irq_lock, irqflags);
		ds-&gt;use_irq = ret == 0;

		pr_info(&quot;GPIO Input Driver: Start gpio inputs for %s%s in %s &quot;
			&quot;mode\n&quot;, input_devs-&gt;dev[0]-&gt;name,
			(input_devs-&gt;count &gt; 1) ? &quot;...&quot; : &quot;&quot;,
			ret == 0 ? &quot;interrupt&quot; : &quot;polling&quot;);

		hrtimer_init(&amp;ds-&gt;timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
		ds-&gt;timer.function = gpio_event_input_timer_func;
		hrtimer_start(&amp;ds-&gt;timer, ktime_set(0, 0), HRTIMER_MODE_REL);
		spin_unlock_irqrestore(&amp;ds-&gt;irq_lock, irqflags);
		return 0;
	}

	ret = 0;
	spin_lock_irqsave(&amp;ds-&gt;irq_lock, irqflags);
	hrtimer_cancel(&amp;ds-&gt;timer);
	if (ds-&gt;use_irq) {
		for (i = di-&gt;keymap_size - 1; i &gt;= 0; i--) {
			int irq = gpio_to_irq(di-&gt;keymap[i].gpio);
			if (ds-&gt;info-&gt;info.no_suspend)
				disable_irq_wake(irq);
			free_irq(irq, &amp;ds-&gt;key_state[i]);
		}
	}
	spin_unlock_irqrestore(&amp;ds-&gt;irq_lock, irqflags);

	for (i = di-&gt;keymap_size - 1; i &gt;= 0; i--) {
err_gpio_configure_failed:
		gpio_free(di-&gt;keymap[i].gpio);
err_gpio_request_failed:
		;
	}
err_bad_keymap:
	wake_lock_destroy(&amp;ds-&gt;wake_lock);
	kfree(ds);
err_ds_alloc_failed:
	return ret;
}
</pre><div class="footer">Powered by <a href="https://code.google.com/p/gitiles/">Gitiles</a></div></body></html>
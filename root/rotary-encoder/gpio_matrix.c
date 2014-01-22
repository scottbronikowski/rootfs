<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title>drivers/input/misc/gpio_matrix.c - kernel/omap - Git at Google</title><link rel="stylesheet" type="text/css" href="//www.google.com/css/go.css" /><link rel="stylesheet" type="text/css" href="/+static/prettify/prettify.vf-M93Ay4IiiWRQSJKPGWQ.cache.css" /><link rel="stylesheet" type="text/css" href="/+static/gitiles.crLPUWVIreWn55oryoTFfA.cache.css" /><script src="/+static/prettify/prettify_compiled.GHRTDQJlSdpNotJivTmj9w.cache.js" type="text/javascript"></script></head><body onload="prettyPrint()"><h1><img src="//www.google.com/images/logo_sm.gif" alt="Google" />Git</h1><div class="menu"> <a href="https://www.google.com/a/SelectSession?service=gerritcodereview&amp;continue=https://android.googlesource.com/login/kernel/omap/%2B/glass-omap-xrr02/drivers/input/misc/gpio_matrix.c">Sign in</a> </div><div class="breadcrumbs"><a href="/?format=HTML">android</a> / <a href="/kernel/omap/">kernel/omap</a> / <a href="/kernel/omap/+/glass-omap-xrr02">glass-omap-xrr02</a> / <a href="/kernel/omap/+/glass-omap-xrr02/">.</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers">drivers</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input">input</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input/misc">misc</a> / gpio_matrix.c</div><div class="sha1">blob: eaa9e89d473acb0795a9ebf02b2de7e7382fcca8 [<a href="/kernel/omap/+log/glass-omap-xrr02/drivers/input/misc/gpio_matrix.c">file history</a>]</div><pre class="git-blob prettyprint linenums lang-c">/* drivers/input/misc/gpio_matrix.c
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
#include &lt;linux/interrupt.h&gt;
#include &lt;linux/slab.h&gt;
#include &lt;linux/wakelock.h&gt;

struct gpio_kp {
	struct gpio_event_input_devs *input_devs;
	struct gpio_event_matrix_info *keypad_info;
	struct hrtimer timer;
	struct wake_lock wake_lock;
	int current_output;
	unsigned int use_irq:1;
	unsigned int key_state_changed:1;
	unsigned int last_key_state_changed:1;
	unsigned int some_keys_pressed:2;
	unsigned int disabled_irq:1;
	unsigned long keys_pressed[0];
};

static void clear_phantom_key(struct gpio_kp *kp, int out, int in)
{
	struct gpio_event_matrix_info *mi = kp-&gt;keypad_info;
	int key_index = out * mi-&gt;ninputs + in;
	unsigned short keyentry = mi-&gt;keymap[key_index];
	unsigned short keycode = keyentry &amp; MATRIX_KEY_MASK;
	unsigned short dev = keyentry &gt;&gt; MATRIX_CODE_BITS;

	if (!test_bit(keycode, kp-&gt;input_devs-&gt;dev[dev]-&gt;key)) {
		if (mi-&gt;flags &amp; GPIOKPF_PRINT_PHANTOM_KEYS)
			pr_info(&quot;gpiomatrix: phantom key %x, %d-%d (%d-%d) &quot;
				&quot;cleared\n&quot;, keycode, out, in,
				mi-&gt;output_gpios[out], mi-&gt;input_gpios[in]);
		__clear_bit(key_index, kp-&gt;keys_pressed);
	} else {
		if (mi-&gt;flags &amp; GPIOKPF_PRINT_PHANTOM_KEYS)
			pr_info(&quot;gpiomatrix: phantom key %x, %d-%d (%d-%d) &quot;
				&quot;not cleared\n&quot;, keycode, out, in,
				mi-&gt;output_gpios[out], mi-&gt;input_gpios[in]);
	}
}

static int restore_keys_for_input(struct gpio_kp *kp, int out, int in)
{
	int rv = 0;
	int key_index;

	key_index = out * kp-&gt;keypad_info-&gt;ninputs + in;
	while (out &lt; kp-&gt;keypad_info-&gt;noutputs) {
		if (test_bit(key_index, kp-&gt;keys_pressed)) {
			rv = 1;
			clear_phantom_key(kp, out, in);
		}
		key_index += kp-&gt;keypad_info-&gt;ninputs;
		out++;
	}
	return rv;
}

static void remove_phantom_keys(struct gpio_kp *kp)
{
	int out, in, inp;
	int key_index;

	if (kp-&gt;some_keys_pressed &lt; 3)
		return;

	for (out = 0; out &lt; kp-&gt;keypad_info-&gt;noutputs; out++) {
		inp = -1;
		key_index = out * kp-&gt;keypad_info-&gt;ninputs;
		for (in = 0; in &lt; kp-&gt;keypad_info-&gt;ninputs; in++, key_index++) {
			if (test_bit(key_index, kp-&gt;keys_pressed)) {
				if (inp == -1) {
					inp = in;
					continue;
				}
				if (inp &gt;= 0) {
					if (!restore_keys_for_input(kp, out + 1,
									inp))
						break;
					clear_phantom_key(kp, out, inp);
					inp = -2;
				}
				restore_keys_for_input(kp, out, in);
			}
		}
	}
}

static void report_key(struct gpio_kp *kp, int key_index, int out, int in)
{
	struct gpio_event_matrix_info *mi = kp-&gt;keypad_info;
	int pressed = test_bit(key_index, kp-&gt;keys_pressed);
	unsigned short keyentry = mi-&gt;keymap[key_index];
	unsigned short keycode = keyentry &amp; MATRIX_KEY_MASK;
	unsigned short dev = keyentry &gt;&gt; MATRIX_CODE_BITS;

	if (pressed != test_bit(keycode, kp-&gt;input_devs-&gt;dev[dev]-&gt;key)) {
		if (keycode == KEY_RESERVED) {
			if (mi-&gt;flags &amp; GPIOKPF_PRINT_UNMAPPED_KEYS)
				pr_info(&quot;gpiomatrix: unmapped key, %d-%d &quot;
					&quot;(%d-%d) changed to %d\n&quot;,
					out, in, mi-&gt;output_gpios[out],
					mi-&gt;input_gpios[in], pressed);
		} else {
			if (mi-&gt;flags &amp; GPIOKPF_PRINT_MAPPED_KEYS)
				pr_info(&quot;gpiomatrix: key %x, %d-%d (%d-%d) &quot;
					&quot;changed to %d\n&quot;, keycode,
					out, in, mi-&gt;output_gpios[out],
					mi-&gt;input_gpios[in], pressed);
			input_report_key(kp-&gt;input_devs-&gt;dev[dev], keycode, pressed);
		}
	}
}

static void report_sync(struct gpio_kp *kp)
{
	int i;

	for (i = 0; i &lt; kp-&gt;input_devs-&gt;count; i++)
		input_sync(kp-&gt;input_devs-&gt;dev[i]);
}

static enum hrtimer_restart gpio_keypad_timer_func(struct hrtimer *timer)
{
	int out, in;
	int key_index;
	int gpio;
	struct gpio_kp *kp = container_of(timer, struct gpio_kp, timer);
	struct gpio_event_matrix_info *mi = kp-&gt;keypad_info;
	unsigned gpio_keypad_flags = mi-&gt;flags;
	unsigned polarity = !!(gpio_keypad_flags &amp; GPIOKPF_ACTIVE_HIGH);

	out = kp-&gt;current_output;
	if (out == mi-&gt;noutputs) {
		out = 0;
		kp-&gt;last_key_state_changed = kp-&gt;key_state_changed;
		kp-&gt;key_state_changed = 0;
		kp-&gt;some_keys_pressed = 0;
	} else {
		key_index = out * mi-&gt;ninputs;
		for (in = 0; in &lt; mi-&gt;ninputs; in++, key_index++) {
			gpio = mi-&gt;input_gpios[in];
			if (gpio_get_value(gpio) ^ !polarity) {
				if (kp-&gt;some_keys_pressed &lt; 3)
					kp-&gt;some_keys_pressed++;
				kp-&gt;key_state_changed |= !__test_and_set_bit(
						key_index, kp-&gt;keys_pressed);
			} else
				kp-&gt;key_state_changed |= __test_and_clear_bit(
						key_index, kp-&gt;keys_pressed);
		}
		gpio = mi-&gt;output_gpios[out];
		if (gpio_keypad_flags &amp; GPIOKPF_DRIVE_INACTIVE)
			gpio_set_value(gpio, !polarity);
		else
			gpio_direction_input(gpio);
		out++;
	}
	kp-&gt;current_output = out;
	if (out &lt; mi-&gt;noutputs) {
		gpio = mi-&gt;output_gpios[out];
		if (gpio_keypad_flags &amp; GPIOKPF_DRIVE_INACTIVE)
			gpio_set_value(gpio, polarity);
		else
			gpio_direction_output(gpio, polarity);
		hrtimer_start(timer, mi-&gt;settle_time, HRTIMER_MODE_REL);
		return HRTIMER_NORESTART;
	}
	if (gpio_keypad_flags &amp; GPIOKPF_DEBOUNCE) {
		if (kp-&gt;key_state_changed) {
			hrtimer_start(&amp;kp-&gt;timer, mi-&gt;debounce_delay,
				      HRTIMER_MODE_REL);
			return HRTIMER_NORESTART;
		}
		kp-&gt;key_state_changed = kp-&gt;last_key_state_changed;
	}
	if (kp-&gt;key_state_changed) {
		if (gpio_keypad_flags &amp; GPIOKPF_REMOVE_SOME_PHANTOM_KEYS)
			remove_phantom_keys(kp);
		key_index = 0;
		for (out = 0; out &lt; mi-&gt;noutputs; out++)
			for (in = 0; in &lt; mi-&gt;ninputs; in++, key_index++)
				report_key(kp, key_index, out, in);
		report_sync(kp);
	}
	if (!kp-&gt;use_irq || kp-&gt;some_keys_pressed) {
		hrtimer_start(timer, mi-&gt;poll_time, HRTIMER_MODE_REL);
		return HRTIMER_NORESTART;
	}

	/* No keys are pressed, reenable interrupt */
	for (out = 0; out &lt; mi-&gt;noutputs; out++) {
		if (gpio_keypad_flags &amp; GPIOKPF_DRIVE_INACTIVE)
			gpio_set_value(mi-&gt;output_gpios[out], polarity);
		else
			gpio_direction_output(mi-&gt;output_gpios[out], polarity);
	}
	for (in = 0; in &lt; mi-&gt;ninputs; in++)
		enable_irq(gpio_to_irq(mi-&gt;input_gpios[in]));
	wake_unlock(&amp;kp-&gt;wake_lock);
	return HRTIMER_NORESTART;
}

static irqreturn_t gpio_keypad_irq_handler(int irq_in, void *dev_id)
{
	int i;
	struct gpio_kp *kp = dev_id;
	struct gpio_event_matrix_info *mi = kp-&gt;keypad_info;
	unsigned gpio_keypad_flags = mi-&gt;flags;

	if (!kp-&gt;use_irq) {
		/* ignore interrupt while registering the handler */
		kp-&gt;disabled_irq = 1;
		disable_irq_nosync(irq_in);
		return IRQ_HANDLED;
	}

	for (i = 0; i &lt; mi-&gt;ninputs; i++)
		disable_irq_nosync(gpio_to_irq(mi-&gt;input_gpios[i]));
	for (i = 0; i &lt; mi-&gt;noutputs; i++) {
		if (gpio_keypad_flags &amp; GPIOKPF_DRIVE_INACTIVE)
			gpio_set_value(mi-&gt;output_gpios[i],
				!(gpio_keypad_flags &amp; GPIOKPF_ACTIVE_HIGH));
		else
			gpio_direction_input(mi-&gt;output_gpios[i]);
	}
	wake_lock(&amp;kp-&gt;wake_lock);
	hrtimer_start(&amp;kp-&gt;timer, ktime_set(0, 0), HRTIMER_MODE_REL);
	return IRQ_HANDLED;
}

static int gpio_keypad_request_irqs(struct gpio_kp *kp)
{
	int i;
	int err;
	unsigned int irq;
	unsigned long request_flags;
	struct gpio_event_matrix_info *mi = kp-&gt;keypad_info;

	switch (mi-&gt;flags &amp; (GPIOKPF_ACTIVE_HIGH|GPIOKPF_LEVEL_TRIGGERED_IRQ)) {
	default:
		request_flags = IRQF_TRIGGER_FALLING;
		break;
	case GPIOKPF_ACTIVE_HIGH:
		request_flags = IRQF_TRIGGER_RISING;
		break;
	case GPIOKPF_LEVEL_TRIGGERED_IRQ:
		request_flags = IRQF_TRIGGER_LOW;
		break;
	case GPIOKPF_LEVEL_TRIGGERED_IRQ | GPIOKPF_ACTIVE_HIGH:
		request_flags = IRQF_TRIGGER_HIGH;
		break;
	}

	for (i = 0; i &lt; mi-&gt;ninputs; i++) {
		err = irq = gpio_to_irq(mi-&gt;input_gpios[i]);
		if (err &lt; 0)
			goto err_gpio_get_irq_num_failed;
		err = request_irq(irq, gpio_keypad_irq_handler, request_flags,
				  &quot;gpio_kp&quot;, kp);
		if (err) {
			pr_err(&quot;gpiomatrix: request_irq failed for input %d, &quot;
				&quot;irq %d\n&quot;, mi-&gt;input_gpios[i], irq);
			goto err_request_irq_failed;
		}
		err = enable_irq_wake(irq);
		if (err) {
			pr_err(&quot;gpiomatrix: set_irq_wake failed for input %d, &quot;
				&quot;irq %d\n&quot;, mi-&gt;input_gpios[i], irq);
		}
		disable_irq(irq);
		if (kp-&gt;disabled_irq) {
			kp-&gt;disabled_irq = 0;
			enable_irq(irq);
		}
	}
	return 0;

	for (i = mi-&gt;noutputs - 1; i &gt;= 0; i--) {
		free_irq(gpio_to_irq(mi-&gt;input_gpios[i]), kp);
err_request_irq_failed:
err_gpio_get_irq_num_failed:
		;
	}
	return err;
}

int gpio_event_matrix_func(struct gpio_event_input_devs *input_devs,
	struct gpio_event_info *info, void **data, int func)
{
	int i;
	int err;
	int key_count;
	struct gpio_kp *kp;
	struct gpio_event_matrix_info *mi;

	mi = container_of(info, struct gpio_event_matrix_info, info);
	if (func == GPIO_EVENT_FUNC_SUSPEND || func == GPIO_EVENT_FUNC_RESUME) {
		/* TODO: disable scanning */
		return 0;
	}

	if (func == GPIO_EVENT_FUNC_INIT) {
		if (mi-&gt;keymap == NULL ||
		   mi-&gt;input_gpios == NULL ||
		   mi-&gt;output_gpios == NULL) {
			err = -ENODEV;
			pr_err(&quot;gpiomatrix: Incomplete pdata\n&quot;);
			goto err_invalid_platform_data;
		}
		key_count = mi-&gt;ninputs * mi-&gt;noutputs;

		*data = kp = kzalloc(sizeof(*kp) + sizeof(kp-&gt;keys_pressed[0]) *
				     BITS_TO_LONGS(key_count), GFP_KERNEL);
		if (kp == NULL) {
			err = -ENOMEM;
			pr_err(&quot;gpiomatrix: Failed to allocate private data\n&quot;);
			goto err_kp_alloc_failed;
		}
		kp-&gt;input_devs = input_devs;
		kp-&gt;keypad_info = mi;
		for (i = 0; i &lt; key_count; i++) {
			unsigned short keyentry = mi-&gt;keymap[i];
			unsigned short keycode = keyentry &amp; MATRIX_KEY_MASK;
			unsigned short dev = keyentry &gt;&gt; MATRIX_CODE_BITS;
			if (dev &gt;= input_devs-&gt;count) {
				pr_err(&quot;gpiomatrix: bad device index %d &gt;= &quot;
					&quot;%d for key code %d\n&quot;,
					dev, input_devs-&gt;count, keycode);
				err = -EINVAL;
				goto err_bad_keymap;
			}
			if (keycode &amp;&amp; keycode &lt;= KEY_MAX)
				input_set_capability(input_devs-&gt;dev[dev],
							EV_KEY, keycode);
		}

		for (i = 0; i &lt; mi-&gt;noutputs; i++) {
			err = gpio_request(mi-&gt;output_gpios[i], &quot;gpio_kp_out&quot;);
			if (err) {
				pr_err(&quot;gpiomatrix: gpio_request failed for &quot;
					&quot;output %d\n&quot;, mi-&gt;output_gpios[i]);
				goto err_request_output_gpio_failed;
			}
			if (gpio_cansleep(mi-&gt;output_gpios[i])) {
				pr_err(&quot;gpiomatrix: unsupported output gpio %d,&quot;
					&quot; can sleep\n&quot;, mi-&gt;output_gpios[i]);
				err = -EINVAL;
				goto err_output_gpio_configure_failed;
			}
			if (mi-&gt;flags &amp; GPIOKPF_DRIVE_INACTIVE)
				err = gpio_direction_output(mi-&gt;output_gpios[i],
					!(mi-&gt;flags &amp; GPIOKPF_ACTIVE_HIGH));
			else
				err = gpio_direction_input(mi-&gt;output_gpios[i]);
			if (err) {
				pr_err(&quot;gpiomatrix: gpio_configure failed for &quot;
					&quot;output %d\n&quot;, mi-&gt;output_gpios[i]);
				goto err_output_gpio_configure_failed;
			}
		}
		for (i = 0; i &lt; mi-&gt;ninputs; i++) {
			err = gpio_request(mi-&gt;input_gpios[i], &quot;gpio_kp_in&quot;);
			if (err) {
				pr_err(&quot;gpiomatrix: gpio_request failed for &quot;
					&quot;input %d\n&quot;, mi-&gt;input_gpios[i]);
				goto err_request_input_gpio_failed;
			}
			err = gpio_direction_input(mi-&gt;input_gpios[i]);
			if (err) {
				pr_err(&quot;gpiomatrix: gpio_direction_input failed&quot;
					&quot; for input %d\n&quot;, mi-&gt;input_gpios[i]);
				goto err_gpio_direction_input_failed;
			}
		}
		kp-&gt;current_output = mi-&gt;noutputs;
		kp-&gt;key_state_changed = 1;

		hrtimer_init(&amp;kp-&gt;timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
		kp-&gt;timer.function = gpio_keypad_timer_func;
		wake_lock_init(&amp;kp-&gt;wake_lock, WAKE_LOCK_SUSPEND, &quot;gpio_kp&quot;);
		err = gpio_keypad_request_irqs(kp);
		kp-&gt;use_irq = err == 0;

		pr_info(&quot;GPIO Matrix Keypad Driver: Start keypad matrix for &quot;
			&quot;%s%s in %s mode\n&quot;, input_devs-&gt;dev[0]-&gt;name,
			(input_devs-&gt;count &gt; 1) ? &quot;...&quot; : &quot;&quot;,
			kp-&gt;use_irq ? &quot;interrupt&quot; : &quot;polling&quot;);

		if (kp-&gt;use_irq)
			wake_lock(&amp;kp-&gt;wake_lock);
		hrtimer_start(&amp;kp-&gt;timer, ktime_set(0, 0), HRTIMER_MODE_REL);

		return 0;
	}

	err = 0;
	kp = *data;

	if (kp-&gt;use_irq)
		for (i = mi-&gt;noutputs - 1; i &gt;= 0; i--)
			free_irq(gpio_to_irq(mi-&gt;input_gpios[i]), kp);

	hrtimer_cancel(&amp;kp-&gt;timer);
	wake_lock_destroy(&amp;kp-&gt;wake_lock);
	for (i = mi-&gt;noutputs - 1; i &gt;= 0; i--) {
err_gpio_direction_input_failed:
		gpio_free(mi-&gt;input_gpios[i]);
err_request_input_gpio_failed:
		;
	}
	for (i = mi-&gt;noutputs - 1; i &gt;= 0; i--) {
err_output_gpio_configure_failed:
		gpio_free(mi-&gt;output_gpios[i]);
err_request_output_gpio_failed:
		;
	}
err_bad_keymap:
	kfree(kp);
err_kp_alloc_failed:
err_invalid_platform_data:
	return err;
}
</pre><div class="footer">Powered by <a href="https://code.google.com/p/gitiles/">Gitiles</a></div></body></html>
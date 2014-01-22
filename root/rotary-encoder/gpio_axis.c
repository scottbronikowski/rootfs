<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title>drivers/input/misc/gpio_axis.c - kernel/omap - Git at Google</title><link rel="stylesheet" type="text/css" href="//www.google.com/css/go.css" /><link rel="stylesheet" type="text/css" href="/+static/prettify/prettify.vf-M93Ay4IiiWRQSJKPGWQ.cache.css" /><link rel="stylesheet" type="text/css" href="/+static/gitiles.crLPUWVIreWn55oryoTFfA.cache.css" /><script src="/+static/prettify/prettify_compiled.GHRTDQJlSdpNotJivTmj9w.cache.js" type="text/javascript"></script></head><body onload="prettyPrint()"><h1><img src="//www.google.com/images/logo_sm.gif" alt="Google" />Git</h1><div class="menu"> <a href="https://www.google.com/a/SelectSession?service=gerritcodereview&amp;continue=https://android.googlesource.com/login/kernel/omap/%2B/glass-omap-xrr02/drivers/input/misc/gpio_axis.c">Sign in</a> </div><div class="breadcrumbs"><a href="/?format=HTML">android</a> / <a href="/kernel/omap/">kernel/omap</a> / <a href="/kernel/omap/+/glass-omap-xrr02">glass-omap-xrr02</a> / <a href="/kernel/omap/+/glass-omap-xrr02/">.</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers">drivers</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input">input</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input/misc">misc</a> / gpio_axis.c</div><div class="sha1">blob: 0acf4a576f53a2df35c0574dfda4019d6ebaa2e1 [<a href="/kernel/omap/+log/glass-omap-xrr02/drivers/input/misc/gpio_axis.c">file history</a>]</div><pre class="git-blob prettyprint linenums lang-c">/* drivers/input/misc/gpio_axis.c
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
#include &lt;linux/interrupt.h&gt;
#include &lt;linux/slab.h&gt;

struct gpio_axis_state {
	struct gpio_event_input_devs *input_devs;
	struct gpio_event_axis_info *info;
	uint32_t pos;
};

uint16_t gpio_axis_4bit_gray_map_table[] = {
	[0x0] = 0x0, [0x1] = 0x1, /* 0000 0001 */
	[0x3] = 0x2, [0x2] = 0x3, /* 0011 0010 */
	[0x6] = 0x4, [0x7] = 0x5, /* 0110 0111 */
	[0x5] = 0x6, [0x4] = 0x7, /* 0101 0100 */
	[0xc] = 0x8, [0xd] = 0x9, /* 1100 1101 */
	[0xf] = 0xa, [0xe] = 0xb, /* 1111 1110 */
	[0xa] = 0xc, [0xb] = 0xd, /* 1010 1011 */
	[0x9] = 0xe, [0x8] = 0xf, /* 1001 1000 */
};
uint16_t gpio_axis_4bit_gray_map(struct gpio_event_axis_info *info, uint16_t in)
{
	return gpio_axis_4bit_gray_map_table[in];
}

uint16_t gpio_axis_5bit_singletrack_map_table[] = {
	[0x10] = 0x00, [0x14] = 0x01, [0x1c] = 0x02, /*     10000 10100 11100 */
	[0x1e] = 0x03, [0x1a] = 0x04, [0x18] = 0x05, /*     11110 11010 11000 */
	[0x08] = 0x06, [0x0a] = 0x07, [0x0e] = 0x08, /*    01000 01010 01110  */
	[0x0f] = 0x09, [0x0d] = 0x0a, [0x0c] = 0x0b, /*    01111 01101 01100  */
	[0x04] = 0x0c, [0x05] = 0x0d, [0x07] = 0x0e, /*   00100 00101 00111   */
	[0x17] = 0x0f, [0x16] = 0x10, [0x06] = 0x11, /*   10111 10110 00110   */
	[0x02] = 0x12, [0x12] = 0x13, [0x13] = 0x14, /*  00010 10010 10011    */
	[0x1b] = 0x15, [0x0b] = 0x16, [0x03] = 0x17, /*  11011 01011 00011    */
	[0x01] = 0x18, [0x09] = 0x19, [0x19] = 0x1a, /* 00001 01001 11001     */
	[0x1d] = 0x1b, [0x15] = 0x1c, [0x11] = 0x1d, /* 11101 10101 10001     */
};
uint16_t gpio_axis_5bit_singletrack_map(
	struct gpio_event_axis_info *info, uint16_t in)
{
	return gpio_axis_5bit_singletrack_map_table[in];
}

static void gpio_event_update_axis(struct gpio_axis_state *as, int report)
{
	struct gpio_event_axis_info *ai = as-&gt;info;
	int i;
	int change;
	uint16_t state = 0;
	uint16_t pos;
	uint16_t old_pos = as-&gt;pos;
	for (i = ai-&gt;count - 1; i &gt;= 0; i--)
		state = (state &lt;&lt; 1) | gpio_get_value(ai-&gt;gpio[i]);
	pos = ai-&gt;map(ai, state);
	if (ai-&gt;flags &amp; GPIOEAF_PRINT_RAW)
		pr_info(&quot;axis %d-%d raw %x, pos %d -&gt; %d\n&quot;,
			ai-&gt;type, ai-&gt;code, state, old_pos, pos);
	if (report &amp;&amp; pos != old_pos) {
		if (ai-&gt;type == EV_REL) {
			change = (ai-&gt;decoded_size + pos - old_pos) %
				  ai-&gt;decoded_size;
			if (change &gt; ai-&gt;decoded_size / 2)
				change -= ai-&gt;decoded_size;
			if (change == ai-&gt;decoded_size / 2) {
				if (ai-&gt;flags &amp; GPIOEAF_PRINT_EVENT)
					pr_info(&quot;axis %d-%d unknown direction, &quot;
						&quot;pos %d -&gt; %d\n&quot;, ai-&gt;type,
						ai-&gt;code, old_pos, pos);
				change = 0; /* no closest direction */
			}
			if (ai-&gt;flags &amp; GPIOEAF_PRINT_EVENT)
				pr_info(&quot;axis %d-%d change %d\n&quot;,
					ai-&gt;type, ai-&gt;code, change);
			input_report_rel(as-&gt;input_devs-&gt;dev[ai-&gt;dev],
						ai-&gt;code, change);
		} else {
			if (ai-&gt;flags &amp; GPIOEAF_PRINT_EVENT)
				pr_info(&quot;axis %d-%d now %d\n&quot;,
					ai-&gt;type, ai-&gt;code, pos);
			input_event(as-&gt;input_devs-&gt;dev[ai-&gt;dev],
					ai-&gt;type, ai-&gt;code, pos);
		}
		input_sync(as-&gt;input_devs-&gt;dev[ai-&gt;dev]);
	}
	as-&gt;pos = pos;
}

static irqreturn_t gpio_axis_irq_handler(int irq, void *dev_id)
{
	struct gpio_axis_state *as = dev_id;
	gpio_event_update_axis(as, 1);
	return IRQ_HANDLED;
}

int gpio_event_axis_func(struct gpio_event_input_devs *input_devs,
			 struct gpio_event_info *info, void **data, int func)
{
	int ret;
	int i;
	int irq;
	struct gpio_event_axis_info *ai;
	struct gpio_axis_state *as;

	ai = container_of(info, struct gpio_event_axis_info, info);
	if (func == GPIO_EVENT_FUNC_SUSPEND) {
		for (i = 0; i &lt; ai-&gt;count; i++)
			disable_irq(gpio_to_irq(ai-&gt;gpio[i]));
		return 0;
	}
	if (func == GPIO_EVENT_FUNC_RESUME) {
		for (i = 0; i &lt; ai-&gt;count; i++)
			enable_irq(gpio_to_irq(ai-&gt;gpio[i]));
		return 0;
	}

	if (func == GPIO_EVENT_FUNC_INIT) {
		*data = as = kmalloc(sizeof(*as), GFP_KERNEL);
		if (as == NULL) {
			ret = -ENOMEM;
			goto err_alloc_axis_state_failed;
		}
		as-&gt;input_devs = input_devs;
		as-&gt;info = ai;
		if (ai-&gt;dev &gt;= input_devs-&gt;count) {
			pr_err(&quot;gpio_event_axis: bad device index %d &gt;= %d &quot;
				&quot;for %d:%d\n&quot;, ai-&gt;dev, input_devs-&gt;count,
				ai-&gt;type, ai-&gt;code);
			ret = -EINVAL;
			goto err_bad_device_index;
		}

		input_set_capability(input_devs-&gt;dev[ai-&gt;dev],
				     ai-&gt;type, ai-&gt;code);
		if (ai-&gt;type == EV_ABS) {
			input_set_abs_params(input_devs-&gt;dev[ai-&gt;dev], ai-&gt;code,
					     0, ai-&gt;decoded_size - 1, 0, 0);
		}
		for (i = 0; i &lt; ai-&gt;count; i++) {
			ret = gpio_request(ai-&gt;gpio[i], &quot;gpio_event_axis&quot;);
			if (ret &lt; 0)
				goto err_request_gpio_failed;
			ret = gpio_direction_input(ai-&gt;gpio[i]);
			if (ret &lt; 0)
				goto err_gpio_direction_input_failed;
			ret = irq = gpio_to_irq(ai-&gt;gpio[i]);
			if (ret &lt; 0)
				goto err_get_irq_num_failed;
			ret = request_irq(irq, gpio_axis_irq_handler,
					  IRQF_TRIGGER_RISING |
					  IRQF_TRIGGER_FALLING,
					  &quot;gpio_event_axis&quot;, as);
			if (ret &lt; 0)
				goto err_request_irq_failed;
		}
		gpio_event_update_axis(as, 0);
		return 0;
	}

	ret = 0;
	as = *data;
	for (i = ai-&gt;count - 1; i &gt;= 0; i--) {
		free_irq(gpio_to_irq(ai-&gt;gpio[i]), as);
err_request_irq_failed:
err_get_irq_num_failed:
err_gpio_direction_input_failed:
		gpio_free(ai-&gt;gpio[i]);
err_request_gpio_failed:
		;
	}
err_bad_device_index:
	kfree(as);
	*data = NULL;
err_alloc_axis_state_failed:
	return ret;
}
</pre><div class="footer">Powered by <a href="https://code.google.com/p/gitiles/">Gitiles</a></div></body></html>
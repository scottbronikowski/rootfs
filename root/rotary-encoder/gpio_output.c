<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title>drivers/input/misc/gpio_output.c - kernel/omap - Git at Google</title><link rel="stylesheet" type="text/css" href="//www.google.com/css/go.css" /><link rel="stylesheet" type="text/css" href="/+static/prettify/prettify.vf-M93Ay4IiiWRQSJKPGWQ.cache.css" /><link rel="stylesheet" type="text/css" href="/+static/gitiles.crLPUWVIreWn55oryoTFfA.cache.css" /><script src="/+static/prettify/prettify_compiled.GHRTDQJlSdpNotJivTmj9w.cache.js" type="text/javascript"></script></head><body onload="prettyPrint()"><h1><img src="//www.google.com/images/logo_sm.gif" alt="Google" />Git</h1><div class="menu"> <a href="https://www.google.com/a/SelectSession?service=gerritcodereview&amp;continue=https://android.googlesource.com/login/kernel/omap/%2B/glass-omap-xrr02/drivers/input/misc/gpio_output.c">Sign in</a> </div><div class="breadcrumbs"><a href="/?format=HTML">android</a> / <a href="/kernel/omap/">kernel/omap</a> / <a href="/kernel/omap/+/glass-omap-xrr02">glass-omap-xrr02</a> / <a href="/kernel/omap/+/glass-omap-xrr02/">.</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers">drivers</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input">input</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input/misc">misc</a> / gpio_output.c</div><div class="sha1">blob: 2aac2fad0a17bff7773bb68d9a04f726f180db5a [<a href="/kernel/omap/+log/glass-omap-xrr02/drivers/input/misc/gpio_output.c">file history</a>]</div><pre class="git-blob prettyprint linenums lang-c">/* drivers/input/misc/gpio_output.c
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

int gpio_event_output_event(
	struct gpio_event_input_devs *input_devs, struct gpio_event_info *info,
	void **data, unsigned int dev, unsigned int type,
	unsigned int code, int value)
{
	int i;
	struct gpio_event_output_info *oi;
	oi = container_of(info, struct gpio_event_output_info, info);
	if (type != oi-&gt;type)
		return 0;
	if (!(oi-&gt;flags &amp; GPIOEDF_ACTIVE_HIGH))
		value = !value;
	for (i = 0; i &lt; oi-&gt;keymap_size; i++)
		if (dev == oi-&gt;keymap[i].dev &amp;&amp; code == oi-&gt;keymap[i].code)
			gpio_set_value(oi-&gt;keymap[i].gpio, value);
	return 0;
}

int gpio_event_output_func(
	struct gpio_event_input_devs *input_devs, struct gpio_event_info *info,
	void **data, int func)
{
	int ret;
	int i;
	struct gpio_event_output_info *oi;
	oi = container_of(info, struct gpio_event_output_info, info);

	if (func == GPIO_EVENT_FUNC_SUSPEND || func == GPIO_EVENT_FUNC_RESUME)
		return 0;

	if (func == GPIO_EVENT_FUNC_INIT) {
		int output_level = !(oi-&gt;flags &amp; GPIOEDF_ACTIVE_HIGH);

		for (i = 0; i &lt; oi-&gt;keymap_size; i++) {
			int dev = oi-&gt;keymap[i].dev;
			if (dev &gt;= input_devs-&gt;count) {
				pr_err(&quot;gpio_event_output_func: bad device &quot;
					&quot;index %d &gt;= %d for key code %d\n&quot;,
					dev, input_devs-&gt;count,
					oi-&gt;keymap[i].code);
				ret = -EINVAL;
				goto err_bad_keymap;
			}
			input_set_capability(input_devs-&gt;dev[dev], oi-&gt;type,
					     oi-&gt;keymap[i].code);
		}

		for (i = 0; i &lt; oi-&gt;keymap_size; i++) {
			ret = gpio_request(oi-&gt;keymap[i].gpio,
					   &quot;gpio_event_output&quot;);
			if (ret) {
				pr_err(&quot;gpio_event_output_func: gpio_request &quot;
					&quot;failed for %d\n&quot;, oi-&gt;keymap[i].gpio);
				goto err_gpio_request_failed;
			}
			ret = gpio_direction_output(oi-&gt;keymap[i].gpio,
						    output_level);
			if (ret) {
				pr_err(&quot;gpio_event_output_func: &quot;
					&quot;gpio_direction_output failed for %d\n&quot;,
					oi-&gt;keymap[i].gpio);
				goto err_gpio_direction_output_failed;
			}
		}
		return 0;
	}

	ret = 0;
	for (i = oi-&gt;keymap_size - 1; i &gt;= 0; i--) {
err_gpio_direction_output_failed:
		gpio_free(oi-&gt;keymap[i].gpio);
err_gpio_request_failed:
		;
	}
err_bad_keymap:
	return ret;
}

</pre><div class="footer">Powered by <a href="https://code.google.com/p/gitiles/">Gitiles</a></div></body></html>
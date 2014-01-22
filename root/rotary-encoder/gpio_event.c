<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title>drivers/input/misc/gpio_event.c - kernel/omap - Git at Google</title><link rel="stylesheet" type="text/css" href="//www.google.com/css/go.css" /><link rel="stylesheet" type="text/css" href="/+static/prettify/prettify.vf-M93Ay4IiiWRQSJKPGWQ.cache.css" /><link rel="stylesheet" type="text/css" href="/+static/gitiles.crLPUWVIreWn55oryoTFfA.cache.css" /><script src="/+static/prettify/prettify_compiled.GHRTDQJlSdpNotJivTmj9w.cache.js" type="text/javascript"></script></head><body onload="prettyPrint()"><h1><img src="//www.google.com/images/logo_sm.gif" alt="Google" />Git</h1><div class="menu"> <a href="https://www.google.com/a/SelectSession?service=gerritcodereview&amp;continue=https://android.googlesource.com/login/kernel/omap/%2B/glass-omap-xrr02/drivers/input/misc/gpio_event.c">Sign in</a> </div><div class="breadcrumbs"><a href="/?format=HTML">android</a> / <a href="/kernel/omap/">kernel/omap</a> / <a href="/kernel/omap/+/glass-omap-xrr02">glass-omap-xrr02</a> / <a href="/kernel/omap/+/glass-omap-xrr02/">.</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers">drivers</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input">input</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input/misc">misc</a> / gpio_event.c</div><div class="sha1">blob: a98be67d1ab0d530b110573d5d688bc970dc7330 [<a href="/kernel/omap/+log/glass-omap-xrr02/drivers/input/misc/gpio_event.c">file history</a>]</div><pre class="git-blob prettyprint linenums lang-c">/* drivers/input/misc/gpio_event.c
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

#include &lt;linux/earlysuspend.h&gt;
#include &lt;linux/module.h&gt;
#include &lt;linux/input.h&gt;
#include &lt;linux/gpio_event.h&gt;
#include &lt;linux/hrtimer.h&gt;
#include &lt;linux/platform_device.h&gt;
#include &lt;linux/slab.h&gt;

struct gpio_event {
	struct gpio_event_input_devs *input_devs;
	const struct gpio_event_platform_data *info;
	struct early_suspend early_suspend;
	void *state[0];
};

static int gpio_input_event(
	struct input_dev *dev, unsigned int type, unsigned int code, int value)
{
	int i;
	int devnr;
	int ret = 0;
	int tmp_ret;
	struct gpio_event_info **ii;
	struct gpio_event *ip = input_get_drvdata(dev);

	for (devnr = 0; devnr &lt; ip-&gt;input_devs-&gt;count; devnr++)
		if (ip-&gt;input_devs-&gt;dev[devnr] == dev)
			break;
	if (devnr == ip-&gt;input_devs-&gt;count) {
		pr_err(&quot;gpio_input_event: unknown device %p\n&quot;, dev);
		return -EIO;
	}

	for (i = 0, ii = ip-&gt;info-&gt;info; i &lt; ip-&gt;info-&gt;info_count; i++, ii++) {
		if ((*ii)-&gt;event) {
			tmp_ret = (*ii)-&gt;event(ip-&gt;input_devs, *ii,
						&amp;ip-&gt;state[i],
						devnr, type, code, value);
			if (tmp_ret)
				ret = tmp_ret;
		}
	}
	return ret;
}

static int gpio_event_call_all_func(struct gpio_event *ip, int func)
{
	int i;
	int ret;
	struct gpio_event_info **ii;

	if (func == GPIO_EVENT_FUNC_INIT || func == GPIO_EVENT_FUNC_RESUME) {
		ii = ip-&gt;info-&gt;info;
		for (i = 0; i &lt; ip-&gt;info-&gt;info_count; i++, ii++) {
			if ((*ii)-&gt;func == NULL) {
				ret = -ENODEV;
				pr_err(&quot;gpio_event_probe: Incomplete pdata, &quot;
					&quot;no function\n&quot;);
				goto err_no_func;
			}
			if (func == GPIO_EVENT_FUNC_RESUME &amp;&amp; (*ii)-&gt;no_suspend)
				continue;
			ret = (*ii)-&gt;func(ip-&gt;input_devs, *ii, &amp;ip-&gt;state[i],
					  func);
			if (ret) {
				pr_err(&quot;gpio_event_probe: function failed\n&quot;);
				goto err_func_failed;
			}
		}
		return 0;
	}

	ret = 0;
	i = ip-&gt;info-&gt;info_count;
	ii = ip-&gt;info-&gt;info + i;
	while (i &gt; 0) {
		i--;
		ii--;
		if ((func &amp; ~1) == GPIO_EVENT_FUNC_SUSPEND &amp;&amp; (*ii)-&gt;no_suspend)
			continue;
		(*ii)-&gt;func(ip-&gt;input_devs, *ii, &amp;ip-&gt;state[i], func &amp; ~1);
err_func_failed:
err_no_func:
		;
	}
	return ret;
}

#ifdef CONFIG_HAS_EARLYSUSPEND
void gpio_event_suspend(struct early_suspend *h)
{
	struct gpio_event *ip;
	ip = container_of(h, struct gpio_event, early_suspend);
	gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_SUSPEND);
	ip-&gt;info-&gt;power(ip-&gt;info, 0);
}

void gpio_event_resume(struct early_suspend *h)
{
	struct gpio_event *ip;
	ip = container_of(h, struct gpio_event, early_suspend);
	ip-&gt;info-&gt;power(ip-&gt;info, 1);
	gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_RESUME);
}
#endif

static int gpio_event_probe(struct platform_device *pdev)
{
	int err;
	struct gpio_event *ip;
	struct gpio_event_platform_data *event_info;
	int dev_count = 1;
	int i;
	int registered = 0;

	event_info = pdev-&gt;dev.platform_data;
	if (event_info == NULL) {
		pr_err(&quot;gpio_event_probe: No pdata\n&quot;);
		return -ENODEV;
	}
	if ((!event_info-&gt;name &amp;&amp; !event_info-&gt;names[0]) ||
	    !event_info-&gt;info || !event_info-&gt;info_count) {
		pr_err(&quot;gpio_event_probe: Incomplete pdata\n&quot;);
		return -ENODEV;
	}
	if (!event_info-&gt;name)
		while (event_info-&gt;names[dev_count])
			dev_count++;
	ip = kzalloc(sizeof(*ip) +
		     sizeof(ip-&gt;state[0]) * event_info-&gt;info_count +
		     sizeof(*ip-&gt;input_devs) +
		     sizeof(ip-&gt;input_devs-&gt;dev[0]) * dev_count, GFP_KERNEL);
	if (ip == NULL) {
		err = -ENOMEM;
		pr_err(&quot;gpio_event_probe: Failed to allocate private data\n&quot;);
		goto err_kp_alloc_failed;
	}
	ip-&gt;input_devs = (void*)&amp;ip-&gt;state[event_info-&gt;info_count];
	platform_set_drvdata(pdev, ip);

	for (i = 0; i &lt; dev_count; i++) {
		struct input_dev *input_dev = input_allocate_device();
		if (input_dev == NULL) {
			err = -ENOMEM;
			pr_err(&quot;gpio_event_probe: &quot;
				&quot;Failed to allocate input device\n&quot;);
			goto err_input_dev_alloc_failed;
		}
		input_set_drvdata(input_dev, ip);
		input_dev-&gt;name = event_info-&gt;name ?
					event_info-&gt;name : event_info-&gt;names[i];
		input_dev-&gt;event = gpio_input_event;
		ip-&gt;input_devs-&gt;dev[i] = input_dev;
	}
	ip-&gt;input_devs-&gt;count = dev_count;
	ip-&gt;info = event_info;
	if (event_info-&gt;power) {
#ifdef CONFIG_HAS_EARLYSUSPEND
		ip-&gt;early_suspend.level = EARLY_SUSPEND_LEVEL_BLANK_SCREEN + 1;
		ip-&gt;early_suspend.suspend = gpio_event_suspend;
		ip-&gt;early_suspend.resume = gpio_event_resume;
		register_early_suspend(&amp;ip-&gt;early_suspend);
#endif
		ip-&gt;info-&gt;power(ip-&gt;info, 1);
	}

	err = gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_INIT);
	if (err)
		goto err_call_all_func_failed;

	for (i = 0; i &lt; dev_count; i++) {
		err = input_register_device(ip-&gt;input_devs-&gt;dev[i]);
		if (err) {
			pr_err(&quot;gpio_event_probe: Unable to register %s &quot;
				&quot;input device\n&quot;, ip-&gt;input_devs-&gt;dev[i]-&gt;name);
			goto err_input_register_device_failed;
		}
		registered++;
	}

	return 0;

err_input_register_device_failed:
	gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_UNINIT);
err_call_all_func_failed:
	if (event_info-&gt;power) {
#ifdef CONFIG_HAS_EARLYSUSPEND
		unregister_early_suspend(&amp;ip-&gt;early_suspend);
#endif
		ip-&gt;info-&gt;power(ip-&gt;info, 0);
	}
	for (i = 0; i &lt; registered; i++)
		input_unregister_device(ip-&gt;input_devs-&gt;dev[i]);
	for (i = dev_count - 1; i &gt;= registered; i--) {
		input_free_device(ip-&gt;input_devs-&gt;dev[i]);
err_input_dev_alloc_failed:
		;
	}
	kfree(ip);
err_kp_alloc_failed:
	return err;
}

static int gpio_event_remove(struct platform_device *pdev)
{
	struct gpio_event *ip = platform_get_drvdata(pdev);
	int i;

	gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_UNINIT);
	if (ip-&gt;info-&gt;power) {
#ifdef CONFIG_HAS_EARLYSUSPEND
		unregister_early_suspend(&amp;ip-&gt;early_suspend);
#endif
		ip-&gt;info-&gt;power(ip-&gt;info, 0);
	}
	for (i = 0; i &lt; ip-&gt;input_devs-&gt;count; i++)
		input_unregister_device(ip-&gt;input_devs-&gt;dev[i]);
	kfree(ip);
	return 0;
}

static struct platform_driver gpio_event_driver = {
	.probe		= gpio_event_probe,
	.remove		= gpio_event_remove,
	.driver		= {
		.name	= GPIO_EVENT_DEV_NAME,
	},
};

static int __devinit gpio_event_init(void)
{
	return platform_driver_register(&amp;gpio_event_driver);
}

static void __exit gpio_event_exit(void)
{
	platform_driver_unregister(&amp;gpio_event_driver);
}

module_init(gpio_event_init);
module_exit(gpio_event_exit);

MODULE_DESCRIPTION(&quot;GPIO Event Driver&quot;);
MODULE_LICENSE(&quot;GPL&quot;);

</pre><div class="footer">Powered by <a href="https://code.google.com/p/gitiles/">Gitiles</a></div></body></html>
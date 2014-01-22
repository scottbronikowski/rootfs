<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title>drivers/input/misc/bfin_rotary.c - kernel/omap - Git at Google</title><link rel="stylesheet" type="text/css" href="//www.google.com/css/go.css" /><link rel="stylesheet" type="text/css" href="/+static/prettify/prettify.vf-M93Ay4IiiWRQSJKPGWQ.cache.css" /><link rel="stylesheet" type="text/css" href="/+static/gitiles.crLPUWVIreWn55oryoTFfA.cache.css" /><script src="/+static/prettify/prettify_compiled.GHRTDQJlSdpNotJivTmj9w.cache.js" type="text/javascript"></script></head><body onload="prettyPrint()"><h1><img src="//www.google.com/images/logo_sm.gif" alt="Google" />Git</h1><div class="menu"> <a href="https://www.google.com/a/SelectSession?service=gerritcodereview&amp;continue=https://android.googlesource.com/login/kernel/omap/%2B/glass-omap-xrr02/drivers/input/misc/bfin_rotary.c">Sign in</a> </div><div class="breadcrumbs"><a href="/?format=HTML">android</a> / <a href="/kernel/omap/">kernel/omap</a> / <a href="/kernel/omap/+/glass-omap-xrr02">glass-omap-xrr02</a> / <a href="/kernel/omap/+/glass-omap-xrr02/">.</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers">drivers</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input">input</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input/misc">misc</a> / bfin_rotary.c</div><div class="sha1">blob: 4f72bdd694102eb626011956d1b3b642d6d1ae63 [<a href="/kernel/omap/+log/glass-omap-xrr02/drivers/input/misc/bfin_rotary.c">file history</a>]</div><pre class="git-blob prettyprint linenums lang-c">/*
 * Rotary counter driver for Analog Devices Blackfin Processors
 *
 * Copyright 2008-2009 Analog Devices Inc.
 * Licensed under the GPL-2 or later.
 */

#include &lt;linux/module.h&gt;
#include &lt;linux/version.h&gt;
#include &lt;linux/init.h&gt;
#include &lt;linux/interrupt.h&gt;
#include &lt;linux/irq.h&gt;
#include &lt;linux/pm.h&gt;
#include &lt;linux/platform_device.h&gt;
#include &lt;linux/input.h&gt;
#include &lt;linux/slab.h&gt;

#include &lt;asm/portmux.h&gt;
#include &lt;asm/bfin_rotary.h&gt;

static const u16 per_cnt[] = {
	P_CNT_CUD,
	P_CNT_CDG,
	P_CNT_CZM,
	0
};

struct bfin_rot {
	struct input_dev *input;
	int irq;
	unsigned int up_key;
	unsigned int down_key;
	unsigned int button_key;
	unsigned int rel_code;
	unsigned short cnt_config;
	unsigned short cnt_imask;
	unsigned short cnt_debounce;
};

static void report_key_event(struct input_dev *input, int keycode)
{
	/* simulate a press-n-release */
	input_report_key(input, keycode, 1);
	input_sync(input);
	input_report_key(input, keycode, 0);
	input_sync(input);
}

static void report_rotary_event(struct bfin_rot *rotary, int delta)
{
	struct input_dev *input = rotary-&gt;input;

	if (rotary-&gt;up_key) {
		report_key_event(input,
				 delta &gt; 0 ? rotary-&gt;up_key : rotary-&gt;down_key);
	} else {
		input_report_rel(input, rotary-&gt;rel_code, delta);
		input_sync(input);
	}
}

static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
{
	struct platform_device *pdev = dev_id;
	struct bfin_rot *rotary = platform_get_drvdata(pdev);
	int delta;

	switch (bfin_read_CNT_STATUS()) {

	case ICII:
		break;

	case UCII:
	case DCII:
		delta = bfin_read_CNT_COUNTER();
		if (delta)
			report_rotary_event(rotary, delta);
		break;

	case CZMII:
		report_key_event(rotary-&gt;input, rotary-&gt;button_key);
		break;

	default:
		break;
	}

	bfin_write_CNT_COMMAND(W1LCNT_ZERO);	/* Clear COUNTER */
	bfin_write_CNT_STATUS(-1);	/* Clear STATUS */

	return IRQ_HANDLED;
}

static int __devinit bfin_rotary_probe(struct platform_device *pdev)
{
	struct bfin_rotary_platform_data *pdata = pdev-&gt;dev.platform_data;
	struct bfin_rot *rotary;
	struct input_dev *input;
	int error;

	/* Basic validation */
	if ((pdata-&gt;rotary_up_key &amp;&amp; !pdata-&gt;rotary_down_key) ||
	    (!pdata-&gt;rotary_up_key &amp;&amp; pdata-&gt;rotary_down_key)) {
		return -EINVAL;
	}

	error = peripheral_request_list(per_cnt, dev_name(&amp;pdev-&gt;dev));
	if (error) {
		dev_err(&amp;pdev-&gt;dev, &quot;requesting peripherals failed\n&quot;);
		return error;
	}

	rotary = kzalloc(sizeof(struct bfin_rot), GFP_KERNEL);
	input = input_allocate_device();
	if (!rotary || !input) {
		error = -ENOMEM;
		goto out1;
	}

	rotary-&gt;input = input;

	rotary-&gt;up_key = pdata-&gt;rotary_up_key;
	rotary-&gt;down_key = pdata-&gt;rotary_down_key;
	rotary-&gt;button_key = pdata-&gt;rotary_button_key;
	rotary-&gt;rel_code = pdata-&gt;rotary_rel_code;

	error = rotary-&gt;irq = platform_get_irq(pdev, 0);
	if (error &lt; 0)
		goto out1;

	input-&gt;name = pdev-&gt;name;
	input-&gt;phys = &quot;bfin-rotary/input0&quot;;
	input-&gt;dev.parent = &amp;pdev-&gt;dev;

	input_set_drvdata(input, rotary);

	input-&gt;id.bustype = BUS_HOST;
	input-&gt;id.vendor = 0x0001;
	input-&gt;id.product = 0x0001;
	input-&gt;id.version = 0x0100;

	if (rotary-&gt;up_key) {
		__set_bit(EV_KEY, input-&gt;evbit);
		__set_bit(rotary-&gt;up_key, input-&gt;keybit);
		__set_bit(rotary-&gt;down_key, input-&gt;keybit);
	} else {
		__set_bit(EV_REL, input-&gt;evbit);
		__set_bit(rotary-&gt;rel_code, input-&gt;relbit);
	}

	if (rotary-&gt;button_key) {
		__set_bit(EV_KEY, input-&gt;evbit);
		__set_bit(rotary-&gt;button_key, input-&gt;keybit);
	}

	error = request_irq(rotary-&gt;irq, bfin_rotary_isr,
			    0, dev_name(&amp;pdev-&gt;dev), pdev);
	if (error) {
		dev_err(&amp;pdev-&gt;dev,
			&quot;unable to claim irq %d; error %d\n&quot;,
			rotary-&gt;irq, error);
		goto out1;
	}

	error = input_register_device(input);
	if (error) {
		dev_err(&amp;pdev-&gt;dev,
			&quot;unable to register input device (%d)\n&quot;, error);
		goto out2;
	}

	if (pdata-&gt;rotary_button_key)
		bfin_write_CNT_IMASK(CZMIE);

	if (pdata-&gt;mode &amp; ROT_DEBE)
		bfin_write_CNT_DEBOUNCE(pdata-&gt;debounce &amp; DPRESCALE);

	if (pdata-&gt;mode)
		bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() |
					(pdata-&gt;mode &amp; ~CNTE));

	bfin_write_CNT_IMASK(bfin_read_CNT_IMASK() | UCIE | DCIE);
	bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() | CNTE);

	platform_set_drvdata(pdev, rotary);
	device_init_wakeup(&amp;pdev-&gt;dev, 1);

	return 0;

out2:
	free_irq(rotary-&gt;irq, pdev);
out1:
	input_free_device(input);
	kfree(rotary);
	peripheral_free_list(per_cnt);

	return error;
}

static int __devexit bfin_rotary_remove(struct platform_device *pdev)
{
	struct bfin_rot *rotary = platform_get_drvdata(pdev);

	bfin_write_CNT_CONFIG(0);
	bfin_write_CNT_IMASK(0);

	free_irq(rotary-&gt;irq, pdev);
	input_unregister_device(rotary-&gt;input);
	peripheral_free_list(per_cnt);

	kfree(rotary);
	platform_set_drvdata(pdev, NULL);

	return 0;
}

#ifdef CONFIG_PM
static int bfin_rotary_suspend(struct device *dev)
{
	struct platform_device *pdev = to_platform_device(dev);
	struct bfin_rot *rotary = platform_get_drvdata(pdev);

	rotary-&gt;cnt_config = bfin_read_CNT_CONFIG();
	rotary-&gt;cnt_imask = bfin_read_CNT_IMASK();
	rotary-&gt;cnt_debounce = bfin_read_CNT_DEBOUNCE();

	if (device_may_wakeup(&amp;pdev-&gt;dev))
		enable_irq_wake(rotary-&gt;irq);

	return 0;
}

static int bfin_rotary_resume(struct device *dev)
{
	struct platform_device *pdev = to_platform_device(dev);
	struct bfin_rot *rotary = platform_get_drvdata(pdev);

	bfin_write_CNT_DEBOUNCE(rotary-&gt;cnt_debounce);
	bfin_write_CNT_IMASK(rotary-&gt;cnt_imask);
	bfin_write_CNT_CONFIG(rotary-&gt;cnt_config &amp; ~CNTE);

	if (device_may_wakeup(&amp;pdev-&gt;dev))
		disable_irq_wake(rotary-&gt;irq);

	if (rotary-&gt;cnt_config &amp; CNTE)
		bfin_write_CNT_CONFIG(rotary-&gt;cnt_config);

	return 0;
}

static const struct dev_pm_ops bfin_rotary_pm_ops = {
	.suspend	= bfin_rotary_suspend,
	.resume		= bfin_rotary_resume,
};
#endif

static struct platform_driver bfin_rotary_device_driver = {
	.probe		= bfin_rotary_probe,
	.remove		= __devexit_p(bfin_rotary_remove),
	.driver		= {
		.name	= &quot;bfin-rotary&quot;,
		.owner	= THIS_MODULE,
#ifdef CONFIG_PM
		.pm	= &amp;bfin_rotary_pm_ops,
#endif
	},
};

static int __init bfin_rotary_init(void)
{
	return platform_driver_register(&amp;bfin_rotary_device_driver);
}
module_init(bfin_rotary_init);

static void __exit bfin_rotary_exit(void)
{
	platform_driver_unregister(&amp;bfin_rotary_device_driver);
}
module_exit(bfin_rotary_exit);

MODULE_LICENSE(&quot;GPL&quot;);
MODULE_AUTHOR(&quot;Michael Hennerich &lt;hennerich@blackfin.uclinux.org&gt;&quot;);
MODULE_DESCRIPTION(&quot;Rotary Counter driver for Blackfin Processors&quot;);
MODULE_ALIAS(&quot;platform:bfin-rotary&quot;);
</pre><div class="footer">Powered by <a href="https://code.google.com/p/gitiles/">Gitiles</a></div></body></html>
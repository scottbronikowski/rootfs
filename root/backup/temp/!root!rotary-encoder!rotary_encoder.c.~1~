<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title>drivers/input/misc/rotary_encoder.c - kernel/omap - Git at Google</title><link rel="stylesheet" type="text/css" href="//www.google.com/css/go.css" /><link rel="stylesheet" type="text/css" href="/+static/prettify/prettify.vf-M93Ay4IiiWRQSJKPGWQ.cache.css" /><link rel="stylesheet" type="text/css" href="/+static/gitiles.crLPUWVIreWn55oryoTFfA.cache.css" /><script src="/+static/prettify/prettify_compiled.GHRTDQJlSdpNotJivTmj9w.cache.js" type="text/javascript"></script></head><body onload="prettyPrint()"><h1><img src="//www.google.com/images/logo_sm.gif" alt="Google" />Git</h1><div class="menu"> <a href="https://www.google.com/a/SelectSession?service=gerritcodereview&amp;continue=https://android.googlesource.com/login/kernel/omap/%2B/glass-omap-xrr02/drivers/input/misc/rotary_encoder.c">Sign in</a> </div><div class="breadcrumbs"><a href="/?format=HTML">android</a> / <a href="/kernel/omap/">kernel/omap</a> / <a href="/kernel/omap/+/glass-omap-xrr02">glass-omap-xrr02</a> / <a href="/kernel/omap/+/glass-omap-xrr02/">.</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers">drivers</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input">input</a> / <a href="/kernel/omap/+/glass-omap-xrr02/drivers/input/misc">misc</a> / rotary_encoder.c</div><div class="sha1">blob: 2c8b84dd9dacca5bac905810fbf3cc452ad0541a [<a href="/kernel/omap/+log/glass-omap-xrr02/drivers/input/misc/rotary_encoder.c">file history</a>]</div><pre class="git-blob prettyprint linenums lang-c">/*
 * rotary_encoder.c
 *
 * (c) 2009 Daniel Mack &lt;daniel@caiaq.de&gt;
 * Copyright (C) 2011 Johan Hovold &lt;jhovold@gmail.com&gt;
 *
 * state machine code inspired by code from Tim Ruetz
 *
 * A generic driver for rotary encoders connected to GPIO lines.
 * See file:Documentation/input/rotary_encoder.txt for more information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include &lt;linux/kernel.h&gt;
#include &lt;linux/module.h&gt;
#include &lt;linux/init.h&gt;
#include &lt;linux/interrupt.h&gt;
#include &lt;linux/input.h&gt;
#include &lt;linux/device.h&gt;
#include &lt;linux/platform_device.h&gt;
#include &lt;linux/gpio.h&gt;
#include &lt;linux/rotary_encoder.h&gt;
#include &lt;linux/slab.h&gt;

#define DRV_NAME &quot;rotary-encoder&quot;

struct rotary_encoder {
	struct input_dev *input;
	struct rotary_encoder_platform_data *pdata;

	unsigned int axis;
	unsigned int pos;

	unsigned int irq_a;
	unsigned int irq_b;

	bool armed;
	unsigned char dir;	/* 0 - clockwise, 1 - CCW */

	char last_stable;
};

static int rotary_encoder_get_state(struct rotary_encoder_platform_data *pdata)
{
	int a = !!gpio_get_value(pdata-&gt;gpio_a);
	int b = !!gpio_get_value(pdata-&gt;gpio_b);

	a ^= pdata-&gt;inverted_a;
	b ^= pdata-&gt;inverted_b;

	return ((a &lt;&lt; 1) | b);
}

static void rotary_encoder_report_event(struct rotary_encoder *encoder)
{
	struct rotary_encoder_platform_data *pdata = encoder-&gt;pdata;

	if (pdata-&gt;relative_axis) {
		input_report_rel(encoder-&gt;input,
				 pdata-&gt;axis, encoder-&gt;dir ? -1 : 1);
	} else {
		unsigned int pos = encoder-&gt;pos;

		if (encoder-&gt;dir) {
			/* turning counter-clockwise */
			if (pdata-&gt;rollover)
				pos += pdata-&gt;steps;
			if (pos)
				pos--;
		} else {
			/* turning clockwise */
			if (pdata-&gt;rollover || pos &lt; pdata-&gt;steps)
				pos++;
		}

		if (pdata-&gt;rollover)
			pos %= pdata-&gt;steps;

		encoder-&gt;pos = pos;
		input_report_abs(encoder-&gt;input, pdata-&gt;axis, encoder-&gt;pos);
	}

	input_sync(encoder-&gt;input);
}

static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
{
	struct rotary_encoder *encoder = dev_id;
	int state;

	state = rotary_encoder_get_state(encoder-&gt;pdata);

	switch (state) {
	case 0x0:
		if (encoder-&gt;armed) {
			rotary_encoder_report_event(encoder);
			encoder-&gt;armed = false;
		}
		break;

	case 0x1:
	case 0x2:
		if (encoder-&gt;armed)
			encoder-&gt;dir = state - 1;
		break;

	case 0x3:
		encoder-&gt;armed = true;
		break;
	}

	return IRQ_HANDLED;
}

static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
{
	struct rotary_encoder *encoder = dev_id;
	int state;

	state = rotary_encoder_get_state(encoder-&gt;pdata);

	switch (state) {
	case 0x00:
	case 0x03:
		if (state != encoder-&gt;last_stable) {
			rotary_encoder_report_event(encoder);
			encoder-&gt;last_stable = state;
		}
		break;

	case 0x01:
	case 0x02:
		encoder-&gt;dir = (encoder-&gt;last_stable + state) &amp; 0x01;
		break;
	}

	return IRQ_HANDLED;
}

static int __devinit rotary_encoder_probe(struct platform_device *pdev)
{
	struct rotary_encoder_platform_data *pdata = pdev-&gt;dev.platform_data;
	struct rotary_encoder *encoder;
	struct input_dev *input;
	irq_handler_t handler;
	int err;

	if (!pdata) {
		dev_err(&amp;pdev-&gt;dev, &quot;missing platform data\n&quot;);
		return -ENOENT;
	}

	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
	input = input_allocate_device();
	if (!encoder || !input) {
		dev_err(&amp;pdev-&gt;dev, &quot;failed to allocate memory for device\n&quot;);
		err = -ENOMEM;
		goto exit_free_mem;
	}

	encoder-&gt;input = input;
	encoder-&gt;pdata = pdata;
	encoder-&gt;irq_a = gpio_to_irq(pdata-&gt;gpio_a);
	encoder-&gt;irq_b = gpio_to_irq(pdata-&gt;gpio_b);

	/* create and register the input driver */
	input-&gt;name = pdev-&gt;name;
	input-&gt;id.bustype = BUS_HOST;
	input-&gt;dev.parent = &amp;pdev-&gt;dev;

	if (pdata-&gt;relative_axis) {
		input-&gt;evbit[0] = BIT_MASK(EV_REL);
		input-&gt;relbit[0] = BIT_MASK(pdata-&gt;axis);
	} else {
		input-&gt;evbit[0] = BIT_MASK(EV_ABS);
		input_set_abs_params(encoder-&gt;input,
				     pdata-&gt;axis, 0, pdata-&gt;steps, 0, 1);
	}

	err = input_register_device(input);
	if (err) {
		dev_err(&amp;pdev-&gt;dev, &quot;failed to register input device\n&quot;);
		goto exit_free_mem;
	}

	/* request the GPIOs */
	err = gpio_request(pdata-&gt;gpio_a, DRV_NAME);
	if (err) {
		dev_err(&amp;pdev-&gt;dev, &quot;unable to request GPIO %d\n&quot;,
			pdata-&gt;gpio_a);
		goto exit_unregister_input;
	}

	err = gpio_direction_input(pdata-&gt;gpio_a);
	if (err) {
		dev_err(&amp;pdev-&gt;dev, &quot;unable to set GPIO %d for input\n&quot;,
			pdata-&gt;gpio_a);
		goto exit_unregister_input;
	}

	err = gpio_request(pdata-&gt;gpio_b, DRV_NAME);
	if (err) {
		dev_err(&amp;pdev-&gt;dev, &quot;unable to request GPIO %d\n&quot;,
			pdata-&gt;gpio_b);
		goto exit_free_gpio_a;
	}

	err = gpio_direction_input(pdata-&gt;gpio_b);
	if (err) {
		dev_err(&amp;pdev-&gt;dev, &quot;unable to set GPIO %d for input\n&quot;,
			pdata-&gt;gpio_b);
		goto exit_free_gpio_a;
	}

	/* request the IRQs */
	if (pdata-&gt;half_period) {
		handler = &amp;rotary_encoder_half_period_irq;
		encoder-&gt;last_stable = rotary_encoder_get_state(pdata);
	} else {
		handler = &amp;rotary_encoder_irq;
	}

	err = request_irq(encoder-&gt;irq_a, handler,
			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
			  DRV_NAME, encoder);
	if (err) {
		dev_err(&amp;pdev-&gt;dev, &quot;unable to request IRQ %d\n&quot;,
			encoder-&gt;irq_a);
		goto exit_free_gpio_b;
	}

	err = request_irq(encoder-&gt;irq_b, handler,
			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
			  DRV_NAME, encoder);
	if (err) {
		dev_err(&amp;pdev-&gt;dev, &quot;unable to request IRQ %d\n&quot;,
			encoder-&gt;irq_b);
		goto exit_free_irq_a;
	}

	platform_set_drvdata(pdev, encoder);

	return 0;

exit_free_irq_a:
	free_irq(encoder-&gt;irq_a, encoder);
exit_free_gpio_b:
	gpio_free(pdata-&gt;gpio_b);
exit_free_gpio_a:
	gpio_free(pdata-&gt;gpio_a);
exit_unregister_input:
	input_unregister_device(input);
	input = NULL; /* so we don&#39;t try to free it */
exit_free_mem:
	input_free_device(input);
	kfree(encoder);
	return err;
}

static int __devexit rotary_encoder_remove(struct platform_device *pdev)
{
	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
	struct rotary_encoder_platform_data *pdata = pdev-&gt;dev.platform_data;

	free_irq(encoder-&gt;irq_a, encoder);
	free_irq(encoder-&gt;irq_b, encoder);
	gpio_free(pdata-&gt;gpio_a);
	gpio_free(pdata-&gt;gpio_b);
	input_unregister_device(encoder-&gt;input);
	platform_set_drvdata(pdev, NULL);
	kfree(encoder);

	return 0;
}

static struct platform_driver rotary_encoder_driver = {
	.probe		= rotary_encoder_probe,
	.remove		= __devexit_p(rotary_encoder_remove),
	.driver		= {
		.name	= DRV_NAME,
		.owner	= THIS_MODULE,
	}
};

static int __init rotary_encoder_init(void)
{
	return platform_driver_register(&amp;rotary_encoder_driver);
}

static void __exit rotary_encoder_exit(void)
{
	platform_driver_unregister(&amp;rotary_encoder_driver);
}

module_init(rotary_encoder_init);
module_exit(rotary_encoder_exit);

MODULE_ALIAS(&quot;platform:&quot; DRV_NAME);
MODULE_DESCRIPTION(&quot;GPIO rotary encoder driver&quot;);
MODULE_AUTHOR(&quot;Daniel Mack &lt;daniel@caiaq.de&gt;, Johan Hovold&quot;);
MODULE_LICENSE(&quot;GPL v2&quot;);
</pre><div class="footer">Powered by <a href="https://code.google.com/p/gitiles/">Gitiles</a></div></body></html>
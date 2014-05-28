#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x961c1a02, "module_layout" },
	{ 0xfb93b347, "platform_driver_unregister" },
	{ 0x2a9f986f, "platform_driver_register" },
	{ 0x17433eb8, "input_event" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0xc5ae0182, "malloc_sizes" },
	{ 0x91d692f8, "input_free_device" },
	{ 0xd6b8e852, "request_threaded_irq" },
	{ 0x65d6d0f0, "gpio_direction_input" },
	{ 0x47229b5c, "gpio_request" },
	{ 0x63f40a0b, "input_register_device" },
	{ 0x13628a78, "input_set_abs_params" },
	{ 0x11f447ce, "__gpio_to_irq" },
	{ 0x8011a926, "input_allocate_device" },
	{ 0x16a864ec, "kmem_cache_alloc_trace" },
	{ 0xcfed3b0b, "dev_err" },
	{ 0x6c8d5ae8, "__gpio_get_value" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x37a0cba, "kfree" },
	{ 0x5ae4e357, "dev_set_drvdata" },
	{ 0x91e2d63e, "input_unregister_device" },
	{ 0xfe990052, "gpio_free" },
	{ 0xf20dabd8, "free_irq" },
	{ 0xc52f1a74, "dev_get_drvdata" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "8ECB5F79DD43C4E1EE355BA");

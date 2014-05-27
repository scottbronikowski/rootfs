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

MODULE_INFO(intree, "Y");

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0xd3111ff9, "module_layout" },
	{ 0x714dfb45, "omap_dss_unregister_driver" },
	{ 0x34342250, "omap_dss_register_driver" },
	{ 0x68d06665, "omapdss_dpi_display_disable" },
	{ 0xf9a482f9, "msleep" },
	{ 0x915b175e, "omapdss_dpi_display_enable" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xe21352c5, "dev_err" },
	{ 0xe98eba48, "backlight_device_register" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x37a0cba, "kfree" },
	{ 0xba6a0ed5, "backlight_device_unregister" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=omapdss,backlight";


MODULE_INFO(srcversion, "FD959A9B6AF1FF860E5E074");

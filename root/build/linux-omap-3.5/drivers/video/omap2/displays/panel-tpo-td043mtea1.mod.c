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
	{ 0xb41ff088, "driver_unregister" },
	{ 0xb3a25273, "spi_register_driver" },
	{ 0x1258d9d9, "regulator_disable" },
	{ 0x68d06665, "omapdss_dpi_display_disable" },
	{ 0x915b175e, "omapdss_dpi_display_enable" },
	{ 0x432fd7f6, "__gpio_set_value" },
	{ 0xf9a482f9, "msleep" },
	{ 0x8a5c7a80, "regulator_enable" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x34342250, "omap_dss_register_driver" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x8d985fe1, "spi_setup" },
	{ 0xe21352c5, "dev_err" },
	{ 0x403f9529, "gpio_request_one" },
	{ 0x518630ac, "sysfs_create_group" },
	{ 0x904a26ec, "regulator_get" },
	{ 0x373db350, "kstrtoint" },
	{ 0x11a13e31, "_kstrtol" },
	{ 0xb81960ca, "snprintf" },
	{ 0x20c55ae0, "sscanf" },
	{ 0xfe990052, "gpio_free" },
	{ 0xd85ac634, "regulator_put" },
	{ 0x6b74fc32, "sysfs_remove_group" },
	{ 0x4bf61f5f, "dpi_check_timings" },
	{ 0xfb9510d7, "dpi_set_timings" },
	{ 0x37a0cba, "kfree" },
	{ 0x714dfb45, "omap_dss_unregister_driver" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xe23e6e46, "dev_warn" },
	{ 0xfb80fe6b, "spi_sync" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=omapdss";


MODULE_INFO(srcversion, "D07F248394EA9121900D2B5");

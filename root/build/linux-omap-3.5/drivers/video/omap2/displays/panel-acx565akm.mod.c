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
	{ 0x27e1a049, "printk" },
	{ 0x7d11c268, "jiffies" },
	{ 0xd62c833f, "schedule_timeout" },
	{ 0x3bd1b1f6, "msecs_to_jiffies" },
	{ 0x518630ac, "sysfs_create_group" },
	{ 0xe98eba48, "backlight_device_register" },
	{ 0xdc066daf, "_dev_info" },
	{ 0xf9a482f9, "msleep" },
	{ 0xe21352c5, "dev_err" },
	{ 0x6c77fd55, "omapdss_sdi_display_enable" },
	{ 0xffff9307, "omapdss_sdi_display_disable" },
	{ 0x84b183ae, "strncmp" },
	{ 0x97255bdf, "strlen" },
	{ 0x34342250, "omap_dss_register_driver" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0xb81960ca, "snprintf" },
	{ 0xba6a0ed5, "backlight_device_unregister" },
	{ 0x6b74fc32, "sysfs_remove_group" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0xfb80fe6b, "spi_sync" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x714dfb45, "omap_dss_unregister_driver" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=backlight,omapdss";


MODULE_INFO(srcversion, "6921AA9A99ECEB1DCB4C448");

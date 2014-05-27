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
	{ 0xcedd565a, "omapdss_default_get_recommended_bpp" },
	{ 0x714dfb45, "omap_dss_unregister_driver" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x34342250, "omap_dss_register_driver" },
	{ 0x222e7ce2, "sysfs_streq" },
	{ 0xa36ded19, "schedule_delayed_work" },
	{ 0x165e417c, "dsi_vc_set_max_rx_packet_size" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x518630ac, "sysfs_create_group" },
	{ 0xd6b8e852, "request_threaded_irq" },
	{ 0xe98eba48, "backlight_device_register" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x9393a63a, "omap_dsi_set_vc_id" },
	{ 0x6b4262d, "omap_dsi_request_vc" },
	{ 0x403f9529, "gpio_request_one" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0xbf258353, "init_timer_key" },
	{ 0xbbd40509, "init_timer_deferrable_key" },
	{ 0x89c0ed7c, "lockdep_init_map" },
	{ 0x71b629b8, "__alloc_workqueue_key" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x37a0cba, "kfree" },
	{ 0x8c03d20c, "destroy_workqueue" },
	{ 0xba6a0ed5, "backlight_device_unregister" },
	{ 0xfe990052, "gpio_free" },
	{ 0xf20dabd8, "free_irq" },
	{ 0xbcc6263e, "omap_dsi_release_vc" },
	{ 0x6b74fc32, "sysfs_remove_group" },
	{ 0xfcec0987, "enable_irq" },
	{ 0x3ce4ca6f, "disable_irq" },
	{ 0x11f447ce, "__gpio_to_irq" },
	{ 0xdc066daf, "_dev_info" },
	{ 0x245e3fa1, "dsi_enable_video_output" },
	{ 0xe0c36be3, "omapdss_dsi_vc_enable_hs" },
	{ 0x6c5f22fd, "omapdss_dsi_display_enable" },
	{ 0xc77d69dd, "omapdss_dsi_configure_pins" },
	{ 0xb81960ca, "snprintf" },
	{ 0x996bdb64, "_kstrtoul" },
	{ 0x29a4f2d0, "omap_dsi_update" },
	{ 0x6ef18009, "dsi_vc_send_bta_sync" },
	{ 0xd2755700, "queue_delayed_work" },
	{ 0x49ebacbd, "_clear_bit" },
	{ 0xab70ad05, "del_timer_sync" },
	{ 0x3bd1b1f6, "msecs_to_jiffies" },
	{ 0xa368f722, "dsi_vc_dcs_write_nosync" },
	{ 0x7c0d6e07, "omapdss_dsi_display_disable" },
	{ 0x6ddafd82, "dsi_disable_video_output" },
	{ 0x9e7d6bd0, "__udelay" },
	{ 0x432fd7f6, "__gpio_set_value" },
	{ 0x7d11c268, "jiffies" },
	{ 0xd62c833f, "schedule_timeout" },
	{ 0xb9054182, "omapdss_dsi_enable_te" },
	{ 0xf9a482f9, "msleep" },
	{ 0x55b9ae76, "dsi_vc_dcs_write" },
	{ 0x9d6643d6, "dsi_bus_lock" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0xe21352c5, "dev_err" },
	{ 0xdcf0bb3a, "dsi_bus_unlock" },
	{ 0xa5e0793e, "dsi_vc_dcs_read" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=omapdss,backlight";


MODULE_INFO(srcversion, "092E93CE9ACE3937F9EFE17");

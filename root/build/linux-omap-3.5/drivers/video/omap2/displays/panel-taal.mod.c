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
	{ 0xcedd565a, "omapdss_default_get_recommended_bpp" },
	{ 0x714dfb45, "omap_dss_unregister_driver" },
	{ 0x34342250, "omap_dss_register_driver" },
	{ 0x165e417c, "dsi_vc_set_max_rx_packet_size" },
	{ 0xe98eba48, "backlight_device_register" },
	{ 0x9393a63a, "omap_dsi_set_vc_id" },
	{ 0x6b4262d, "omap_dsi_request_vc" },
	{ 0xba6a0ed5, "backlight_device_unregister" },
	{ 0xbcc6263e, "omap_dsi_release_vc" },
	{ 0x245e3fa1, "dsi_enable_video_output" },
	{ 0xe0c36be3, "omapdss_dsi_vc_enable_hs" },
	{ 0x6c5f22fd, "omapdss_dsi_display_enable" },
	{ 0xc77d69dd, "omapdss_dsi_configure_pins" },
	{ 0x29a4f2d0, "omap_dsi_update" },
	{ 0x6ef18009, "dsi_vc_send_bta_sync" },
	{ 0xa368f722, "dsi_vc_dcs_write_nosync" },
	{ 0x7c0d6e07, "omapdss_dsi_display_disable" },
	{ 0x6ddafd82, "dsi_disable_video_output" },
	{ 0xb9054182, "omapdss_dsi_enable_te" },
	{ 0x55b9ae76, "dsi_vc_dcs_write" },
	{ 0x9d6643d6, "dsi_bus_lock" },
	{ 0xdcf0bb3a, "dsi_bus_unlock" },
	{ 0xa5e0793e, "dsi_vc_dcs_read" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=omapdss,backlight";


MODULE_INFO(srcversion, "092E93CE9ACE3937F9EFE17");

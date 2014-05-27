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
	{ 0xc88088dc, "omap_dss_get_overlay_manager" },
	{ 0xffd2cf99, "omap_dss_get_num_overlay_managers" },
	{ 0xb18e6948, "omap_dss_pal_timings" },
	{ 0x746933e0, "omap_dss_get_overlay" },
	{ 0xcfdbda47, "cfb_fillrect" },
	{ 0xd07b66de, "omap_dss_put_device" },
	{ 0x9166782a, "cfb_imageblit" },
	{ 0x8466f77e, "omap_dss_get_next_device" },
	{ 0xc9142293, "omap_dss_ntsc_timings" },
	{ 0xb73b3ea8, "omap_dss_get_device" },
	{ 0x5dc6203e, "cfb_copyarea" },
	{ 0x636b3461, "omap_dss_get_num_overlays" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=omapdss,cfbfillrect,cfbimgblt,cfbcopyarea";


MODULE_INFO(srcversion, "417B5D669A1878F507FCB51");

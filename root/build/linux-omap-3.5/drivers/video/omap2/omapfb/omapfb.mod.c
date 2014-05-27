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
	{ 0xcae94c60, "platform_driver_probe" },
	{ 0xa8232c78, "strtobool" },
	{ 0xc2359d92, "device_remove_file" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0xd2c79b28, "up_read" },
	{ 0xd6ee688f, "vmalloc" },
	{ 0x27864d57, "memparse" },
	{ 0x349cba85, "strchr" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0x8bd92468, "framebuffer_release" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x71b629b8, "__alloc_workqueue_key" },
	{ 0xc88088dc, "omap_dss_get_overlay_manager" },
	{ 0xffd2cf99, "omap_dss_get_num_overlay_managers" },
	{ 0xb18e6948, "omap_dss_pal_timings" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x223cc898, "omap_vrfb_max_height" },
	{ 0x746933e0, "omap_dss_get_overlay" },
	{ 0x20000329, "simple_strtoul" },
	{ 0x353e3fa5, "__get_user_4" },
	{ 0xcfdbda47, "cfb_fillrect" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0xbf258353, "init_timer_key" },
	{ 0x1bbecdfe, "cancel_delayed_work_sync" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x85df9b6c, "strsep" },
	{ 0x999e8297, "vfree" },
	{ 0xc499ae1e, "kstrdup" },
	{ 0xf6f3cef6, "omap_vrfb_setup" },
	{ 0x231d4001, "fb_edid_add_monspecs" },
	{ 0x6e584c1b, "down_write_nested" },
	{ 0xe2d5255a, "strcmp" },
	{ 0xd07b66de, "omap_dss_put_device" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xe106154f, "omap_vram_get_info" },
	{ 0xa4610bc6, "omap_rev" },
	{ 0x9166782a, "cfb_imageblit" },
	{ 0xe21352c5, "dev_err" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x27e1a049, "printk" },
	{ 0xc0cf95f9, "omap_vrfb_request_ctx" },
	{ 0x7a890c8, "fb_alloc_cmap" },
	{ 0x8466f77e, "omap_dss_get_next_device" },
	{ 0xae570d3, "register_framebuffer" },
	{ 0x73e20c1c, "strlcpy" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x8c03d20c, "destroy_workqueue" },
	{ 0x308aad56, "omap_vrfb_min_phys_size" },
	{ 0xf79c9fa3, "omap_vram_alloc" },
	{ 0x373db350, "kstrtoint" },
	{ 0xb453ff0a, "up_write" },
	{ 0x42160169, "flush_workqueue" },
	{ 0x2196324, "__aeabi_idiv" },
	{ 0x80d81308, "omap_vrfb_release_ctx" },
	{ 0xa592bdff, "device_create_file" },
	{ 0x98b71c6, "fb_dealloc_cmap" },
	{ 0xc9142293, "omap_dss_ntsc_timings" },
	{ 0xbc10dd97, "__put_user_4" },
	{ 0xf853bbca, "omap_vrfb_map_angle" },
	{ 0x36f01478, "fb_find_mode" },
	{ 0xc2165d85, "__arm_iounmap" },
	{ 0x996bdb64, "_kstrtoul" },
	{ 0xff9ca065, "fb_edid_to_monspecs" },
	{ 0x81030e, "omap_vram_reserve" },
	{ 0x1dc36131, "fb_destroy_modedb" },
	{ 0xf26df746, "omap_vram_free" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xc3996ee, "framebuffer_alloc" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x37a0cba, "kfree" },
	{ 0xa46f2f1b, "kstrtouint" },
	{ 0xf53e3793, "down_read_nested" },
	{ 0x97f70b76, "remap_pfn_range" },
	{ 0x9d669763, "memcpy" },
	{ 0xb73b3ea8, "omap_dss_get_device" },
	{ 0x4f4748d3, "lock_fb_info" },
	{ 0x89c0ed7c, "lockdep_init_map" },
	{ 0xe23e6e46, "dev_warn" },
	{ 0x40a6f522, "__arm_ioremap" },
	{ 0x5dc6203e, "cfb_copyarea" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x636b3461, "omap_dss_get_num_overlays" },
	{ 0xb81960ca, "snprintf" },
	{ 0xbf64d234, "platform_driver_unregister" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0x644dca44, "__init_rwsem" },
	{ 0xd2755700, "queue_delayed_work" },
	{ 0x287948fa, "unregister_framebuffer" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=omapdss,cfbfillrect,cfbimgblt,cfbcopyarea";


MODULE_INFO(srcversion, "417B5D669A1878F507FCB51");

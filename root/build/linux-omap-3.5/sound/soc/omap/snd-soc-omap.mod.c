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
	{ 0xc0a6a8c5, "omap_set_dma_dest_burst_mode" },
	{ 0x8271b51d, "snd_soc_unregister_platform" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x4ed5d791, "snd_pcm_period_elapsed" },
	{ 0x664377e5, "arm_dma_ops" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x3f2dc4a4, "snd_soc_set_runtime_hwparams" },
	{ 0xdb4292e4, "omap_set_dma_params" },
	{ 0x5e60eb27, "omap_dma_unlink_lch" },
	{ 0x407a3275, "omap_start_dma" },
	{ 0x85765fee, "omap_enable_dma_irq" },
	{ 0x197dc3b3, "omap_set_dma_src_burst_mode" },
	{ 0xbc9fe47f, "snd_pcm_hw_constraint_integer" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0xe5445af6, "omap_get_dma_dst_pos" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0xb9a8f03b, "omap_stop_dma" },
	{ 0x41e7c6a5, "platform_driver_register" },
	{ 0x3117087f, "snd_pcm_lib_ioctl" },
	{ 0x2573b36, "omap_disable_dma_irq" },
	{ 0xa61e4362, "omap_request_dma" },
	{ 0x4e506013, "omap_dma_link_lch" },
	{ 0x473ceed5, "snd_soc_register_platform" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0x37a0cba, "kfree" },
	{ 0x8cd8c339, "omap_free_dma" },
	{ 0x441ed159, "omap_get_dma_src_pos" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xbf64d234, "platform_driver_unregister" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-soc-core,snd-pcm";


MODULE_INFO(srcversion, "BBE268047E2D42ACAB97332");

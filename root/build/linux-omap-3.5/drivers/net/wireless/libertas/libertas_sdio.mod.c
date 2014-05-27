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
	{ 0xc42e28e7, "sdio_writeb" },
	{ 0x9084d197, "sdio_readb" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0xf9a482f9, "msleep" },
	{ 0xcd09a944, "__pm_runtime_idle" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x71b629b8, "__alloc_workqueue_key" },
	{ 0x82138b0f, "lbs_resume" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xde875358, "sdio_writesb" },
	{ 0x74d0905a, "sdio_enable_func" },
	{ 0x2394cf66, "sdio_claim_irq" },
	{ 0x7fb746c6, "schedule_work" },
	{ 0x8957be2f, "cancel_work_sync" },
	{ 0xbbfb6440, "queue_work" },
	{ 0xeae3dfd6, "__const_udelay" },
	{ 0x521e4e24, "lbs_stop_card" },
	{ 0x47d51d16, "__pm_runtime_resume" },
	{ 0xef70b03d, "netdev_alert" },
	{ 0xa5343580, "__lbs_cmd" },
	{ 0x7d11c268, "jiffies" },
	{ 0x8a1e1cbd, "sdio_get_host_pm_caps" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x4bc0922f, "__netdev_alloc_skb" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0x1efc8c08, "lbs_start_card" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xe21352c5, "dev_err" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0x27e1a049, "printk" },
	{ 0x20c55ae0, "sscanf" },
	{ 0x2bee29c9, "lbs_queue_event" },
	{ 0x8c03d20c, "destroy_workqueue" },
	{ 0x9d840d8, "lbs_get_firmware_async" },
	{ 0xb1342a12, "lbs_cmd_copyback" },
	{ 0x70d17f86, "lbs_suspend" },
	{ 0xf64277de, "lbs_debug" },
	{ 0x42160169, "flush_workqueue" },
	{ 0x65c5d7d8, "sdio_readsb" },
	{ 0x2af6ff07, "sdio_unregister_driver" },
	{ 0x7937c8f3, "lbs_remove_card" },
	{ 0xd0b78ebd, "sdio_f0_writeb" },
	{ 0xe5d4bdd, "sdio_set_host_pm_flags" },
	{ 0x75dcb433, "lbs_process_rxed_packet" },
	{ 0xdc066daf, "_dev_info" },
	{ 0x30085ae2, "sdio_release_irq" },
	{ 0xce99bd5e, "lbs_host_to_card_done" },
	{ 0x1000e51, "schedule" },
	{ 0xe33ebddc, "sdio_align_size" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0x370338f9, "lbs_add_card" },
	{ 0xf677850a, "sdio_f0_readb" },
	{ 0x926f2ae7, "mmc_add_host" },
	{ 0x5fe3a795, "netdev_err" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0xc888886f, "mmc_remove_host" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x8b5b5078, "prepare_to_wait" },
	{ 0x89c0ed7c, "lockdep_init_map" },
	{ 0x101a9c1f, "finish_wait" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x27c62d77, "sdio_register_driver" },
	{ 0xf96b5d17, "sdio_claim_host" },
	{ 0xa2d86ccc, "skb_put" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0xb9b7342a, "sdio_set_block_size" },
	{ 0x7266c780, "release_firmware" },
	{ 0x835a72f9, "sdio_disable_func" },
	{ 0x9d4a46d7, "sdio_release_host" },
	{ 0x6c691469, "lbs_notify_command_response" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=libertas";

MODULE_ALIAS("sdio:c*v02DFd9103*");
MODULE_ALIAS("sdio:c*v02DFd9104*");

MODULE_INFO(srcversion, "A32F8D925653734A9C24D7B");

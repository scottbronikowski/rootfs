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
	{ 0xca2529af, "netdev_info" },
	{ 0xf9a482f9, "msleep" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0x86690996, "lbs_host_sleep_cfg" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x82138b0f, "lbs_resume" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x7b19f006, "usb_kill_urb" },
	{ 0xe2fae716, "kmemdup" },
	{ 0xbf258353, "init_timer_key" },
	{ 0x521e4e24, "lbs_stop_card" },
	{ 0xa5343580, "__lbs_cmd" },
	{ 0x7d11c268, "jiffies" },
	{ 0x4bc0922f, "__netdev_alloc_skb" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0x1efc8c08, "lbs_start_card" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xab70ad05, "del_timer_sync" },
	{ 0xb0f3b22f, "usb_deregister" },
	{ 0x27e1a049, "printk" },
	{ 0x2bee29c9, "lbs_queue_event" },
	{ 0xa0050a20, "lbs_send_tx_feedback" },
	{ 0xa5882aae, "mod_timer" },
	{ 0x9d840d8, "lbs_get_firmware_async" },
	{ 0xb1342a12, "lbs_cmd_copyback" },
	{ 0x70d17f86, "lbs_suspend" },
	{ 0xb050a0a9, "skb_pull" },
	{ 0xf64277de, "lbs_debug" },
	{ 0x7937c8f3, "lbs_remove_card" },
	{ 0x75dcb433, "lbs_process_rxed_packet" },
	{ 0x94e71639, "usb_submit_urb" },
	{ 0x50e8270a, "usb_get_dev" },
	{ 0xa2dd6be1, "usb_reset_device" },
	{ 0xce99bd5e, "lbs_host_to_card_done" },
	{ 0x6bd7122b, "usb_put_dev" },
	{ 0x1000e51, "schedule" },
	{ 0x26eda452, "kfree_skb" },
	{ 0x370338f9, "lbs_add_card" },
	{ 0xcc5005fe, "msleep_interruptible" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x8b5b5078, "prepare_to_wait" },
	{ 0x1f8e0d4b, "usb_register_driver" },
	{ 0x101a9c1f, "finish_wait" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xa2d86ccc, "skb_put" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0x626f4b6f, "usb_free_urb" },
	{ 0x7266c780, "release_firmware" },
	{ 0x3d8463da, "usb_alloc_urb" },
	{ 0x6c691469, "lbs_notify_command_response" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=libertas";

MODULE_ALIAS("usb:v1286p2001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v05A3p8388d*dc*dsc*dp*ic*isc*ip*");

MODULE_INFO(srcversion, "B1DF2B8E33FD86730B0510D");

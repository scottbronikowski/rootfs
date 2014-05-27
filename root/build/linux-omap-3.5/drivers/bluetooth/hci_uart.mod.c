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
	{ 0x4b736cab, "skb_queue_head" },
	{ 0x6f6f4c73, "_raw_spin_lock_irqsave_nested" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0xb696507d, "hci_recv_stream_fragment" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x38bb6baa, "del_timer" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x223faa8e, "hci_register_dev" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xee88e85, "tty_unthrottle" },
	{ 0x2a3aa678, "_test_and_clear_bit" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0xbf258353, "init_timer_key" },
	{ 0x6c39351f, "hci_recv_frame" },
	{ 0x164f3a50, "hci_unregister_dev" },
	{ 0xa120d33c, "tty_unregister_ldisc" },
	{ 0x7d11c268, "jiffies" },
	{ 0xb4e91437, "skb_trim" },
	{ 0xb61a0c3b, "bt_err" },
	{ 0x7c640527, "bt_info" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x97063d6, "skb_queue_purge" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0x71c90087, "memcmp" },
	{ 0xc7fdbcbf, "tty_ldisc_flush" },
	{ 0x3c16b841, "n_tty_ioctl_helper" },
	{ 0xadf5f00a, "hci_alloc_dev" },
	{ 0xe554c162, "skb_push" },
	{ 0xa5882aae, "mod_timer" },
	{ 0xb050a0a9, "skb_pull" },
	{ 0x16c96493, "skb_queue_tail" },
	{ 0x1b83e296, "__alloc_skb" },
	{ 0xec5f259f, "tty_driver_flush_buffer" },
	{ 0x26eda452, "kfree_skb" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x215ebd78, "bitrev16" },
	{ 0xb663f799, "skb_dequeue" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xca54fee, "_test_and_set_bit" },
	{ 0xafbb2502, "hci_free_dev" },
	{ 0x1e3e0637, "tty_register_ldisc" },
	{ 0x49ebacbd, "_clear_bit" },
	{ 0xa2d86ccc, "skb_put" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=bluetooth";


MODULE_INFO(srcversion, "B002D3E4F5B2C117744F71B");

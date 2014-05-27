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
	{ 0xb0f3b22f, "usb_deregister" },
	{ 0x1f8e0d4b, "usb_register_driver" },
	{ 0x1b83e296, "__alloc_skb" },
	{ 0x6c39351f, "hci_recv_frame" },
	{ 0x9d669763, "memcpy" },
	{ 0xa2d86ccc, "skb_put" },
	{ 0x49ebacbd, "_clear_bit" },
	{ 0xca54fee, "_test_and_set_bit" },
	{ 0x2a3aa678, "_test_and_clear_bit" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x67fba204, "usb_kill_anchored_urbs" },
	{ 0xf5a47e01, "usb_unanchor_urb" },
	{ 0xb61a0c3b, "bt_err" },
	{ 0x94e71639, "usb_submit_urb" },
	{ 0xcf40ae68, "usb_anchor_urb" },
	{ 0x626f4b6f, "usb_free_urb" },
	{ 0xe554c162, "skb_push" },
	{ 0x3d8463da, "usb_alloc_urb" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x223faa8e, "hci_register_dev" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xadf5f00a, "hci_alloc_dev" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xafbb2502, "hci_free_dev" },
	{ 0x164f3a50, "hci_unregister_dev" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x26eda452, "kfree_skb" },
	{ 0x37a0cba, "kfree" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=bluetooth";

MODULE_ALIAS("usb:v08FDp0002d*dc*dsc*dp*ic*isc*ip*");

MODULE_INFO(srcversion, "B5713302F8B39410E4CEC8E");

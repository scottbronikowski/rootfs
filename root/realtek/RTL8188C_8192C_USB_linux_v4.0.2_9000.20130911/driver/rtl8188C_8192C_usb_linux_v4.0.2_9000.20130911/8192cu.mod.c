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

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x961c1a02, "module_layout" },
	{ 0xfea4a1f4, "register_netdevice" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0xf9a482f9, "msleep" },
	{ 0x2b688622, "complete_and_exit" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0xd6ee688f, "vmalloc" },
	{ 0xd091babc, "mutex_destroy" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0xc996d097, "del_timer" },
	{ 0x97255bdf, "strlen" },
	{ 0x5ae4e357, "dev_set_drvdata" },
	{ 0x31f1152, "find_vpid" },
	{ 0x47939e0d, "__tasklet_hi_schedule" },
	{ 0x108420c7, "netif_carrier_on" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0xcf9e38c5, "skb_clone" },
	{ 0xe96944ae, "dev_get_by_name" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0xc3eb2ae1, "skb_copy" },
	{ 0x8949858b, "schedule_work" },
	{ 0x4fe38dbd, "down_interruptible" },
	{ 0xf73aea18, "netif_carrier_off" },
	{ 0x4205ad24, "cancel_work_sync" },
	{ 0x1d9ee419, "usb_kill_urb" },
	{ 0x1bee79d0, "remove_proc_entry" },
	{ 0xcd21820b, "filp_close" },
	{ 0x4e830a3e, "strnicmp" },
	{ 0xeae3dfd6, "__const_udelay" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0xfb0e29f, "init_timer_key" },
	{ 0x945586d2, "mutex_unlock" },
	{ 0xa6de8ae, "usb_autopm_get_interface" },
	{ 0x85df9b6c, "strsep" },
	{ 0x768623fa, "usb_enable_autosuspend" },
	{ 0x999e8297, "vfree" },
	{ 0x99997ec8, "usb_disable_autosuspend" },
	{ 0x91715312, "sprintf" },
	{ 0xb3237c43, "kthread_create_on_node" },
	{ 0x7d11c268, "jiffies" },
	{ 0x1adcb2af, "skb_trim" },
	{ 0xe2d5255a, "strcmp" },
	{ 0xcb375010, "__netdev_alloc_skb" },
	{ 0x4915cca2, "netif_rx" },
	{ 0xc36f6052, "__pskb_pull_tail" },
	{ 0x63b87fc5, "__init_waitqueue_head" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x5f754e5a, "memset" },
	{ 0xdde4e2b8, "usb_deregister" },
	{ 0x53b67748, "__mutex_init" },
	{ 0x27e1a049, "printk" },
	{ 0x20c55ae0, "sscanf" },
	{ 0x71c90087, "memcmp" },
	{ 0xd16348c8, "free_netdev" },
	{ 0xfaef0ed, "__tasklet_schedule" },
	{ 0x328a05f1, "strncpy" },
	{ 0x1f81f37c, "register_netdev" },
	{ 0x604b984, "wireless_send_event" },
	{ 0xa2a9c1d6, "usb_control_msg" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x82688d64, "skb_push" },
	{ 0x955f4690, "mutex_lock" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0x9545af6d, "tasklet_init" },
	{ 0x8834396c, "mod_timer" },
	{ 0x2469810f, "__rcu_read_unlock" },
	{ 0x30017067, "kill_pid" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0x8b33b66e, "skb_pull" },
	{ 0x4cc35132, "device_init_wakeup" },
	{ 0x26358845, "usb_free_coherent" },
	{ 0xe6bd33a8, "init_net" },
	{ 0x2196324, "__aeabi_idiv" },
	{ 0x92254593, "dev_kfree_skb_any" },
	{ 0xd79b5a02, "allow_signal" },
	{ 0x59e5070d, "__do_div64" },
	{ 0x82072614, "tasklet_kill" },
	{ 0x259c8074, "flush_signals" },
	{ 0xd18298ff, "skb_queue_tail" },
	{ 0x3ff62317, "local_bh_disable" },
	{ 0xffe0c57a, "netif_device_attach" },
	{ 0x123d653d, "usb_submit_urb" },
	{ 0x65646682, "usb_get_dev" },
	{ 0x3bd1b1f6, "msecs_to_jiffies" },
	{ 0x1ab26680, "usb_put_dev" },
	{ 0xd62c833f, "schedule_timeout" },
	{ 0x6b2dc060, "dump_stack" },
	{ 0x799aca4, "local_bh_enable" },
	{ 0x2b569214, "eth_type_trans" },
	{ 0xf6a224b0, "create_proc_entry" },
	{ 0xad06da73, "wake_up_process" },
	{ 0xe7f93579, "unregister_netdevice_queue" },
	{ 0x44da5d0f, "__csum_ipv6_magic" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x3fe412e2, "dev_alloc_name" },
	{ 0x364b3fff, "up" },
	{ 0xddb381a9, "usb_register_driver" },
	{ 0x9be6d399, "skb_dequeue" },
	{ 0x2d56a170, "unregister_netdev" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x60f71cfa, "complete" },
	{ 0xb81960ca, "snprintf" },
	{ 0x8d463744, "__netif_schedule" },
	{ 0x99bb8806, "memmove" },
	{ 0xe113bbbc, "csum_partial" },
	{ 0x316ab8b1, "usb_alloc_coherent" },
	{ 0x85670f1d, "rtnl_is_locked" },
	{ 0x8d522714, "__rcu_read_lock" },
	{ 0x9572c79d, "skb_put" },
	{ 0x80d817ab, "wait_for_completion_timeout" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xaee310a2, "skb_copy_bits" },
	{ 0xc52f1a74, "dev_get_drvdata" },
	{ 0xdeb1b7a4, "usb_free_urb" },
	{ 0x9e7d6bd0, "__udelay" },
	{ 0x6fdb1103, "usb_autopm_put_interface" },
	{ 0xdc43a9c8, "daemonize" },
	{ 0x760a0f4f, "yield" },
	{ 0xa604c545, "usb_alloc_urb" },
	{ 0x72c98f60, "filp_open" },
	{ 0x39f45cbf, "alloc_etherdev_mqs" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";

MODULE_ALIAS("usb:v0BDAp8191d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp8176d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp8170d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp817Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp817Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp817Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp817Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp8754d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp817Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp818Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp018Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp17C0d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp8177d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp8178d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp817Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp8191d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1058p0631d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2019pED17d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DF6p0052d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v7392p7811d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v07B8p8189d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0EB0p9071d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v06F8pE033d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v103Cp1629d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2001p3308d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v050Dp1102d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2019pAB2Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v20F4p648Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v4855p0090d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v13D3p3357d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DF6p005Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp5088d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v4856p0091d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0846p9041d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2019p4902d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2019pAB2Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2001p330Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:vCDABp8010d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0B05p17BAd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp1E1Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v04BBp094Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:vCDABp8011d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp0A8Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp317Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v13D3p3359d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v13D3p3358d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v04F2pAFF7d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v04F2pAFF9d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v04F2pAFFAd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v04F2pAFF8d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v04F2pAFFBd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v04F2pAFFCd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2019p1201d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2001p3307d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2001p330Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2001p3309d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0586p341Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v7392p7822d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2019pAB2Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v07B8p8178d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v07AAp0056d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v4855p0091d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v050Dp2102d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v050Dp2103d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v20F4p624Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DF6p0061d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0B05p17ABd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0846p9021d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0846pF001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0E66p0019d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0E66p0020d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v050Dp1004d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp2E2Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2357p0100d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v06F8pE035d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v04BBp0950d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DF6p0070d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0789p016Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0BDAp8186d*dc*dsc*dp*ic*isc*ip*");

MODULE_INFO(srcversion, "CE388896624E104C8F146BC");

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
	{ 0x1a5cfa81, "device_remove_file" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0xa675804c, "utf8s_to_utf16s" },
	{ 0xff178f6, "__aeabi_idivmod" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0x5ae4e357, "dev_set_drvdata" },
	{ 0x79aa04a2, "get_random_bytes" },
	{ 0xc5ae0182, "malloc_sizes" },
	{ 0x108420c7, "netif_carrier_on" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0xcf9e38c5, "skb_clone" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0x11f7ed4c, "hex_to_bin" },
	{ 0x8949858b, "schedule_work" },
	{ 0xf73aea18, "netif_carrier_off" },
	{ 0xf087137d, "__dynamic_pr_debug" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0x2c9e39f1, "usb_gadget_unregister_driver" },
	{ 0x91715312, "sprintf" },
	{ 0x5b463407, "skb_realloc_headroom" },
	{ 0x7d11c268, "jiffies" },
	{ 0x1adcb2af, "skb_trim" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x4915cca2, "netif_rx" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xe384a102, "usb_speed_string" },
	{ 0x11089ac7, "_ctype" },
	{ 0xcfed3b0b, "dev_err" },
	{ 0x27e1a049, "printk" },
	{ 0x9f3b7be2, "ethtool_op_get_link" },
	{ 0xd16348c8, "free_netdev" },
	{ 0x1f81f37c, "register_netdev" },
	{ 0x73e20c1c, "strlcpy" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x82688d64, "skb_push" },
	{ 0xa34f1ef5, "crc32_le" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0x89ff43f6, "init_uts_ns" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0x8b33b66e, "skb_pull" },
	{ 0x92254593, "dev_kfree_skb_any" },
	{ 0x1a3816af, "device_create_file" },
	{ 0x24e1307e, "flush_work_sync" },
	{ 0xd18298ff, "skb_queue_tail" },
	{ 0xe11e2454, "skb_copy_expand" },
	{ 0xd431222e, "_dev_info" },
	{ 0x9f984513, "strrchr" },
	{ 0x138473bb, "__alloc_skb" },
	{ 0x2b569214, "eth_type_trans" },
	{ 0x16a864ec, "kmem_cache_alloc_trace" },
	{ 0x604aed28, "__dynamic_dev_dbg" },
	{ 0x14f585eb, "eth_validate_addr" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x4447eccd, "usb_gadget_probe_driver" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x9be6d399, "skb_dequeue" },
	{ 0xc6c5e816, "dev_warn" },
	{ 0x2d56a170, "unregister_netdev" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xb81960ca, "snprintf" },
	{ 0x8d463744, "__netif_schedule" },
	{ 0x487d9343, "param_ops_ushort" },
	{ 0x9572c79d, "skb_put" },
	{ 0x13a39a85, "eth_mac_addr" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xaee310a2, "skb_copy_bits" },
	{ 0xc52f1a74, "dev_get_drvdata" },
	{ 0xe1a70c27, "dev_get_stats" },
	{ 0x39f45cbf, "alloc_etherdev_mqs" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "0F59D6923062AF612070E15");

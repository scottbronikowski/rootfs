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
	{ 0xf9a482f9, "msleep" },
	{ 0xa675804c, "utf8s_to_utf16s" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0x5ae4e357, "dev_set_drvdata" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0xc5ae0182, "malloc_sizes" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0x9c7ef2af, "__alloc_tty_driver" },
	{ 0xf087137d, "__dynamic_pr_debug" },
	{ 0xd3d0478a, "tty_register_driver" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0x945586d2, "mutex_unlock" },
	{ 0x25eb506, "put_tty_driver" },
	{ 0x2c9e39f1, "usb_gadget_unregister_driver" },
	{ 0x91715312, "sprintf" },
	{ 0x77b9540c, "tty_set_operations" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x63b87fc5, "__init_waitqueue_head" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x5f754e5a, "memset" },
	{ 0xe384a102, "usb_speed_string" },
	{ 0x11089ac7, "_ctype" },
	{ 0xcfed3b0b, "dev_err" },
	{ 0x53b67748, "__mutex_init" },
	{ 0x27e1a049, "printk" },
	{ 0xfaef0ed, "__tasklet_schedule" },
	{ 0xc2ed5aa9, "tty_port_init" },
	{ 0xdf874c57, "tty_insert_flip_string_fixed_flag" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x955f4690, "mutex_lock" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0x9545af6d, "tasklet_init" },
	{ 0x89ff43f6, "init_uts_ns" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0x96835edf, "tty_register_device" },
	{ 0x82072614, "tasklet_kill" },
	{ 0x1a3816af, "device_create_file" },
	{ 0x999d3b33, "tty_unregister_device" },
	{ 0xd431222e, "_dev_info" },
	{ 0x9f984513, "strrchr" },
	{ 0x67b27ec1, "tty_std_termios" },
	{ 0xd62c833f, "schedule_timeout" },
	{ 0x1000e51, "schedule" },
	{ 0x16a864ec, "kmem_cache_alloc_trace" },
	{ 0x604aed28, "__dynamic_dev_dbg" },
	{ 0xfc2f314c, "tty_unregister_driver" },
	{ 0xf367cf6b, "tty_hangup" },
	{ 0xb9e52429, "__wake_up" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x4447eccd, "usb_gadget_probe_driver" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x75a17bed, "prepare_to_wait" },
	{ 0x8893fa5d, "finish_wait" },
	{ 0xc6c5e816, "dev_warn" },
	{ 0x8e9c755b, "tty_flip_buffer_push" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xb81960ca, "snprintf" },
	{ 0x487d9343, "param_ops_ushort" },
	{ 0x4acbfe77, "tty_wakeup" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xc52f1a74, "dev_get_drvdata" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "244484E52FD717F113BEEED");

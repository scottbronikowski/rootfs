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
	{ 0xc15f60b4, "cdev_del" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0x8cfe1e99, "cdev_init" },
	{ 0xa675804c, "utf8s_to_utf16s" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0x5ae4e357, "dev_set_drvdata" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0xc5ae0182, "malloc_sizes" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0x73559946, "device_destroy" },
	{ 0x945586d2, "mutex_unlock" },
	{ 0x7485e15e, "unregister_chrdev_region" },
	{ 0x2c9e39f1, "usb_gadget_unregister_driver" },
	{ 0x91715312, "sprintf" },
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
	{ 0x73e20c1c, "strlcpy" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x955f4690, "mutex_lock" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0xaf02738b, "noop_llseek" },
	{ 0x723995b6, "device_create" },
	{ 0x89ff43f6, "init_uts_ns" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0x1a3816af, "device_create_file" },
	{ 0xb1512a77, "cdev_add" },
	{ 0xd431222e, "_dev_info" },
	{ 0x9f984513, "strrchr" },
	{ 0x1000e51, "schedule" },
	{ 0x16a864ec, "kmem_cache_alloc_trace" },
	{ 0x604aed28, "__dynamic_dev_dbg" },
	{ 0xb9e52429, "__wake_up" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x4447eccd, "usb_gadget_probe_driver" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x75a17bed, "prepare_to_wait" },
	{ 0xdbd06b7c, "class_destroy" },
	{ 0x8893fa5d, "finish_wait" },
	{ 0xc6c5e816, "dev_warn" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xb81960ca, "snprintf" },
	{ 0x487d9343, "param_ops_ushort" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xe7516dad, "__class_create" },
	{ 0xc52f1a74, "dev_get_drvdata" },
	{ 0x29537c9e, "alloc_chrdev_region" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "421D810F82CD46F47543B7D");

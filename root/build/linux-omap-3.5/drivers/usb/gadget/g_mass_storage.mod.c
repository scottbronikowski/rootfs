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
	{ 0x5052ec94, "d_path" },
	{ 0x1a5cfa81, "device_remove_file" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0xa675804c, "utf8s_to_utf16s" },
	{ 0x2b688622, "complete_and_exit" },
	{ 0x58db3f5, "up_read" },
	{ 0x9ebb0fa7, "dequeue_signal" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0x5ae4e357, "dev_set_drvdata" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0xc5ae0182, "malloc_sizes" },
	{ 0x7ab88a45, "system_freezing_cnt" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0x76cf47f6, "__aeabi_llsl" },
	{ 0xcd21820b, "filp_close" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0x61fa90f8, "vfs_fsync" },
	{ 0x2c9e39f1, "usb_gadget_unregister_driver" },
	{ 0x91715312, "sprintf" },
	{ 0xb3237c43, "kthread_create_on_node" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x4e748dcd, "down_read" },
	{ 0x63b87fc5, "__init_waitqueue_head" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x5baaba0, "wait_for_completion" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xa9d7d12c, "vfs_read" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x5f754e5a, "memset" },
	{ 0xcd63c845, "__aeabi_lasr" },
	{ 0xe384a102, "usb_speed_string" },
	{ 0x85c67212, "device_register" },
	{ 0x11089ac7, "_ctype" },
	{ 0xcfed3b0b, "dev_err" },
	{ 0x95fd071d, "freezing_slow_path" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0x89ff43f6, "init_uts_ns" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0x53ba4e7c, "up_write" },
	{ 0x7bf30fdc, "down_write" },
	{ 0x11accd06, "fput" },
	{ 0xd79b5a02, "allow_signal" },
	{ 0x1a3816af, "device_create_file" },
	{ 0xd431222e, "_dev_info" },
	{ 0x9f984513, "strrchr" },
	{ 0x966f658b, "put_device" },
	{ 0x1000e51, "schedule" },
	{ 0x4482cdb, "__refrigerator" },
	{ 0xad06da73, "wake_up_process" },
	{ 0xcc5005fe, "msleep_interruptible" },
	{ 0x16a864ec, "kmem_cache_alloc_trace" },
	{ 0x604aed28, "__dynamic_dev_dbg" },
	{ 0xb9e52429, "__wake_up" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x4447eccd, "usb_gadget_probe_driver" },
	{ 0x37a0cba, "kfree" },
	{ 0xa46f2f1b, "kstrtouint" },
	{ 0x9d669763, "memcpy" },
	{ 0x75a17bed, "prepare_to_wait" },
	{ 0x4845c423, "param_array_ops" },
	{ 0xf0b59df2, "send_sig_info" },
	{ 0x9e61bb05, "set_freezable" },
	{ 0xbb3f3d29, "invalidate_mapping_pages" },
	{ 0x8893fa5d, "finish_wait" },
	{ 0xc6c5e816, "dev_warn" },
	{ 0xb39408e7, "device_unregister" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xb81960ca, "snprintf" },
	{ 0x99bb8806, "memmove" },
	{ 0x487d9343, "param_ops_ushort" },
	{ 0x6ffef351, "dev_set_name" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xc52f1a74, "dev_get_drvdata" },
	{ 0x796d56bd, "__init_rwsem" },
	{ 0xd7a5b438, "vfs_write" },
	{ 0x72c98f60, "filp_open" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "FE99D6D5733EDB65B2D732E");

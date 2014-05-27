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
	{ 0x7dd22ced, "v4l2_event_unsubscribe" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0xa675804c, "utf8s_to_utf16s" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0x5ae4e357, "dev_set_drvdata" },
	{ 0x58bbaf5b, "v4l2_event_queue" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0xc810718c, "video_device_release" },
	{ 0x9bf6fa34, "video_usercopy" },
	{ 0xc5ae0182, "malloc_sizes" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0x5e19453, "v4l2_event_dequeue" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xe7cf8b5b, "__video_register_device" },
	{ 0x945586d2, "mutex_unlock" },
	{ 0x999e8297, "vfree" },
	{ 0x2c9e39f1, "usb_gadget_unregister_driver" },
	{ 0x91715312, "sprintf" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x63b87fc5, "__init_waitqueue_head" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x5f754e5a, "memset" },
	{ 0xe384a102, "usb_speed_string" },
	{ 0x42e689a7, "video_device_alloc" },
	{ 0x11089ac7, "_ctype" },
	{ 0x1e6baa01, "v4l2_event_subscribe" },
	{ 0x53b67748, "__mutex_init" },
	{ 0x27e1a049, "printk" },
	{ 0x13c089ec, "video_unregister_device" },
	{ 0xab6873bc, "v4l2_event_pending" },
	{ 0xae2310bd, "v4l2_fh_init" },
	{ 0x328a05f1, "strncpy" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x955f4690, "mutex_lock" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0x89ff43f6, "init_uts_ns" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0x6e2266f0, "vm_insert_page" },
	{ 0x1a3816af, "device_create_file" },
	{ 0xd431222e, "_dev_info" },
	{ 0x9f984513, "strrchr" },
	{ 0x103b51ae, "video_devdata" },
	{ 0x1000e51, "schedule" },
	{ 0xa0b04675, "vmalloc_32" },
	{ 0x16a864ec, "kmem_cache_alloc_trace" },
	{ 0x604aed28, "__dynamic_dev_dbg" },
	{ 0xb9e52429, "__wake_up" },
	{ 0x4f68e5c9, "do_gettimeofday" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x4447eccd, "usb_gadget_probe_driver" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x75a17bed, "prepare_to_wait" },
	{ 0x8893fa5d, "finish_wait" },
	{ 0xaf71fbf5, "v4l2_fh_add" },
	{ 0xc6c5e816, "dev_warn" },
	{ 0x6f727695, "v4l2_fh_del" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xb81960ca, "snprintf" },
	{ 0x39c99dd4, "vmalloc_to_page" },
	{ 0x487d9343, "param_ops_ushort" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xc52f1a74, "dev_get_drvdata" },
	{ 0xeadd5c53, "v4l2_fh_exit" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=videodev";


MODULE_INFO(srcversion, "258D49B8B73D9F070ECCCF3");

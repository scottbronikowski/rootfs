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
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0x5ae4e357, "dev_set_drvdata" },
	{ 0xc163f784, "snd_pcm_period_elapsed" },
	{ 0xc5d61db2, "snd_card_create" },
	{ 0xc5ae0182, "malloc_sizes" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0xf087137d, "__dynamic_pr_debug" },
	{ 0x2c9e39f1, "usb_gadget_unregister_driver" },
	{ 0x91715312, "sprintf" },
	{ 0x573130bd, "snd_pcm_hw_constraint_integer" },
	{ 0xe2d5255a, "strcmp" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xe384a102, "usb_speed_string" },
	{ 0x11089ac7, "_ctype" },
	{ 0xcfed3b0b, "dev_err" },
	{ 0x27e1a049, "printk" },
	{ 0xe2d5f61c, "snd_pcm_set_ops" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0x380328b7, "snd_pcm_lib_free_pages" },
	{ 0x3ce6e3f4, "platform_device_unregister" },
	{ 0x89ff43f6, "init_uts_ns" },
	{ 0x2a9f986f, "platform_driver_register" },
	{ 0x25aa0ef5, "snd_pcm_lib_ioctl" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0x500c8b74, "snd_pcm_lib_malloc_pages" },
	{ 0x1a3816af, "device_create_file" },
	{ 0xd431222e, "_dev_info" },
	{ 0x9f984513, "strrchr" },
	{ 0x5ee9228e, "platform_device_register" },
	{ 0x16a864ec, "kmem_cache_alloc_trace" },
	{ 0x604aed28, "__dynamic_dev_dbg" },
	{ 0x68a24153, "snd_pcm_format_physical_width" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x4447eccd, "usb_gadget_probe_driver" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x955e94e0, "snd_pcm_lib_preallocate_pages_for_all" },
	{ 0xb17122f5, "snd_card_free" },
	{ 0xc6c5e816, "dev_warn" },
	{ 0x5051eacf, "snd_card_register" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0x5f8bcaf9, "snd_pcm_new" },
	{ 0xb81960ca, "snprintf" },
	{ 0x487d9343, "param_ops_ushort" },
	{ 0xfb93b347, "platform_driver_unregister" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xc52f1a74, "dev_get_drvdata" },
	{ 0xe914e41e, "strcpy" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "B43CFD10EAE4415E67D7E45");

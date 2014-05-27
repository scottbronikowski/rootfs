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
	{ 0xd3111ff9, "module_layout" },
	{ 0xc2359d92, "device_remove_file" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0xa675804c, "utf8s_to_utf16s" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x38bb6baa, "del_timer" },
	{ 0x97255bdf, "strlen" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x84de99d8, "dev_printk" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x20000329, "simple_strtoul" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0xbf258353, "init_timer_key" },
	{ 0xdc08a097, "usb_gadget_unregister_driver" },
	{ 0x91715312, "sprintf" },
	{ 0x7d11c268, "jiffies" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xab70ad05, "del_timer_sync" },
	{ 0x5f754e5a, "memset" },
	{ 0xe384a102, "usb_speed_string" },
	{ 0x11089ac7, "_ctype" },
	{ 0xe21352c5, "dev_err" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0x27e1a049, "printk" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0xa5882aae, "mod_timer" },
	{ 0x89ff43f6, "init_uts_ns" },
	{ 0xa592bdff, "device_create_file" },
	{ 0xdc066daf, "_dev_info" },
	{ 0x9f984513, "strrchr" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x5e8a3c5a, "usb_gadget_probe_driver" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0xe23e6e46, "dev_warn" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xb81960ca, "snprintf" },
	{ 0x487d9343, "param_ops_ushort" },
	{ 0x6d044c26, "param_ops_uint" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "9CA7E449EE10E7A1F161A30");

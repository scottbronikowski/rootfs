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
	{ 0x6bc3fbc0, "__unregister_chrdev" },
	{ 0x402b8281, "__request_module" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xd69f63cf, "device_destroy" },
	{ 0x76a7037d, "__register_chrdev" },
	{ 0x91715312, "sprintf" },
	{ 0x733c3b54, "kasprintf" },
	{ 0x27e1a049, "printk" },
	{ 0x3b57b084, "noop_llseek" },
	{ 0x12559092, "device_create" },
	{ 0x2a74e108, "module_put" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0x37a0cba, "kfree" },
	{ 0xba863d21, "class_destroy" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x41373a65, "__class_create" },
	{ 0xee6b3d96, "try_module_get" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "D85A7B72DAA26F9E01F3856");

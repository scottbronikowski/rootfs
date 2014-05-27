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
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x94e71639, "usb_submit_urb" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xb61a0c3b, "bt_err" },
	{ 0x7fb746c6, "schedule_work" },
	{ 0x89c0ed7c, "lockdep_init_map" },
	{ 0xe2fae716, "kmemdup" },
	{ 0x7266c780, "release_firmware" },
	{ 0x9d669763, "memcpy" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0x3a9d11c5, "request_firmware" },
	{ 0x3d8463da, "usb_alloc_urb" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x37a0cba, "kfree" },
	{ 0x626f4b6f, "usb_free_urb" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x7b19f006, "usb_kill_urb" },
	{ 0x8957be2f, "cancel_work_sync" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=bluetooth";

MODULE_ALIAS("usb:v0A5Cp2033d*dc*dsc*dp*ic*isc*ip*");

MODULE_INFO(srcversion, "AC317012F81D5990F1E80E6");

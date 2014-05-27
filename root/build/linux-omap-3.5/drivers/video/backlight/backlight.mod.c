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
	{ 0x5934392b, "fb_register_client" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x91715312, "sprintf" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x68893c49, "device_register" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x27e1a049, "printk" },
	{ 0xba9f20a8, "kobject_uevent_env" },
	{ 0x996bdb64, "_kstrtoul" },
	{ 0xc060c2a2, "sysfs_notify" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x37a0cba, "kfree" },
	{ 0xba863d21, "class_destroy" },
	{ 0xcc36f32e, "fb_unregister_client" },
	{ 0x5f48f0e8, "device_unregister" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xece0fced, "dev_set_name" },
	{ 0x41373a65, "__class_create" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "CE41ABDD656D2930B68A9ED");

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
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x25d927e2, "snd_register_device_for_dev" },
	{ 0x5290a820, "snd_card_file_remove" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x7109c814, "remove_wait_queue" },
	{ 0xb2e5ae4a, "snd_lookup_minor_data" },
	{ 0x353e3fa5, "__get_user_4" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x198788b4, "snd_lookup_oss_minor_data" },
	{ 0x91715312, "sprintf" },
	{ 0x961caa08, "snd_ctl_unregister_ioctl" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0xffd5a395, "default_wake_function" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x3ad3d301, "snd_device_new" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x812c3314, "snd_unregister_device" },
	{ 0x73e20c1c, "strlcpy" },
	{ 0x8f595b11, "snd_major" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x2a74e108, "module_put" },
	{ 0xbc10dd97, "__put_user_4" },
	{ 0x94453b83, "snd_card_file_add" },
	{ 0x65e2c205, "snd_ctl_register_ioctl" },
	{ 0x1000e51, "schedule" },
	{ 0xa7a10828, "snd_register_oss_device" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0xc987c3d6, "snd_unregister_oss_device" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x430633dd, "add_wait_queue" },
	{ 0x37a0cba, "kfree" },
	{ 0x7bec87d, "snd_info_free_entry" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xdfd177d1, "snd_info_create_module_entry" },
	{ 0x969c5f86, "snd_info_register" },
	{ 0xee6b3d96, "try_module_get" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd";


MODULE_INFO(srcversion, "B5290A6FE5B4BF28DA77B7D");

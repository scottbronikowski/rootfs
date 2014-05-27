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
	{ 0x12da5bb2, "__kmalloc" },
	{ 0x24a94b26, "snd_info_get_line" },
	{ 0xd2c79b28, "up_read" },
	{ 0x716bd9fb, "snd_ctl_find_numid" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x5290a820, "snd_card_file_remove" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x745e12f7, "no_llseek" },
	{ 0xf68aa3d7, "snd_info_create_card_entry" },
	{ 0x20000329, "simple_strtoul" },
	{ 0x353e3fa5, "__get_user_4" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x198788b4, "snd_lookup_oss_minor_data" },
	{ 0x91715312, "sprintf" },
	{ 0xc499ae1e, "kstrdup" },
	{ 0x1b75ab20, "nonseekable_open" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x4fc5d84a, "down_read" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x5f754e5a, "memset" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x8df3789f, "snd_oss_info_register" },
	{ 0xa632d98f, "snd_ctl_notify" },
	{ 0x73e20c1c, "strlcpy" },
	{ 0x7f80a0c5, "snd_cards" },
	{ 0x2196324, "__aeabi_idiv" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x2a74e108, "module_put" },
	{ 0x44e7ecba, "snd_mixer_oss_notify_callback" },
	{ 0xbc10dd97, "__put_user_4" },
	{ 0x94453b83, "snd_card_file_add" },
	{ 0xa7a10828, "snd_register_oss_device" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x8c8ef6f0, "snd_ctl_find_id" },
	{ 0xc987c3d6, "snd_unregister_oss_device" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x9e6d79f8, "snd_info_get_str" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x7bec87d, "snd_info_free_entry" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x969c5f86, "snd_info_register" },
	{ 0xee6b3d96, "try_module_get" },
	{ 0xe914e41e, "strcpy" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd";


MODULE_INFO(srcversion, "3DBE365643EF993A58AFC6A");

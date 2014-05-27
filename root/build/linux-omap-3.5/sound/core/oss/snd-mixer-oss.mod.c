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
	{ 0x24a94b26, "snd_info_get_line" },
	{ 0x716bd9fb, "snd_ctl_find_numid" },
	{ 0x5290a820, "snd_card_file_remove" },
	{ 0xf68aa3d7, "snd_info_create_card_entry" },
	{ 0x198788b4, "snd_lookup_oss_minor_data" },
	{ 0x8df3789f, "snd_oss_info_register" },
	{ 0xa632d98f, "snd_ctl_notify" },
	{ 0x7f80a0c5, "snd_cards" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x44e7ecba, "snd_mixer_oss_notify_callback" },
	{ 0x94453b83, "snd_card_file_add" },
	{ 0xa7a10828, "snd_register_oss_device" },
	{ 0x8c8ef6f0, "snd_ctl_find_id" },
	{ 0xc987c3d6, "snd_unregister_oss_device" },
	{ 0x9e6d79f8, "snd_info_get_str" },
	{ 0x7bec87d, "snd_info_free_entry" },
	{ 0x969c5f86, "snd_info_register" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd";


MODULE_INFO(srcversion, "3DBE365643EF993A58AFC6A");

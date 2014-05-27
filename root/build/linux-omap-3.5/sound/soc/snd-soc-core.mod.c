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
	{ 0xe56a9336, "snd_pcm_format_width" },
	{ 0xa286a234, "snd_pcm_format_name" },
	{ 0x8afa5b96, "snd_card_create" },
	{ 0x9c8ae623, "snd_pcm_hw_constraint_msbits" },
	{ 0x5de68e5, "snd_power_wait" },
	{ 0x6e7e9b5, "snd_pcm_suspend_all" },
	{ 0x812fad33, "snd_pcm_set_ops" },
	{ 0xafbefc92, "snd_jack_new" },
	{ 0x3117087f, "snd_pcm_lib_ioctl" },
	{ 0x781cec74, "snd_ctl_new1" },
	{ 0x724dd1, "snd_pcm_new_internal" },
	{ 0x213a536b, "snd_pcm_hw_constraint_minmax" },
	{ 0x1d42e941, "snd_card_free" },
	{ 0x31bb5a2c, "snd_card_register" },
	{ 0xab12f749, "snd_pcm_limit_hw_rates" },
	{ 0xdb4529ee, "snd_jack_report" },
	{ 0xec2d4b7e, "snd_pcm_new" },
	{ 0x6f1394f7, "snd_ctl_add" },
	{ 0xe0d6a472, "regmap_init_spi" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-pcm,snd,regmap-spi";


MODULE_INFO(srcversion, "817B8EB328A24AE4274D129");

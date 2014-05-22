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
	{ 0xa7f82182, "snd_pcm_hw_constraint_step" },
	{ 0x4414f890, "snd_soc_unregister_dai" },
	{ 0xa1680968, "snd_soc_info_volsw" },
	{ 0x51f74167, "snd_pcm_hw_rule_add" },
	{ 0x68a24153, "snd_pcm_format_physical_width" },
	{ 0x4cda566, "snd_interval_refine" },
	{ 0xcae1d651, "snd_soc_register_dai" },
	{ 0x9c3f4771, "snd_soc_add_dai_controls" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-pcm,snd-soc-core";


MODULE_INFO(srcversion, "B8E044587C835B1DAF2041D");

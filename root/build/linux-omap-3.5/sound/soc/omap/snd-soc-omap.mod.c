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
	{ 0x8271b51d, "snd_soc_unregister_platform" },
	{ 0x4ed5d791, "snd_pcm_period_elapsed" },
	{ 0x3f2dc4a4, "snd_soc_set_runtime_hwparams" },
	{ 0xbc9fe47f, "snd_pcm_hw_constraint_integer" },
	{ 0x3117087f, "snd_pcm_lib_ioctl" },
	{ 0x473ceed5, "snd_soc_register_platform" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-soc-core,snd-pcm";


MODULE_INFO(srcversion, "BBE268047E2D42ACAB97332");

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
	{ 0x56f6c18f, "snd_soc_dapm_new_controls" },
	{ 0x79bc5bfa, "snd_soc_dapm_nc_pin" },
	{ 0xf70defc9, "snd_soc_dapm_add_routes" },
	{ 0x7e8a6433, "snd_soc_dai_set_clkdiv" },
	{ 0xe902ba99, "snd_soc_dai_set_sysclk" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-soc-core";


MODULE_INFO(srcversion, "DCA4080C4243810323A675C");

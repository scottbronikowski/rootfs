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
	{ 0xf9a482f9, "msleep" },
	{ 0xc471c67a, "twl4030_audio_disable_resource" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x6416624f, "snd_soc_dapm_get_enum_double" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x3acdf325, "twl4030_audio_enable_resource" },
	{ 0x877a4011, "snd_soc_dapm_get_volsw" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xeae3dfd6, "__const_udelay" },
	{ 0x83387b6f, "snd_soc_put_volsw" },
	{ 0x48b5f8d, "twl4030_audio_get_mclk" },
	{ 0x30958bae, "snd_soc_get_volsw" },
	{ 0xcbd49d5e, "snd_soc_info_enum_double" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x3db2ada6, "snd_soc_read" },
	{ 0x9f59ba09, "snd_soc_info_enum_ext" },
	{ 0xe21352c5, "dev_err" },
	{ 0x4f4911a8, "snd_soc_update_bits" },
	{ 0x7b8a6ae8, "snd_soc_dapm_put_volsw" },
	{ 0x41e7c6a5, "platform_driver_register" },
	{ 0xa1680968, "snd_soc_info_volsw" },
	{ 0x7f033874, "snd_soc_get_enum_double" },
	{ 0x12a38747, "usleep_range" },
	{ 0xc87823bf, "twl_i2c_read_u8" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x48343176, "snd_soc_unregister_codec" },
	{ 0x959a24a9, "snd_soc_put_enum_double" },
	{ 0x37a0cba, "kfree" },
	{ 0x213a536b, "snd_pcm_hw_constraint_minmax" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xbf64d234, "platform_driver_unregister" },
	{ 0xff41b85c, "snd_soc_register_codec" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0x838f70b0, "twl_i2c_write_u8" },
	{ 0xe7428128, "snd_soc_dapm_put_enum_double" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-soc-core,snd-pcm";


MODULE_INFO(srcversion, "DBF87747AF2A3DC30741CBB");

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
	{ 0xff178f6, "__aeabi_idivmod" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0x84abf39a, "__pm_runtime_disable" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x788fe103, "iomem_resource" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0xa7f82182, "snd_pcm_hw_constraint_step" },
	{ 0xbb4876e0, "devm_kzalloc" },
	{ 0x2e1ca751, "clk_put" },
	{ 0xeae3dfd6, "__const_udelay" },
	{ 0x91715312, "sprintf" },
	{ 0x6b74fc32, "sysfs_remove_group" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xa4610bc6, "omap_rev" },
	{ 0x4414f890, "snd_soc_unregister_dai" },
	{ 0xe21352c5, "dev_err" },
	{ 0x27e1a049, "printk" },
	{ 0x20c55ae0, "sscanf" },
	{ 0x518630ac, "sysfs_create_group" },
	{ 0xae2e89c4, "_raw_spin_unlock_irq" },
	{ 0xea38cfda, "platform_get_resource" },
	{ 0xd6b8e852, "request_threaded_irq" },
	{ 0x41e7c6a5, "platform_driver_register" },
	{ 0x2196324, "__aeabi_idiv" },
	{ 0xa1680968, "snd_soc_info_volsw" },
	{ 0x51f74167, "snd_pcm_hw_rule_add" },
	{ 0x54dc22bb, "pm_runtime_enable" },
	{ 0x45f4183f, "platform_get_irq_byname" },
	{ 0x545f9e31, "_raw_spin_lock_irq" },
	{ 0x11f38ea3, "__devm_request_region" },
	{ 0x996bdb64, "_kstrtoul" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xd3bd17ac, "clk_get" },
	{ 0xa548fc10, "platform_get_resource_byname" },
	{ 0x68a24153, "snd_pcm_format_physical_width" },
	{ 0x4cda566, "snd_interval_refine" },
	{ 0x37a0cba, "kfree" },
	{ 0xcae1d651, "snd_soc_register_dai" },
	{ 0x7ff26933, "devm_ioremap" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x222e7ce2, "sysfs_streq" },
	{ 0x16b7719a, "platform_get_irq" },
	{ 0xbf64d234, "platform_driver_unregister" },
	{ 0x9c3f4771, "snd_soc_add_dai_controls" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0xf20dabd8, "free_irq" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-pcm,snd-soc-core";


MODULE_INFO(srcversion, "B8E044587C835B1DAF2041D");

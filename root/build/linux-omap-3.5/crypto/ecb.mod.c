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
	{ 0x271d37ee, "crypto_unregister_template" },
	{ 0xabf8e06c, "crypto_register_template" },
	{ 0x5535351c, "crypto_blkcipher_type" },
	{ 0x1c47b5c4, "crypto_mod_put" },
	{ 0x3cec1bbd, "crypto_alloc_instance" },
	{ 0xc3aa2871, "crypto_attr_alg2" },
	{ 0xd16712f3, "crypto_check_attr_type" },
	{ 0xdf350d61, "crypto_spawn_tfm" },
	{ 0x4e6e96ac, "crypto_destroy_tfm" },
	{ 0xfb165e7f, "blkcipher_walk_done" },
	{ 0x688f77cb, "blkcipher_walk_virt" },
	{ 0x37a0cba, "kfree" },
	{ 0x924e9728, "crypto_drop_spawn" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "6242227B6E671B40AD32E1F");

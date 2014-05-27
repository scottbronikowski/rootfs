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
	{ 0xe39d8866, "single_open" },
	{ 0x664377e5, "arm_dma_ops" },
	{ 0xc81d1062, "single_release" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xafeace42, "seq_printf" },
	{ 0xd9bd5608, "remove_proc_entry" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0xe524bacb, "seq_read" },
	{ 0x27e1a049, "printk" },
	{ 0x71c90087, "memcmp" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x93fca811, "__get_free_pages" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x4302d0eb, "free_pages" },
	{ 0xba5dd3fd, "proc_create_data" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x987e6f1, "seq_lseek" },
	{ 0x37a0cba, "kfree" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "29E02E7D3777951A8D6E1CF");

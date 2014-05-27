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
	{ 0xe56a9336, "snd_pcm_format_width" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0x24a94b26, "snd_info_get_line" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0xd6ee688f, "vmalloc" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x5e7f4920, "snd_pcm_format_set_silence" },
	{ 0x5290a820, "snd_card_file_remove" },
	{ 0xc1f5b33d, "snd_pcm_lib_write" },
	{ 0x3d7a15c7, "snd_pcm_release_substream" },
	{ 0x3f04fbad, "snd_pcm_notify" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x7109c814, "remove_wait_queue" },
	{ 0x745e12f7, "no_llseek" },
	{ 0x4f816e9b, "snd_pcm_format_big_endian" },
	{ 0xf68aa3d7, "snd_info_create_card_entry" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0x353e3fa5, "__get_user_4" },
	{ 0x5b998e9d, "snd_pcm_hw_refine" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x999e8297, "vfree" },
	{ 0x198788b4, "snd_lookup_oss_minor_data" },
	{ 0x91715312, "sprintf" },
	{ 0xc499ae1e, "kstrdup" },
	{ 0x1b75ab20, "nonseekable_open" },
	{ 0xdf28f8b4, "snd_pcm_link_rwlock" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x1d027e4b, "snd_pcm_format_signed" },
	{ 0xffd5a395, "default_wake_function" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x52e3e4a5, "snd_pcm_hw_param_value" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x71c90087, "memcmp" },
	{ 0xe4815d0e, "snd_pcm_hw_param_last" },
	{ 0x8df3789f, "snd_oss_info_register" },
	{ 0x732e0778, "snd_pcm_mmap_data" },
	{ 0x6ef8fcd8, "snd_pcm_format_linear" },
	{ 0x59e5070d, "__do_div64" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0xd02e4080, "snd_mixer_oss_ioctl_card" },
	{ 0x2a74e108, "module_put" },
	{ 0xf1ecd4e, "snd_pcm_lib_writev" },
	{ 0xbc10dd97, "__put_user_4" },
	{ 0x94453b83, "snd_card_file_add" },
	{ 0x1000e51, "schedule" },
	{ 0xd62c833f, "schedule_timeout" },
	{ 0xf0053604, "snd_pcm_lib_readv" },
	{ 0xa7a10828, "snd_register_oss_device" },
	{ 0x4de181f5, "snd_pcm_open_substream" },
	{ 0x650f8603, "snd_pcm_format_silence_64" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0xc987c3d6, "snd_unregister_oss_device" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x3796bdcc, "snd_pcm_format_little_endian" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x68a24153, "snd_pcm_format_physical_width" },
	{ 0x430633dd, "add_wait_queue" },
	{ 0x4cda566, "snd_interval_refine" },
	{ 0x9e6d79f8, "snd_info_get_str" },
	{ 0x37a0cba, "kfree" },
	{ 0x283dfe3, "_snd_pcm_hw_params_any" },
	{ 0x9d669763, "memcpy" },
	{ 0xa61aa028, "snd_pcm_format_unsigned" },
	{ 0x7bec87d, "snd_info_free_entry" },
	{ 0x4845c423, "param_array_ops" },
	{ 0x38b669b3, "mutex_lock_interruptible_nested" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x282d900, "snd_pcm_kernel_ioctl" },
	{ 0x140f720, "_raw_read_unlock_irq" },
	{ 0x969c5f86, "snd_info_register" },
	{ 0x2442780c, "snd_pcm_hw_param_first" },
	{ 0xee6b3d96, "try_module_get" },
	{ 0x7b269fca, "_raw_read_lock_irq" },
	{ 0x1e733688, "snd_pcm_lib_read" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-pcm,snd,snd-mixer-oss";


MODULE_INFO(srcversion, "0097F47BC1220421AEE1557");

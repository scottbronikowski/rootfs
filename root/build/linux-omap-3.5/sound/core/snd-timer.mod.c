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
	{ 0x402b8281, "__request_module" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0xff178f6, "__aeabi_idivmod" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x38bb6baa, "del_timer" },
	{ 0x25d927e2, "snd_register_device_for_dev" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x7109c814, "remove_wait_queue" },
	{ 0x46608fa0, "getnstimeofday" },
	{ 0x745e12f7, "no_llseek" },
	{ 0x353e3fa5, "__get_user_4" },
	{ 0xeae3dfd6, "__const_udelay" },
	{ 0xbf258353, "init_timer_key" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x91715312, "sprintf" },
	{ 0xc499ae1e, "kstrdup" },
	{ 0x1b75ab20, "nonseekable_open" },
	{ 0x7d11c268, "jiffies" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0xffd5a395, "default_wake_function" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x3ad3d301, "snd_device_new" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x812c3314, "snd_unregister_device" },
	{ 0x8df3789f, "snd_oss_info_register" },
	{ 0xfaef0ed, "__tasklet_schedule" },
	{ 0xde40c8fc, "fasync_helper" },
	{ 0x3971b4df, "snd_ecards_limit" },
	{ 0xae2e89c4, "_raw_spin_unlock_irq" },
	{ 0x73e20c1c, "strlcpy" },
	{ 0x9545af6d, "tasklet_init" },
	{ 0x193ef101, "add_timer" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x2a74e108, "module_put" },
	{ 0xbc10dd97, "__put_user_4" },
	{ 0x1000e51, "schedule" },
	{ 0x545f9e31, "_raw_spin_lock_irq" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0xce46e140, "ktime_get_ts" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x430633dd, "add_wait_queue" },
	{ 0x37a0cba, "kfree" },
	{ 0x7bec87d, "snd_info_free_entry" },
	{ 0x3d7df737, "kill_fasync" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xe2e8065e, "memdup_user" },
	{ 0xca54fee, "_test_and_set_bit" },
	{ 0xdfd177d1, "snd_info_create_module_entry" },
	{ 0x969c5f86, "snd_info_register" },
	{ 0xee6b3d96, "try_module_get" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd";


MODULE_INFO(srcversion, "B27B6D394B8D52A14F91487");

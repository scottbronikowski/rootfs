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
	{ 0x89212c16, "put_pid" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x25d927e2, "snd_register_device_for_dev" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0x5290a820, "snd_card_file_remove" },
	{ 0xa97e7308, "pid_vnr" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x7109c814, "remove_wait_queue" },
	{ 0x745e12f7, "no_llseek" },
	{ 0xc3f249c3, "_raw_read_lock" },
	{ 0xf68aa3d7, "snd_info_create_card_entry" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0x7fb746c6, "schedule_work" },
	{ 0xb2e5ae4a, "snd_lookup_minor_data" },
	{ 0x8957be2f, "cancel_work_sync" },
	{ 0x353e3fa5, "__get_user_4" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x198788b4, "snd_lookup_oss_minor_data" },
	{ 0x91715312, "sprintf" },
	{ 0x1b75ab20, "nonseekable_open" },
	{ 0x961caa08, "snd_ctl_unregister_ioctl" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0xffd5a395, "default_wake_function" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x3ad3d301, "snd_device_new" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x89ca5dcd, "_raw_read_unlock" },
	{ 0x812c3314, "snd_unregister_device" },
	{ 0x8df3789f, "snd_oss_info_register" },
	{ 0xae2e89c4, "_raw_spin_unlock_irq" },
	{ 0x73e20c1c, "strlcpy" },
	{ 0x8f595b11, "snd_major" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x2a74e108, "module_put" },
	{ 0xbc10dd97, "__put_user_4" },
	{ 0x94453b83, "snd_card_file_add" },
	{ 0x65e2c205, "snd_ctl_register_ioctl" },
	{ 0x1000e51, "schedule" },
	{ 0xd62c833f, "schedule_timeout" },
	{ 0x545f9e31, "_raw_spin_lock_irq" },
	{ 0xa7a10828, "snd_register_oss_device" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0xc987c3d6, "snd_unregister_oss_device" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x430633dd, "add_wait_queue" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x7bec87d, "snd_info_free_entry" },
	{ 0x8b5b5078, "prepare_to_wait" },
	{ 0x4845c423, "param_array_ops" },
	{ 0x89c0ed7c, "lockdep_init_map" },
	{ 0x101a9c1f, "finish_wait" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x969c5f86, "snd_info_register" },
	{ 0xee6b3d96, "try_module_get" },
	{ 0xb859f38b, "krealloc" },
	{ 0xe914e41e, "strcpy" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd";


MODULE_INFO(srcversion, "F7E7DA9ED7DE836225FDDEF");

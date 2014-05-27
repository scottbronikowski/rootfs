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
	{ 0x6bc3fbc0, "__unregister_chrdev" },
	{ 0x402b8281, "__request_module" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0x89212c16, "put_pid" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0xd2c79b28, "up_read" },
	{ 0x1ad1f2e7, "_memcpy_fromio" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0xd6ee688f, "vmalloc" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0xd253ccf7, "proc_symlink" },
	{ 0x97255bdf, "strlen" },
	{ 0xa5cef8ad, "release_resource" },
	{ 0x72755f2, "sound_class" },
	{ 0xbbb6ed49, "_raw_write_lock_irqsave" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0xa97e7308, "pid_vnr" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x7109c814, "remove_wait_queue" },
	{ 0x745e12f7, "no_llseek" },
	{ 0xc3f249c3, "_raw_read_lock" },
	{ 0xd9bd5608, "remove_proc_entry" },
	{ 0xd69f63cf, "device_destroy" },
	{ 0x353e3fa5, "__get_user_4" },
	{ 0x76a7037d, "__register_chrdev" },
	{ 0x9b87e401, "__rwlock_init" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x999e8297, "vfree" },
	{ 0x91715312, "sprintf" },
	{ 0xc499ae1e, "kstrdup" },
	{ 0x1b75ab20, "nonseekable_open" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x4fc5d84a, "down_read" },
	{ 0x1c8ac34d, "_raw_write_unlock_irqrestore" },
	{ 0x349e2618, "input_event" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0xffd5a395, "default_wake_function" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x9f780af2, "proc_mkdir" },
	{ 0x11089ac7, "_ctype" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x27e1a049, "printk" },
	{ 0x71c90087, "memcmp" },
	{ 0x89ca5dcd, "_raw_read_unlock" },
	{ 0x7c1372e8, "panic" },
	{ 0xde40c8fc, "fasync_helper" },
	{ 0xae2e89c4, "_raw_spin_unlock_irq" },
	{ 0x84b183ae, "strncmp" },
	{ 0x73e20c1c, "strlcpy" },
	{ 0x24b00ae, "input_set_capability" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0x1e6d26a8, "strstr" },
	{ 0x3b57b084, "noop_llseek" },
	{ 0x12559092, "device_create" },
	{ 0x89ff43f6, "init_uts_ns" },
	{ 0xb453ff0a, "up_write" },
	{ 0x1772fd3d, "down_write" },
	{ 0x7f63b31e, "_memcpy_toio" },
	{ 0x61651be, "strcat" },
	{ 0xa592bdff, "device_create_file" },
	{ 0x2a74e108, "module_put" },
	{ 0x9f984513, "strrchr" },
	{ 0x77649076, "register_sound_special_device" },
	{ 0xbc10dd97, "__put_user_4" },
	{ 0xd9ce8f0c, "strnlen" },
	{ 0xd00aed59, "input_register_device" },
	{ 0x1000e51, "schedule" },
	{ 0xd62c833f, "schedule_timeout" },
	{ 0x545f9e31, "_raw_spin_lock_irq" },
	{ 0xd36a3fe1, "input_free_device" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0x3bce0c57, "create_proc_entry" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0x7afa89fc, "vsnprintf" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x430633dd, "add_wait_queue" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0xab73919c, "input_unregister_device" },
	{ 0x8b5b5078, "prepare_to_wait" },
	{ 0x4845c423, "param_array_ops" },
	{ 0x99c95fa5, "unregister_sound_special" },
	{ 0x3d7df737, "kill_fasync" },
	{ 0x101a9c1f, "finish_wait" },
	{ 0x5f48f0e8, "device_unregister" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xe2e8065e, "memdup_user" },
	{ 0xb81960ca, "snprintf" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0x644dca44, "__init_rwsem" },
	{ 0xee6b3d96, "try_module_get" },
	{ 0xb859f38b, "krealloc" },
	{ 0xe914e41e, "strcpy" },
	{ 0x9e151a46, "input_allocate_device" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=soundcore";


MODULE_INFO(srcversion, "DD00DD9AB00C79FB30D040A");

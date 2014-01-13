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

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x961c1a02, "module_layout" },
	{ 0x1851151c, "proc_dointvec" },
	{ 0x7fd29377, "seq_release" },
	{ 0xdf0084a1, "seq_read" },
	{ 0xa728a4e3, "seq_lseek" },
	{ 0x7485e15e, "unregister_chrdev_region" },
	{ 0x1bee79d0, "remove_proc_entry" },
	{ 0xa6411cea, "unregister_sysctl_table" },
	{ 0xc15f60b4, "cdev_del" },
	{ 0xdbd06b7c, "class_destroy" },
	{ 0x73559946, "device_destroy" },
	{ 0x723995b6, "device_create" },
	{ 0xe7516dad, "__class_create" },
	{ 0xb1512a77, "cdev_add" },
	{ 0x8cfe1e99, "cdev_init" },
	{ 0xd382019f, "register_sysctl_table" },
	{ 0xf6a224b0, "create_proc_entry" },
	{ 0x29537c9e, "alloc_chrdev_region" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0xfcec0987, "enable_irq" },
	{ 0x69bda738, "seq_printf" },
	{ 0x1c1b7ca0, "seq_open" },
	{ 0x7d11c268, "jiffies" },
	{ 0x8834396c, "mod_timer" },
	{ 0x3bd1b1f6, "msecs_to_jiffies" },
	{ 0x27bbf221, "disable_irq_nosync" },
	{ 0x4f68e5c9, "do_gettimeofday" },
	{ 0xb9e52429, "__wake_up" },
	{ 0xc996d097, "del_timer" },
	{ 0xf20dabd8, "free_irq" },
	{ 0x6c8d5ae8, "__gpio_get_value" },
	{ 0xfb0e29f, "init_timer_key" },
	{ 0xd6b8e852, "request_threaded_irq" },
	{ 0x11f447ce, "__gpio_to_irq" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0xb81960ca, "snprintf" },
	{ 0x8893fa5d, "finish_wait" },
	{ 0x1000e51, "schedule" },
	{ 0x75a17bed, "prepare_to_wait" },
	{ 0x5f754e5a, "memset" },
	{ 0x99bb8806, "memmove" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x63b87fc5, "__init_waitqueue_head" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0x37a0cba, "kfree" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x27e1a049, "printk" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "B10B8C1ECA8CEDA7BD65FCD");

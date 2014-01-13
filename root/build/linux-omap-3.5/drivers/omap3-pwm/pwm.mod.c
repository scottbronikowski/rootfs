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
	{ 0x4845c423, "param_array_ops" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x4fa510c1, "kthread_stop" },
	{ 0xad06da73, "wake_up_process" },
	{ 0xb3237c43, "kthread_create_on_node" },
	{ 0xd6b8e852, "request_threaded_irq" },
	{ 0x40e1866c, "omap_dm_timer_get_irq" },
	{ 0x8d68b08b, "omap_dm_timer_set_load" },
	{ 0xf58c43e5, "clk_get_rate" },
	{ 0xfb5d02ee, "omap_dm_timer_get_fclk" },
	{ 0x5ca174ce, "omap_dm_timer_set_source" },
	{ 0xa77bb96b, "omap_dm_timer_set_pwm" },
	{ 0xdef1790e, "omap_dm_timer_request_specific" },
	{ 0x723995b6, "device_create" },
	{ 0xe7516dad, "__class_create" },
	{ 0xb1512a77, "cdev_add" },
	{ 0x8cfe1e99, "cdev_init" },
	{ 0x29537c9e, "alloc_chrdev_region" },
	{ 0x5f754e5a, "memset" },
	{ 0x27e1a049, "printk" },
	{ 0x952664c5, "do_exit" },
	{ 0xf9a482f9, "msleep" },
	{ 0x20000329, "simple_strtoul" },
	{ 0xfbc74f64, "__copy_from_user" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x2196324, "__aeabi_idiv" },
	{ 0x5980d113, "omap_dm_timer_start" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0xc2165d85, "__arm_iounmap" },
	{ 0x40a6f522, "__arm_ioremap" },
	{ 0xf20dabd8, "free_irq" },
	{ 0x268dec53, "omap_dm_timer_free" },
	{ 0x8cab68e5, "omap_dm_timer_stop" },
	{ 0xa4009bc6, "omap_dm_timer_set_int_enable" },
	{ 0xf0db5540, "omap_dm_timer_write_status" },
	{ 0x6510a63a, "omap_dm_timer_read_status" },
	{ 0x16aa2bbb, "omap_dm_timer_set_match" },
	{ 0x43b0c9c3, "preempt_schedule" },
	{ 0xbed60566, "sub_preempt_count" },
	{ 0x4c6ff041, "add_preempt_count" },
	{ 0x364b3fff, "up" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x91715312, "sprintf" },
	{ 0x4fe38dbd, "down_interruptible" },
	{ 0x7485e15e, "unregister_chrdev_region" },
	{ 0xc15f60b4, "cdev_del" },
	{ 0xdbd06b7c, "class_destroy" },
	{ 0x73559946, "device_destroy" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "DA51C735EB2C58A8B2B0CD8");

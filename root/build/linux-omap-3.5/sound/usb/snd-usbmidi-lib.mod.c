#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.arch = MODULE_ARCH_INIT,
};

MODULE_INFO(intree, "Y");

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0xd3111ff9, "module_layout" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0x37fdeaa3, "mutex_destroy" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0x7b19f006, "usb_kill_urb" },
	{ 0xe2fae716, "kmemdup" },
	{ 0xbf258353, "init_timer_key" },
	{ 0x611f7c71, "usb_autopm_get_interface" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0xbad81d96, "snd_rawmidi_set_ops" },
	{ 0x7d11c268, "jiffies" },
	{ 0x162b8c05, "snd_rawmidi_new" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0xfa2a45e, "__memzero" },
	{ 0xab70ad05, "del_timer_sync" },
	{ 0x5f754e5a, "memset" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0xf8fc1946, "usb_set_interface" },
	{ 0xa632d98f, "snd_ctl_notify" },
	{ 0xfaef0ed, "__tasklet_schedule" },
	{ 0x900950df, "usb_control_msg" },
	{ 0xae2e89c4, "_raw_spin_unlock_irq" },
	{ 0x31b265c7, "snd_rawmidi_transmit_peek" },
	{ 0x9545af6d, "tasklet_init" },
	{ 0xa5882aae, "mod_timer" },
	{ 0xfb0a6703, "usb_free_coherent" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x82072614, "tasklet_kill" },
	{ 0x81b69e41, "snd_ctl_enum_info" },
	{ 0x94e71639, "usb_submit_urb" },
	{ 0x1d6eb59d, "snd_rawmidi_transmit_ack" },
	{ 0x3bd1b1f6, "msecs_to_jiffies" },
	{ 0x98f12fb, "usb_bulk_msg" },
	{ 0xd62c833f, "schedule_timeout" },
	{ 0x545f9e31, "_raw_spin_lock_irq" },
	{ 0x781cec74, "snd_ctl_new1" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x8b5b5078, "prepare_to_wait" },
	{ 0x101a9c1f, "finish_wait" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xb81960ca, "snprintf" },
	{ 0xca54fee, "_test_and_set_bit" },
	{ 0x73bb266d, "usb_alloc_coherent" },
	{ 0x6f1394f7, "snd_ctl_add" },
	{ 0x57674fd7, "__sw_hweight16" },
	{ 0x7a6d9ae3, "snd_rawmidi_transmit" },
	{ 0x49ebacbd, "_clear_bit" },
	{ 0x6146ee20, "snd_rawmidi_transmit_empty" },
	{ 0x626f4b6f, "usb_free_urb" },
	{ 0x16e50546, "snd_rawmidi_receive" },
	{ 0xc9d40d97, "usb_autopm_put_interface" },
	{ 0x3d8463da, "usb_alloc_urb" },
	{ 0xe914e41e, "strcpy" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-rawmidi,snd";


MODULE_INFO(srcversion, "B34E61E5A93EC927C4C2A6D");

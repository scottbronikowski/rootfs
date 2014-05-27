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
	{ 0xd9d2bb03, "snd_usbmidi_disconnect" },
	{ 0xc200b0e4, "_raw_spin_unlock" },
	{ 0xa286a234, "snd_pcm_format_name" },
	{ 0x37fdeaa3, "mutex_destroy" },
	{ 0x15692c87, "param_ops_int" },
	{ 0x67c2fa54, "__copy_to_user" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0x97255bdf, "strlen" },
	{ 0xd0ee38b8, "schedule_timeout_uninterruptible" },
	{ 0xfee429f7, "dev_set_drvdata" },
	{ 0x4ed5d791, "snd_pcm_period_elapsed" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0x8afa5b96, "snd_card_create" },
	{ 0x8b7fb99f, "snd_usbmidi_create" },
	{ 0x26e7b620, "malloc_sizes" },
	{ 0xaa073d4a, "usb_driver_set_configuration" },
	{ 0xf7802486, "__aeabi_uidivmod" },
	{ 0x2a3aa678, "_test_and_clear_bit" },
	{ 0x7b19f006, "usb_kill_urb" },
	{ 0xa72f1f55, "usb_reset_configuration" },
	{ 0xe2fae716, "kmemdup" },
	{ 0x1976aa06, "param_ops_bool" },
	{ 0xee0e1703, "mutex_unlock" },
	{ 0x611f7c71, "usb_autopm_get_interface" },
	{ 0x91715312, "sprintf" },
	{ 0xa57653c8, "usb_unlink_urb" },
	{ 0xbdf5a09, "snd_card_disconnect" },
	{ 0x7d11c268, "jiffies" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x6e7e9b5, "snd_pcm_suspend_all" },
	{ 0xb6d59dce, "__init_waitqueue_head" },
	{ 0xa6b9c26e, "usb_get_descriptor" },
	{ 0xe707d823, "__aeabi_uidiv" },
	{ 0x35b6b772, "param_ops_charp" },
	{ 0xdd0a2ba2, "strlcat" },
	{ 0xfa2a45e, "__memzero" },
	{ 0x5f754e5a, "memset" },
	{ 0xb9638db4, "snd_pcm_rate_to_rate_bit" },
	{ 0x3ad3d301, "snd_device_new" },
	{ 0xea345818, "usb_string" },
	{ 0x11089ac7, "_ctype" },
	{ 0x93e8916f, "_raw_spin_unlock_irqrestore" },
	{ 0x6baf0240, "snd_pcm_hw_constraint_list" },
	{ 0xb0f3b22f, "usb_deregister" },
	{ 0xf4b82468, "__mutex_init" },
	{ 0x27e1a049, "printk" },
	{ 0x812fad33, "snd_pcm_set_ops" },
	{ 0xf8fc1946, "usb_set_interface" },
	{ 0xa632d98f, "snd_ctl_notify" },
	{ 0x3c620f24, "snd_card_free_when_closed" },
	{ 0xec692440, "snd_pcm_lib_get_vmalloc_page" },
	{ 0x900950df, "usb_control_msg" },
	{ 0x73e20c1c, "strlcpy" },
	{ 0xcab624f1, "usb_driver_claim_interface" },
	{ 0x6a3ef9a0, "snd_pcm_new_stream" },
	{ 0x16305289, "warn_slowpath_null" },
	{ 0xbb72d4fe, "__put_user_1" },
	{ 0x16928ed0, "snd_hwdep_new" },
	{ 0x3117087f, "snd_pcm_lib_ioctl" },
	{ 0xfb0a6703, "usb_free_coherent" },
	{ 0x8a6b45d7, "snd_ctl_boolean_mono_info" },
	{ 0x2196324, "__aeabi_idiv" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x81b69e41, "snd_ctl_enum_info" },
	{ 0x94e71639, "usb_submit_urb" },
	{ 0x51f74167, "snd_pcm_hw_rule_add" },
	{ 0xbc10dd97, "__put_user_4" },
	{ 0xc6665f99, "snd_component_add" },
	{ 0x4b29de69, "_snd_pcm_lib_alloc_vmalloc_buffer" },
	{ 0xa2dd6be1, "usb_reset_device" },
	{ 0x3bd1b1f6, "msecs_to_jiffies" },
	{ 0x1000e51, "schedule" },
	{ 0x781cec74, "snd_ctl_new1" },
	{ 0x32cdb25a, "__raw_spin_lock_init" },
	{ 0x85ff720a, "usb_interrupt_msg" },
	{ 0xb9012926, "kmem_cache_alloc_trace" },
	{ 0x8c8ef6f0, "snd_ctl_find_id" },
	{ 0x1d528979, "_raw_spin_lock" },
	{ 0xec35b7f1, "_raw_spin_lock_irqsave" },
	{ 0xf0cba5f4, "__wake_up" },
	{ 0xc8b04e0c, "mutex_lock_nested" },
	{ 0x68a24153, "snd_pcm_format_physical_width" },
	{ 0x1e047854, "warn_slowpath_fmt" },
	{ 0x37a0cba, "kfree" },
	{ 0x9d669763, "memcpy" },
	{ 0x8b5b5078, "prepare_to_wait" },
	{ 0x4845c423, "param_array_ops" },
	{ 0x6128b5fc, "__printk_ratelimit" },
	{ 0x213a536b, "snd_pcm_hw_constraint_minmax" },
	{ 0x1f8e0d4b, "usb_register_driver" },
	{ 0x8a6f1569, "snd_card_proc_new" },
	{ 0x101a9c1f, "finish_wait" },
	{ 0x1d42e941, "snd_card_free" },
	{ 0x31bb5a2c, "snd_card_register" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x8e43368d, "usb_ifnum_to_if" },
	{ 0x676bbc0f, "_set_bit" },
	{ 0xb81960ca, "snprintf" },
	{ 0xec2d4b7e, "snd_pcm_new" },
	{ 0xca54fee, "_test_and_set_bit" },
	{ 0x4b9785e3, "snd_pcm_lib_free_vmalloc_buffer" },
	{ 0x73bb266d, "usb_alloc_coherent" },
	{ 0x6f1394f7, "snd_ctl_add" },
	{ 0x9a4f9c56, "usb_get_current_frame_number" },
	{ 0x49ebacbd, "_clear_bit" },
	{ 0xac8f37b2, "outer_cache" },
	{ 0xd53ad1f8, "dev_get_drvdata" },
	{ 0x626f4b6f, "usb_free_urb" },
	{ 0xc9d40d97, "usb_autopm_put_interface" },
	{ 0x3d8463da, "usb_alloc_urb" },
	{ 0xe914e41e, "strcpy" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-usbmidi-lib,snd-pcm,snd,snd-hwdep";

MODULE_ALIAS("usb:v0403pB8D8d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v041Ep3048d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v041Ep3010d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v041Ep3F02d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v041Ep3F04d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v041Ep3F0Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v041Ep3F19d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v046Dp0850d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v046Dp08AEd*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v046Dp08C6d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v046Dp08F0d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v046Dp08F5d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v046Dp08F6d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v046Dp0990d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1000d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1002d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1003d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1004d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0499p1005d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1006d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1007d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1008d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1009d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p100Ad*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0499p100Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p100Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p100Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p100Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1010d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1011d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1012d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1013d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1014d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1015d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1016d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1017d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1018d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1019d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p101Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p101Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p101Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p101Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p101Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p101Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1020d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1021d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1022d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1023d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1024d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1025d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1026d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1027d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1028d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1029d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p102Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p102Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p102Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1030d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1031d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1032d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1033d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1034d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1035d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1036d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1037d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1038d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1039d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p103Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p103Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p103Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p103Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p103Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p103Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1040d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1041d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1042d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1043d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1044d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1045d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p104Ed*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0499p104Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1050d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1051d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1052d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1053d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0499p1054d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0499p1055d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1056d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1057d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1058d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1059d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p105Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p105Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p105Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p105Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p1503d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p2000d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p2001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p2002d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p2003d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5000d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5002d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5003d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5004d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5005d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5006d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5007d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5008d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p5009d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p500Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p500Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p500Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p500Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p500Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p500Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p7000d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0499p7010d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0000d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0002d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0003d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0004d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0005d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0007d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0008d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0009d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p000Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p000Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0010d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0012d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0014d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0016d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p001Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p001Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0023d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0025d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0027d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0029d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p002Bd*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p002Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p002Fd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0033d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0037d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p003Bd*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p0040d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0042d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0047d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0048d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p004Cd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p004Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0050d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0052d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0060d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0064d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0065d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p006Ad*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p006Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0074d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p0075d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p007Ad*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p0080d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p008Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0096d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p009Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p00A3d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p00A6d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p00ADd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p00C2d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p00C4d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p00DAd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p00E6d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p00E9d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p0104d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p0108d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p0109d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p010Fd*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0582p0111d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0113d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0127d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p012Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p011Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p0130d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0582p014Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v06F8pB000d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p1002d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p1011d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p1015d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p1021d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p1031d010dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0763p1033d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p1041d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p2001d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p2003d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p2008d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p200Dd*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p2019d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0763p2080d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0763p2081d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v07CFp6801d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v07CFp6802d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v07FDp0001d*dc*dsc02dp*ic*isc*ip*");
MODULE_ALIAS("usb:v086Ap0001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v086Ap0002d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v086Ap0003d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0944p0200d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0944p0201d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v09E8p0062d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0CCDp0012d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0CCDp0013d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0CCDp0014d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v0CCDp0028d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0CCDp0035d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v103Dp0100d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v103Dp0101d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1235p0001d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v1235p0002d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v1235p000Ed*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1235p4661d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v133Ep0815d*dc*dsc*dp*icFFisc*ip*");
MODULE_ALIAS("usb:v13E5p0001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v17CCp1000d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v17CCp1010d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v17CCp1020d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1F38p0001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v4752p0011d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v7104p2202d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v2040p7200d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v2040p7240d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v2040p7210d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v2040p7217d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v2040p721Bd*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v2040p721Ed*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v2040p721Fd*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v2040p7280d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v0FD9p0008d*dc*dsc*dp*ic01isc01ip*");
MODULE_ALIAS("usb:v0DBAp1000d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v*p*d*dc*dsc*dp*ic01isc03ip*");
MODULE_ALIAS("usb:v*p*d*dc*dsc*dp*ic01isc01ip*");

MODULE_INFO(srcversion, "052235CA261277159EBC85C");

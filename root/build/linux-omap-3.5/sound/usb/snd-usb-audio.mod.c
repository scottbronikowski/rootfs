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
	{ 0xd9d2bb03, "snd_usbmidi_disconnect" },
	{ 0xa286a234, "snd_pcm_format_name" },
	{ 0x4ed5d791, "snd_pcm_period_elapsed" },
	{ 0x8afa5b96, "snd_card_create" },
	{ 0x8b7fb99f, "snd_usbmidi_create" },
	{ 0xbdf5a09, "snd_card_disconnect" },
	{ 0x6e7e9b5, "snd_pcm_suspend_all" },
	{ 0xb9638db4, "snd_pcm_rate_to_rate_bit" },
	{ 0x3ad3d301, "snd_device_new" },
	{ 0x6baf0240, "snd_pcm_hw_constraint_list" },
	{ 0x812fad33, "snd_pcm_set_ops" },
	{ 0xa632d98f, "snd_ctl_notify" },
	{ 0x3c620f24, "snd_card_free_when_closed" },
	{ 0xec692440, "snd_pcm_lib_get_vmalloc_page" },
	{ 0x6a3ef9a0, "snd_pcm_new_stream" },
	{ 0x16928ed0, "snd_hwdep_new" },
	{ 0x3117087f, "snd_pcm_lib_ioctl" },
	{ 0x8a6b45d7, "snd_ctl_boolean_mono_info" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x81b69e41, "snd_ctl_enum_info" },
	{ 0x51f74167, "snd_pcm_hw_rule_add" },
	{ 0xc6665f99, "snd_component_add" },
	{ 0x4b29de69, "_snd_pcm_lib_alloc_vmalloc_buffer" },
	{ 0x781cec74, "snd_ctl_new1" },
	{ 0x8c8ef6f0, "snd_ctl_find_id" },
	{ 0x68a24153, "snd_pcm_format_physical_width" },
	{ 0x213a536b, "snd_pcm_hw_constraint_minmax" },
	{ 0x8a6f1569, "snd_card_proc_new" },
	{ 0x1d42e941, "snd_card_free" },
	{ 0x31bb5a2c, "snd_card_register" },
	{ 0xec2d4b7e, "snd_pcm_new" },
	{ 0x4b9785e3, "snd_pcm_lib_free_vmalloc_buffer" },
	{ 0x6f1394f7, "snd_ctl_add" },
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

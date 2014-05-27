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
	{ 0xbad81d96, "snd_rawmidi_set_ops" },
	{ 0x162b8c05, "snd_rawmidi_new" },
	{ 0xa632d98f, "snd_ctl_notify" },
	{ 0x31b265c7, "snd_rawmidi_transmit_peek" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x81b69e41, "snd_ctl_enum_info" },
	{ 0x1d6eb59d, "snd_rawmidi_transmit_ack" },
	{ 0x781cec74, "snd_ctl_new1" },
	{ 0x6f1394f7, "snd_ctl_add" },
	{ 0x7a6d9ae3, "snd_rawmidi_transmit" },
	{ 0x6146ee20, "snd_rawmidi_transmit_empty" },
	{ 0x16e50546, "snd_rawmidi_receive" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd-rawmidi,snd";


MODULE_INFO(srcversion, "B34E61E5A93EC927C4C2A6D");

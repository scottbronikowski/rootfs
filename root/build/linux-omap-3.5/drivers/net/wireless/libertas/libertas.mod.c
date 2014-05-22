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
	{ 0xab40c106, "wiphy_free" },
	{ 0x7513e94e, "ieee80211_channel_to_frequency" },
	{ 0x593af7ca, "__ieee80211_get_channel" },
	{ 0xd1e02769, "cfg80211_get_bss" },
	{ 0x2d0f99e5, "print_ssid" },
	{ 0x7db427f5, "wiphy_unregister" },
	{ 0xed1b7313, "cfg80211_connect_result" },
	{ 0x1826afa1, "cfg80211_michael_mic_failure" },
	{ 0x8855226b, "cfg80211_ibss_joined" },
	{ 0x93382fa6, "ieee80211_bss_get_ie" },
	{ 0xe1c79841, "cfg80211_inform_bss" },
	{ 0x67b9e73f, "cfg80211_put_bss" },
	{ 0x6beb1d5e, "wiphy_new" },
	{ 0x1366f9c2, "wiphy_register" },
	{ 0x39cce62f, "cfg80211_disconnected" },
	{ 0xd9869139, "regulatory_hint" },
	{ 0x9b5b54f3, "cfg80211_scan_done" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=cfg80211,lib80211";


MODULE_INFO(srcversion, "31BF3D48D6A01F4E9EAEC65");

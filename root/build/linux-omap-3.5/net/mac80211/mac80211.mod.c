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
	{ 0xdf30629c, "cfg80211_cqm_rssi_notify" },
	{ 0xab40c106, "wiphy_free" },
	{ 0xd3bd80b2, "cfg80211_unlink_bss" },
	{ 0x1879fcbd, "bridge_tunnel_header" },
	{ 0x9c64fbd, "ieee80211_frequency_to_channel" },
	{ 0x51c00780, "cfg80211_inform_bss_frame" },
	{ 0x7ef39823, "ieee80211_hdrlen" },
	{ 0xbdafbd2d, "cfg80211_rx_mgmt" },
	{ 0x7513e94e, "ieee80211_channel_to_frequency" },
	{ 0xc63f1b81, "ieee80211_radiotap_iterator_next" },
	{ 0x35ea1627, "cfg80211_send_rx_assoc" },
	{ 0xa635312a, "ieee80211_data_to_8023" },
	{ 0xe19fafba, "cfg80211_probe_status" },
	{ 0x1db98441, "cfg80211_del_sta" },
	{ 0x7fe1a403, "cfg80211_find_ie" },
	{ 0xcd53a375, "cfg80211_mgmt_tx_status" },
	{ 0x69b18f43, "rfc1042_header" },
	{ 0x593af7ca, "__ieee80211_get_channel" },
	{ 0xd1e02769, "cfg80211_get_bss" },
	{ 0x982e6b6d, "ieee80211_radiotap_iterator_init" },
	{ 0x63ecb02b, "cfg80211_send_disassoc" },
	{ 0x7db427f5, "wiphy_unregister" },
	{ 0x822f8ab3, "cfg80211_send_rx_auth" },
	{ 0xb0eeeefc, "cfg80211_cqm_pktloss_notify" },
	{ 0x1826afa1, "cfg80211_michael_mic_failure" },
	{ 0x39652ecd, "cfg80211_report_obss_beacon" },
	{ 0x6753c4c6, "__cfg80211_send_disassoc" },
	{ 0x8855226b, "cfg80211_ibss_joined" },
	{ 0x778f841e, "cfg80211_rx_spurious_frame" },
	{ 0x93382fa6, "ieee80211_bss_get_ie" },
	{ 0x4a61c38a, "cfg80211_can_beacon_sec_chan" },
	{ 0x19621f84, "cfg80211_gtk_rekey_notify" },
	{ 0x67b9e73f, "cfg80211_put_bss" },
	{ 0x6beb1d5e, "wiphy_new" },
	{ 0x1366f9c2, "wiphy_register" },
	{ 0x469a2477, "cfg80211_send_unprot_disassoc" },
	{ 0x7d7e5fc5, "cfg80211_classify8021d" },
	{ 0x2f2b32f8, "cfg80211_ready_on_channel" },
	{ 0x5a918374, "cfg80211_calculate_bitrate" },
	{ 0x6892f68e, "cfg80211_send_unprot_deauth" },
	{ 0x33e27909, "cfg80211_new_sta" },
	{ 0x7b087301, "__cfg80211_send_deauth" },
	{ 0x44777ade, "cfg80211_ref_bss" },
	{ 0x42583518, "cfg80211_send_deauth" },
	{ 0x34eb3faf, "ieee80211_amsdu_to_8023s" },
	{ 0xa4dcac7e, "cfg80211_remain_on_channel_expired" },
	{ 0x743f8ac3, "cfg80211_send_auth_timeout" },
	{ 0xa158940a, "cfg80211_sched_scan_stopped" },
	{ 0x9b5b54f3, "cfg80211_scan_done" },
	{ 0xd95dbf7c, "cfg80211_rx_unexpected_4addr_frame" },
	{ 0x58a691f5, "cfg80211_sched_scan_results" },
	{ 0xef24ce1d, "cfg80211_send_assoc_timeout" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=cfg80211";


MODULE_INFO(srcversion, "0655FFFF65713DFC4E767EC");

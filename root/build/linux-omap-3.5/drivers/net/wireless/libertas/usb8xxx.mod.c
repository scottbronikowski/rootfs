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
	{ 0x86690996, "lbs_host_sleep_cfg" },
	{ 0x82138b0f, "lbs_resume" },
	{ 0x521e4e24, "lbs_stop_card" },
	{ 0xa5343580, "__lbs_cmd" },
	{ 0x1efc8c08, "lbs_start_card" },
	{ 0x2bee29c9, "lbs_queue_event" },
	{ 0xa0050a20, "lbs_send_tx_feedback" },
	{ 0x9d840d8, "lbs_get_firmware_async" },
	{ 0xb1342a12, "lbs_cmd_copyback" },
	{ 0x70d17f86, "lbs_suspend" },
	{ 0xf64277de, "lbs_debug" },
	{ 0x7937c8f3, "lbs_remove_card" },
	{ 0x75dcb433, "lbs_process_rxed_packet" },
	{ 0xce99bd5e, "lbs_host_to_card_done" },
	{ 0x370338f9, "lbs_add_card" },
	{ 0x6c691469, "lbs_notify_command_response" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=libertas";

MODULE_ALIAS("usb:v1286p2001d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v05A3p8388d*dc*dsc*dp*ic*isc*ip*");

MODULE_INFO(srcversion, "B1DF2B8E33FD86730B0510D");

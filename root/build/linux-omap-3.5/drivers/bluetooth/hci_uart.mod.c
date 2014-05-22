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
	{ 0xb696507d, "hci_recv_stream_fragment" },
	{ 0x223faa8e, "hci_register_dev" },
	{ 0x6c39351f, "hci_recv_frame" },
	{ 0x164f3a50, "hci_unregister_dev" },
	{ 0xb61a0c3b, "bt_err" },
	{ 0x7c640527, "bt_info" },
	{ 0xadf5f00a, "hci_alloc_dev" },
	{ 0xafbb2502, "hci_free_dev" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=bluetooth";


MODULE_INFO(srcversion, "B002D3E4F5B2C117744F71B");

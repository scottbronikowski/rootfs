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
	{ 0x24a94b26, "snd_info_get_line" },
	{ 0x43d70f21, "snd_device_register" },
	{ 0x3b91f3af, "snd_free_pages" },
	{ 0x25d927e2, "snd_register_device_for_dev" },
	{ 0x5290a820, "snd_card_file_remove" },
	{ 0x1dbc417f, "snd_dma_alloc_pages" },
	{ 0x339ab921, "snd_device_free" },
	{ 0x5de68e5, "snd_power_wait" },
	{ 0xf68aa3d7, "snd_info_create_card_entry" },
	{ 0xb2e5ae4a, "snd_lookup_minor_data" },
	{ 0x961caa08, "snd_ctl_unregister_ioctl" },
	{ 0x19344645, "snd_dma_get_reserved_buf" },
	{ 0x3ad3d301, "snd_device_new" },
	{ 0x28cb6d11, "snd_timer_new" },
	{ 0x812c3314, "snd_unregister_device" },
	{ 0xade88e76, "snd_malloc_pages" },
	{ 0x8f595b11, "snd_major" },
	{ 0x4b015768, "snd_iprintf" },
	{ 0x3ca17104, "__snd_printk" },
	{ 0x94453b83, "snd_card_file_add" },
	{ 0x65e2c205, "snd_ctl_register_ioctl" },
	{ 0xe2c2029b, "snd_dma_free_pages" },
	{ 0xa6f36b40, "snd_dma_reserve_buf" },
	{ 0x9e6d79f8, "snd_info_get_str" },
	{ 0xcce593ff, "snd_add_device_sysfs_file" },
	{ 0x7bec87d, "snd_info_free_entry" },
	{ 0x7a2fc224, "snd_timer_interrupt" },
	{ 0xe4f24a61, "snd_timer_notify" },
	{ 0xdfd177d1, "snd_info_create_module_entry" },
	{ 0x969c5f86, "snd_info_register" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=snd,snd-page-alloc,snd-timer";


MODULE_INFO(srcversion, "4BB9CF33451404FCDA7A799");

cmd_/root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/rtw_xmit.o := gcc -Wp,-MD,/root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/.rtw_xmit.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabihf/4.6/include -I/usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include -Iarch/armv7l/include/generated -Iinclude  -include /usr/src/linux-headers-3.5.0-2-linaro-omap/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-omap2/include -Iarch/arm/plat-omap/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -O1 -Wno-unused-variable -Wno-unused-value -Wno-unused-label -Wno-unused-parameter -Wno-unused-function -Wno-unused -Wno-uninitialized -I/root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include -DCONFIG_POWER_SAVING -DCONFIG_LITTLE_ENDIAN  -DMODULE  -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(rtw_xmit)"  -D"KBUILD_MODNAME=KBUILD_STR(8192cu)" -c -o /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/.tmp_rtw_xmit.o /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/rtw_xmit.c

source_/root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/rtw_xmit.o := /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/rtw_xmit.c

deps_/root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/rtw_xmit.o := \
    $(wildcard include/config/usb/hci.h) \
    $(wildcard include/config/sdio/hci.h) \
    $(wildcard include/config/xmit/ack.h) \
    $(wildcard include/config/lps.h) \
    $(wildcard include/config/concurrent/mode.h) \
    $(wildcard include/config/usb/tx/aggregation.h) \
    $(wildcard include/config/tdls.h) \
    $(wildcard include/config/wfd.h) \
    $(wildcard include/config/ieee80211w.h) \
    $(wildcard include/config/pci/hci.h) \
    $(wildcard include/config/gspi/hci.h) \
    $(wildcard include/config/rtl8711.h) \
    $(wildcard include/config/br/ext.h) \
    $(wildcard include/config/ap/mode.h) \
    $(wildcard include/config/xmit/ack/polling.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/drv_conf.h \
    $(wildcard include/config/android.h) \
    $(wildcard include/config/platform/android.h) \
    $(wildcard include/config/validate/ssid.h) \
    $(wildcard include/config/signal/display/dbm.h) \
    $(wildcard include/config/has/earlysuspend.h) \
    $(wildcard include/config/resume/in/workqueue.h) \
    $(wildcard include/config/android/power.h) \
    $(wildcard include/config/wakelock.h) \
    $(wildcard include/config/usb/vendor/req/buffer/prealloc.h) \
    $(wildcard include/config/usb/vendor/req/mutex.h) \
    $(wildcard include/config/vendor/req/retry.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/autoconf.h \
    $(wildcard include/config/rtl8192c.h) \
    $(wildcard include/config/ioctl/cfg80211.h) \
    $(wildcard include/config/cfg80211/force/compatible/2/6/37/under.h) \
    $(wildcard include/config/debug/cfg80211.h) \
    $(wildcard include/config/drv/issue/prov/req.h) \
    $(wildcard include/config/set/scan/deny/timer.h) \
    $(wildcard include/config/pwrctrl.h) \
    $(wildcard include/config/h2clbk.h) \
    $(wildcard include/config/embedded/fwimg.h) \
    $(wildcard include/config/file/fwimg.h) \
    $(wildcard include/config/wake/on/wlan.h) \
    $(wildcard include/config/wowlan.h) \
    $(wildcard include/config/r871x/test.h) \
    $(wildcard include/config/active/keep/alive/check.h) \
    $(wildcard include/config/80211n/ht.h) \
    $(wildcard include/config/recv/reordering/ctrl.h) \
    $(wildcard include/config/tcp/csum/offload/rx.h) \
    $(wildcard include/config/before/linked/dig.h) \
    $(wildcard include/config/drvext.h) \
    $(wildcard include/config/mp/included.h) \
    $(wildcard include/config/ips.h) \
    $(wildcard include/config/ips/level/2.h) \
    $(wildcard include/config/bt/coexist.h) \
    $(wildcard include/config/antenna/diversity.h) \
    $(wildcard include/config/sw/antenna/diversity.h) \
    $(wildcard include/config/hw/antenna/diversity.h) \
    $(wildcard include/config/iol.h) \
    $(wildcard include/config/mp/iwpriv/support.h) \
    $(wildcard include/config/nativeap/mlme.h) \
    $(wildcard include/config/hostapd/mlme.h) \
    $(wildcard include/config/find/best/channel.h) \
    $(wildcard include/config/no/wireless/handlers.h) \
    $(wildcard include/config/p2p.h) \
    $(wildcard include/config/wifi/test.h) \
    $(wildcard include/config/p2p/remove/group/info.h) \
    $(wildcard include/config/dbg/p2p.h) \
    $(wildcard include/config/p2p/ps.h) \
    $(wildcard include/config/p2p/ips.h) \
    $(wildcard include/config/tdls/autosetup.h) \
    $(wildcard include/config/tdls/autocheckalive.h) \
    $(wildcard include/config/skb/copy.h) \
    $(wildcard include/config/led.h) \
    $(wildcard include/config/sw/led.h) \
    $(wildcard include/config/led/handled/by/cmd/thread.h) \
    $(wildcard include/config/global/ui/pid.h) \
    $(wildcard include/config/layer2/roaming.h) \
    $(wildcard include/config/layer2/roaming/resume.h) \
    $(wildcard include/config/adaptor/info/caching/file.h) \
    $(wildcard include/config/long/delay/issue.h) \
    $(wildcard include/config/new/signal/stat/process.h) \
    $(wildcard include/config/deauth/before/connect.h) \
    $(wildcard include/config/iol/llt.h) \
    $(wildcard include/config/iol/mac.h) \
    $(wildcard include/config/iol/bb/phy/reg.h) \
    $(wildcard include/config/iol/bb/agc/tab.h) \
    $(wildcard include/config/iol/rf/rf90/path/a.h) \
    $(wildcard include/config/iol/rf/rf90/path/b.h) \
    $(wildcard include/config/br/ext/brname.h) \
    $(wildcard include/config/tx/mcast2uni.h) \
    $(wildcard include/config/dm/adaptivity.h) \
    $(wildcard include/config/check/ac/lifetime.h) \
    $(wildcard include/config/tsf/reset/offload.h) \
    $(wildcard include/config/hwport/swap.h) \
    $(wildcard include/config/sta/mode/scan/under/ap/mode.h) \
    $(wildcard include/config/multi/vir/ifaces.h) \
    $(wildcard include/config/80211d.h) \
    $(wildcard include/config/usb/one/out/ep.h) \
    $(wildcard include/config/usb/interrupt/in/pipe.h) \
    $(wildcard include/config/minimal/memory/usage.h) \
    $(wildcard include/config/usb/rx/aggregation.h) \
    $(wildcard include/config/prealloc/recv/skb.h) \
    $(wildcard include/config/reduce/usb/tx/int.h) \
    $(wildcard include/config/easy/replacement.h) \
    $(wildcard include/config/use/usb/buffer/alloc/xx.h) \
    $(wildcard include/config/use/usb/buffer/alloc/tx.h) \
    $(wildcard include/config/use/usb/buffer/alloc/rx.h) \
    $(wildcard include/config/usb/vendor/req/buffer/dynamic/allocate.h) \
    $(wildcard include/config/usb/support/async/vdn/req.h) \
    $(wildcard include/config/only/one/out/ep/to/low.h) \
    $(wildcard include/config/out/ep/wifi/mode.h) \
    $(wildcard include/config/platform/mn10300.h) \
    $(wildcard include/config/special/setting/for/funai/tv.h) \
    $(wildcard include/config/wistron/platform.h) \
    $(wildcard include/config/platform/ti/dm365.h) \
    $(wildcard include/config/attempt/to/fix/ap/beacon/error.h) \
    $(wildcard include/config/debug/rtl871x.h) \
    $(wildcard include/config/debug/rtl819x.h) \
    $(wildcard include/config/proc/debug.h) \
    $(wildcard include/config/error/detect.h) \
    $(wildcard include/config/error/reset.h) \
    $(wildcard include/config/single/xmit/buf.h) \
    $(wildcard include/config/single/recv/buf.h) \
    $(wildcard include/config/busy/traffic/skip/pwr/track.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/osdep_service.h \
    $(wildcard include/config/ktime/scalar.h) \
    $(wildcard include/config/xfrm.h) \
    $(wildcard include/config/nf/conntrack.h) \
    $(wildcard include/config/bridge/netfilter.h) \
    $(wildcard include/config/net/sched.h) \
    $(wildcard include/config/net/cls/act.h) \
    $(wildcard include/config/ipv6/ndisc/nodetype.h) \
    $(wildcard include/config/net/dma.h) \
    $(wildcard include/config/network/secmark.h) \
    $(wildcard include/config/tcp/csum/offload/tx.h) \
    $(wildcard include/config/usb/suspend.h) \
    $(wildcard include/config/autosuspend.h) \
    $(wildcard include/config/use/vmalloc.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/basic_types.h \
  include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/types.h \
  include/asm-generic/int-ll64.h \
  arch/armv7l/include/generated/asm/bitsperlong.h \
  include/asm-generic/bitsperlong.h \
  include/linux/posix_types.h \
  include/linux/stddef.h \
  include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  include/linux/compiler-gcc4.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/posix_types.h \
  include/asm-generic/posix_types.h \
  include/linux/version.h \
  include/linux/spinlock.h \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/debug/spinlock.h) \
    $(wildcard include/config/generic/lockbreak.h) \
    $(wildcard include/config/preempt.h) \
    $(wildcard include/config/debug/lock/alloc.h) \
  include/linux/typecheck.h \
  include/linux/preempt.h \
    $(wildcard include/config/debug/preempt.h) \
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/preempt/count.h) \
    $(wildcard include/config/preempt/notifiers.h) \
  include/linux/thread_info.h \
    $(wildcard include/config/compat.h) \
    $(wildcard include/config/debug/stack/usage.h) \
  include/linux/bug.h \
    $(wildcard include/config/generic/bug.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/thumb2/kernel.h) \
    $(wildcard include/config/debug/bugverbose.h) \
    $(wildcard include/config/arm/lpae.h) \
  include/linux/linkage.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/linkage.h \
  include/asm-generic/bug.h \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/ring/buffer.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/numa.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  include/linux/sysinfo.h \
  /usr/lib/gcc/arm-linux-gnueabihf/4.6/include/stdarg.h \
  include/linux/bitops.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/bitops.h \
  include/linux/irqflags.h \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/irqflags.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/ptrace.h \
    $(wildcard include/config/cpu/endian/be8.h) \
    $(wildcard include/config/arm/thumb.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/hwcap.h \
  include/asm-generic/bitops/non-atomic.h \
  include/asm-generic/bitops/fls64.h \
  include/asm-generic/bitops/sched.h \
  include/asm-generic/bitops/hweight.h \
  include/asm-generic/bitops/arch_hweight.h \
  include/asm-generic/bitops/const_hweight.h \
  include/asm-generic/bitops/lock.h \
  include/asm-generic/bitops/le.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/byteorder.h \
  include/linux/byteorder/little_endian.h \
  include/linux/swab.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/swab.h \
  include/linux/byteorder/generic.h \
  include/asm-generic/bitops/ext2-atomic-setbit.h \
  include/linux/log2.h \
    $(wildcard include/config/arch/has/ilog2/u32.h) \
    $(wildcard include/config/arch/has/ilog2/u64.h) \
  include/linux/printk.h \
    $(wildcard include/config/printk.h) \
    $(wildcard include/config/dynamic/debug.h) \
  include/linux/init.h \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/hotplug.h) \
  include/linux/dynamic_debug.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/div64.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/compiler.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/thread_info.h \
    $(wildcard include/config/arm/thumbee.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/fpstate.h \
    $(wildcard include/config/vfpv3.h) \
    $(wildcard include/config/iwmmxt.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/domain.h \
    $(wildcard include/config/io/36.h) \
    $(wildcard include/config/cpu/use/domains.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/barrier.h \
    $(wildcard include/config/cpu/32v6k.h) \
    $(wildcard include/config/cpu/xsc3.h) \
    $(wildcard include/config/cpu/fa526.h) \
    $(wildcard include/config/arch/has/barriers.h) \
    $(wildcard include/config/arm/dma/mem/bufferable.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/outercache.h \
    $(wildcard include/config/outer/cache/sync.h) \
    $(wildcard include/config/outer/cache.h) \
  include/linux/list.h \
    $(wildcard include/config/debug/list.h) \
  include/linux/poison.h \
    $(wildcard include/config/illegal/pointer/value.h) \
  include/linux/const.h \
  include/linux/stringify.h \
  include/linux/bottom_half.h \
  include/linux/spinlock_types.h \
  include/linux/spinlock_types_up.h \
  include/linux/lockdep.h \
    $(wildcard include/config/lockdep.h) \
    $(wildcard include/config/lock/stat.h) \
    $(wildcard include/config/prove/rcu.h) \
  include/linux/rwlock_types.h \
  include/linux/spinlock_up.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/processor.h \
    $(wildcard include/config/have/hw/breakpoint.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/arm/errata/754327.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/hw_breakpoint.h \
  include/linux/rwlock.h \
  include/linux/spinlock_api_up.h \
  include/linux/atomic.h \
    $(wildcard include/config/arch/has/atomic/or.h) \
    $(wildcard include/config/generic/atomic64.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/atomic.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/cmpxchg.h \
    $(wildcard include/config/cpu/sa1100.h) \
    $(wildcard include/config/cpu/sa110.h) \
    $(wildcard include/config/cpu/v6.h) \
  include/asm-generic/cmpxchg-local.h \
  include/asm-generic/atomic-long.h \
  include/linux/errno.h \
  arch/armv7l/include/generated/asm/errno.h \
  include/asm-generic/errno.h \
  include/asm-generic/errno-base.h \
  include/linux/slab.h \
    $(wildcard include/config/slab/debug.h) \
    $(wildcard include/config/debug/objects.h) \
    $(wildcard include/config/kmemcheck.h) \
    $(wildcard include/config/failslab.h) \
    $(wildcard include/config/slub.h) \
    $(wildcard include/config/slob.h) \
    $(wildcard include/config/debug/slab.h) \
    $(wildcard include/config/slab.h) \
  include/linux/gfp.h \
    $(wildcard include/config/highmem.h) \
    $(wildcard include/config/zone/dma.h) \
    $(wildcard include/config/zone/dma32.h) \
    $(wildcard include/config/pm/sleep.h) \
    $(wildcard include/config/cma.h) \
  include/linux/mmzone.h \
    $(wildcard include/config/force/max/zoneorder.h) \
    $(wildcard include/config/cgroup/mem/res/ctlr.h) \
    $(wildcard include/config/memory/hotplug.h) \
    $(wildcard include/config/sparsemem.h) \
    $(wildcard include/config/have/memblock/node/map.h) \
    $(wildcard include/config/discontigmem.h) \
    $(wildcard include/config/flat/node/mem/map.h) \
    $(wildcard include/config/no/bootmem.h) \
    $(wildcard include/config/have/memory/present.h) \
    $(wildcard include/config/have/memoryless/nodes.h) \
    $(wildcard include/config/need/node/memmap/size.h) \
    $(wildcard include/config/have/memblock/node.h) \
    $(wildcard include/config/need/multiple/nodes.h) \
    $(wildcard include/config/have/arch/early/pfn/to/nid.h) \
    $(wildcard include/config/flatmem.h) \
    $(wildcard include/config/sparsemem/extreme.h) \
    $(wildcard include/config/have/arch/pfn/valid.h) \
    $(wildcard include/config/nodes/span/other/nodes.h) \
    $(wildcard include/config/holes/in/zone.h) \
    $(wildcard include/config/arch/has/holes/memorymodel.h) \
  include/linux/wait.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/current.h \
  include/linux/cache.h \
    $(wildcard include/config/arch/has/cache/line/size.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/cache.h \
    $(wildcard include/config/arm/l1/cache/shift.h) \
    $(wildcard include/config/aeabi.h) \
  include/linux/threads.h \
    $(wildcard include/config/nr/cpus.h) \
    $(wildcard include/config/base/small.h) \
  include/linux/numa.h \
    $(wildcard include/config/nodes/shift.h) \
  include/linux/seqlock.h \
  include/linux/nodemask.h \
  include/linux/bitmap.h \
  include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/string.h \
  include/linux/pageblock-flags.h \
    $(wildcard include/config/hugetlb/page.h) \
    $(wildcard include/config/hugetlb/page/size/variable.h) \
  include/generated/bounds.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/page.h \
    $(wildcard include/config/cpu/copy/v4wt.h) \
    $(wildcard include/config/cpu/copy/v4wb.h) \
    $(wildcard include/config/cpu/copy/feroceon.h) \
    $(wildcard include/config/cpu/copy/fa.h) \
    $(wildcard include/config/cpu/xscale.h) \
    $(wildcard include/config/cpu/copy/v6.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/glue.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/pgtable-2level-types.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/memory.h \
    $(wildcard include/config/need/mach/memory/h.h) \
    $(wildcard include/config/page/offset.h) \
    $(wildcard include/config/dram/size.h) \
    $(wildcard include/config/dram/base.h) \
    $(wildcard include/config/have/tcm.h) \
    $(wildcard include/config/arm/patch/phys/virt.h) \
    $(wildcard include/config/phys/offset.h) \
  arch/armv7l/include/generated/asm/sizes.h \
  include/asm-generic/sizes.h \
  include/asm-generic/memory_model.h \
    $(wildcard include/config/sparsemem/vmemmap.h) \
  include/asm-generic/getorder.h \
  include/linux/memory_hotplug.h \
    $(wildcard include/config/memory/hotremove.h) \
    $(wildcard include/config/have/arch/nodedata/extension.h) \
  include/linux/notifier.h \
  include/linux/mutex.h \
    $(wildcard include/config/debug/mutexes.h) \
    $(wildcard include/config/have/arch/mutex/cpu/relax.h) \
  include/linux/mutex-debug.h \
  include/linux/rwsem.h \
    $(wildcard include/config/rwsem/generic/spinlock.h) \
  include/linux/rwsem-spinlock.h \
  include/linux/srcu.h \
  include/linux/rcupdate.h \
    $(wildcard include/config/rcu/torture/test.h) \
    $(wildcard include/config/tree/rcu.h) \
    $(wildcard include/config/tree/preempt/rcu.h) \
    $(wildcard include/config/rcu/trace.h) \
    $(wildcard include/config/preempt/rcu.h) \
    $(wildcard include/config/tiny/rcu.h) \
    $(wildcard include/config/tiny/preempt/rcu.h) \
    $(wildcard include/config/debug/objects/rcu/head.h) \
    $(wildcard include/config/hotplug/cpu.h) \
    $(wildcard include/config/preempt/rt.h) \
  include/linux/cpumask.h \
    $(wildcard include/config/cpumask/offstack.h) \
    $(wildcard include/config/debug/per/cpu/maps.h) \
    $(wildcard include/config/disable/obsolete/cpumask/functions.h) \
  include/linux/completion.h \
  include/linux/debugobjects.h \
    $(wildcard include/config/debug/objects/free.h) \
  include/linux/rcutiny.h \
  include/linux/workqueue.h \
    $(wildcard include/config/debug/objects/work.h) \
    $(wildcard include/config/freezer.h) \
  include/linux/timer.h \
    $(wildcard include/config/timer/stats.h) \
    $(wildcard include/config/debug/objects/timers.h) \
  include/linux/ktime.h \
  include/linux/time.h \
    $(wildcard include/config/arch/uses/gettimeoffset.h) \
  include/linux/math64.h \
  include/linux/jiffies.h \
  include/linux/timex.h \
  include/linux/param.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/param.h \
    $(wildcard include/config/hz.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/timex.h \
  arch/arm/mach-omap2/include/mach/timex.h \
  arch/arm/plat-omap/include/plat/timex.h \
    $(wildcard include/config/omap/32k/timer.h) \
    $(wildcard include/config/omap/32k/timer/hz.h) \
  include/linux/topology.h \
    $(wildcard include/config/sched/smt.h) \
    $(wildcard include/config/sched/mc.h) \
    $(wildcard include/config/sched/book.h) \
    $(wildcard include/config/use/percpu/numa/node/id.h) \
  include/linux/smp.h \
    $(wildcard include/config/use/generic/smp/helpers.h) \
  include/linux/percpu.h \
    $(wildcard include/config/need/per/cpu/embed/first/chunk.h) \
    $(wildcard include/config/need/per/cpu/page/first/chunk.h) \
    $(wildcard include/config/have/setup/per/cpu/area.h) \
  include/linux/pfn.h \
  arch/armv7l/include/generated/asm/percpu.h \
  include/asm-generic/percpu.h \
  include/linux/percpu-defs.h \
    $(wildcard include/config/debug/force/weak/per/cpu.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/topology.h \
    $(wildcard include/config/arm/cpu/topology.h) \
  include/asm-generic/topology.h \
  include/linux/mmdebug.h \
    $(wildcard include/config/debug/vm.h) \
    $(wildcard include/config/debug/virtual.h) \
  include/linux/slab_def.h \
  include/linux/kmalloc_sizes.h \
  include/linux/module.h \
    $(wildcard include/config/sysfs.h) \
    $(wildcard include/config/unused/symbols.h) \
    $(wildcard include/config/kallsyms.h) \
    $(wildcard include/config/tracepoints.h) \
    $(wildcard include/config/event/tracing.h) \
    $(wildcard include/config/module/unload.h) \
    $(wildcard include/config/constructors.h) \
    $(wildcard include/config/debug/set/module/ronx.h) \
  include/linux/stat.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/stat.h \
  include/linux/uidgid.h \
    $(wildcard include/config/uidgid/strict/type/checks.h) \
    $(wildcard include/config/user/ns.h) \
  include/linux/highuid.h \
  include/linux/kmod.h \
  include/linux/sysctl.h \
    $(wildcard include/config/sysctl.h) \
  include/linux/rbtree.h \
  include/linux/elf.h \
  include/linux/elf-em.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/elf.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/user.h \
  include/linux/kobject.h \
  include/linux/sysfs.h \
  include/linux/kobject_ns.h \
  include/linux/kref.h \
  include/linux/moduleparam.h \
    $(wildcard include/config/alpha.h) \
    $(wildcard include/config/ia64.h) \
    $(wildcard include/config/ppc64.h) \
  include/linux/tracepoint.h \
  include/linux/static_key.h \
  include/linux/jump_label.h \
    $(wildcard include/config/jump/label.h) \
  include/linux/export.h \
    $(wildcard include/config/symbol/prefix.h) \
    $(wildcard include/config/modversions.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/module.h \
    $(wildcard include/config/arm/unwind.h) \
  include/linux/netdevice.h \
    $(wildcard include/config/dcb.h) \
    $(wildcard include/config/wlan.h) \
    $(wildcard include/config/ax25.h) \
    $(wildcard include/config/mac80211/mesh.h) \
    $(wildcard include/config/tr.h) \
    $(wildcard include/config/net/ipip.h) \
    $(wildcard include/config/net/ipgre.h) \
    $(wildcard include/config/ipv6/sit.h) \
    $(wildcard include/config/ipv6/tunnel.h) \
    $(wildcard include/config/rps.h) \
    $(wildcard include/config/netpoll.h) \
    $(wildcard include/config/xps.h) \
    $(wildcard include/config/bql.h) \
    $(wildcard include/config/rfs/accel.h) \
    $(wildcard include/config/fcoe.h) \
    $(wildcard include/config/net/poll/controller.h) \
    $(wildcard include/config/libfcoe.h) \
    $(wildcard include/config/wireless/ext.h) \
    $(wildcard include/config/vlan/8021q.h) \
    $(wildcard include/config/net/dsa.h) \
    $(wildcard include/config/net/ns.h) \
    $(wildcard include/config/netprio/cgroup.h) \
    $(wildcard include/config/net/dsa/tag/dsa.h) \
    $(wildcard include/config/net/dsa/tag/trailer.h) \
    $(wildcard include/config/netpoll/trap.h) \
    $(wildcard include/config/proc/fs.h) \
  include/linux/if.h \
  include/linux/socket.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/socket.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/sockios.h \
  include/linux/sockios.h \
  include/linux/uio.h \
  include/linux/hdlc/ioctl.h \
  include/linux/if_ether.h \
  include/linux/skbuff.h \
    $(wildcard include/config/nf/defrag/ipv4.h) \
    $(wildcard include/config/nf/defrag/ipv6.h) \
    $(wildcard include/config/network/phy/timestamping.h) \
  include/linux/kmemcheck.h \
  include/linux/mm_types.h \
    $(wildcard include/config/split/ptlock/cpus.h) \
    $(wildcard include/config/have/cmpxchg/double.h) \
    $(wildcard include/config/have/aligned/struct/page.h) \
    $(wildcard include/config/want/page/debug/flags.h) \
    $(wildcard include/config/aio.h) \
    $(wildcard include/config/mm/owner.h) \
    $(wildcard include/config/mmu/notifier.h) \
    $(wildcard include/config/transparent/hugepage.h) \
  include/linux/auxvec.h \
  arch/armv7l/include/generated/asm/auxvec.h \
  include/asm-generic/auxvec.h \
  include/linux/prio_tree.h \
  include/linux/page-debug-flags.h \
    $(wildcard include/config/page/poisoning.h) \
    $(wildcard include/config/page/guard.h) \
    $(wildcard include/config/page/debug/something/else.h) \
  include/linux/uprobes.h \
    $(wildcard include/config/arch/supports/uprobes.h) \
    $(wildcard include/config/uprobes.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/mmu.h \
    $(wildcard include/config/cpu/has/asid.h) \
  include/linux/net.h \
  include/linux/random.h \
    $(wildcard include/config/arch/random.h) \
  include/linux/ioctl.h \
  arch/armv7l/include/generated/asm/ioctl.h \
  include/asm-generic/ioctl.h \
  include/linux/irqnr.h \
    $(wildcard include/config/generic/hardirqs.h) \
  include/linux/fcntl.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/fcntl.h \
  include/asm-generic/fcntl.h \
  include/linux/textsearch.h \
  include/linux/err.h \
  include/net/checksum.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/uaccess.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/unified.h \
    $(wildcard include/config/arm/asm/unified.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/checksum.h \
  include/linux/in6.h \
  include/linux/dmaengine.h \
    $(wildcard include/config/async/tx/enable/channel/switch.h) \
    $(wildcard include/config/rapidio/dma/engine.h) \
    $(wildcard include/config/dma/engine.h) \
    $(wildcard include/config/async/tx/dma.h) \
  include/linux/device.h \
    $(wildcard include/config/debug/devres.h) \
    $(wildcard include/config/devtmpfs.h) \
    $(wildcard include/config/sysfs/deprecated.h) \
  include/linux/ioport.h \
  include/linux/klist.h \
  include/linux/pm.h \
    $(wildcard include/config/pm.h) \
    $(wildcard include/config/pm/runtime.h) \
    $(wildcard include/config/pm/clk.h) \
    $(wildcard include/config/pm/generic/domains.h) \
  include/linux/ratelimit.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/device.h \
    $(wildcard include/config/dmabounce.h) \
    $(wildcard include/config/iommu/api.h) \
    $(wildcard include/config/arm/dma/use/iommu.h) \
    $(wildcard include/config/arch/omap.h) \
  include/linux/pm_wakeup.h \
  include/linux/scatterlist.h \
    $(wildcard include/config/debug/sg.h) \
  include/linux/mm.h \
    $(wildcard include/config/stack/growsup.h) \
    $(wildcard include/config/ksm.h) \
    $(wildcard include/config/debug/pagealloc.h) \
    $(wildcard include/config/hibernation.h) \
    $(wildcard include/config/hugetlbfs.h) \
  include/linux/debug_locks.h \
    $(wildcard include/config/debug/locking/api/selftests.h) \
  include/linux/range.h \
  include/linux/bit_spinlock.h \
  include/linux/shrinker.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/pgtable.h \
    $(wildcard include/config/highpte.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/proc-fns.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/glue-proc.h \
    $(wildcard include/config/cpu/arm7tdmi.h) \
    $(wildcard include/config/cpu/arm720t.h) \
    $(wildcard include/config/cpu/arm740t.h) \
    $(wildcard include/config/cpu/arm9tdmi.h) \
    $(wildcard include/config/cpu/arm920t.h) \
    $(wildcard include/config/cpu/arm922t.h) \
    $(wildcard include/config/cpu/arm925t.h) \
    $(wildcard include/config/cpu/arm926t.h) \
    $(wildcard include/config/cpu/arm940t.h) \
    $(wildcard include/config/cpu/arm946e.h) \
    $(wildcard include/config/cpu/arm1020.h) \
    $(wildcard include/config/cpu/arm1020e.h) \
    $(wildcard include/config/cpu/arm1022.h) \
    $(wildcard include/config/cpu/arm1026.h) \
    $(wildcard include/config/cpu/mohawk.h) \
    $(wildcard include/config/cpu/feroceon.h) \
    $(wildcard include/config/cpu/v6k.h) \
    $(wildcard include/config/cpu/v7.h) \
  include/asm-generic/pgtable-nopud.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/pgtable-hwdef.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/pgtable-2level-hwdef.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/pgtable-2level.h \
  include/asm-generic/pgtable.h \
  include/linux/page-flags.h \
    $(wildcard include/config/pageflags/extended.h) \
    $(wildcard include/config/arch/uses/pg/uncached.h) \
    $(wildcard include/config/memory/failure.h) \
    $(wildcard include/config/swap.h) \
    $(wildcard include/config/s390.h) \
  include/linux/huge_mm.h \
  include/linux/vmstat.h \
    $(wildcard include/config/vm/event/counters.h) \
  include/linux/vm_event_item.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/scatterlist.h \
    $(wildcard include/config/arm/has/sg/chain.h) \
  include/asm-generic/scatterlist.h \
    $(wildcard include/config/need/sg/dma/length.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/io.h \
    $(wildcard include/config/need/mach/io/h.h) \
    $(wildcard include/config/pcmcia/soc/common.h) \
    $(wildcard include/config/pci.h) \
    $(wildcard include/config/isa.h) \
    $(wildcard include/config/pccard.h) \
  include/asm-generic/pci_iomap.h \
    $(wildcard include/config/no/generic/pci/ioport/map.h) \
    $(wildcard include/config/generic/pci/iomap.h) \
  include/linux/hrtimer.h \
    $(wildcard include/config/high/res/timers.h) \
    $(wildcard include/config/timerfd.h) \
  include/linux/timerqueue.h \
  include/linux/dma-mapping.h \
    $(wildcard include/config/has/dma.h) \
    $(wildcard include/config/arch/has/dma/set/coherent/mask.h) \
    $(wildcard include/config/have/dma/attrs.h) \
    $(wildcard include/config/need/dma/map/state.h) \
  include/linux/dma-attrs.h \
  include/linux/dma-direction.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/dma-mapping.h \
  include/linux/dma-debug.h \
    $(wildcard include/config/dma/api/debug.h) \
  include/asm-generic/dma-coherent.h \
    $(wildcard include/config/have/generic/dma/coherent.h) \
  include/asm-generic/dma-mapping-common.h \
  include/linux/netdev_features.h \
  include/linux/if_packet.h \
  include/linux/if_link.h \
  include/linux/netlink.h \
  include/linux/capability.h \
  include/linux/pm_qos.h \
  include/linux/plist.h \
    $(wildcard include/config/debug/pi/list.h) \
  include/linux/miscdevice.h \
  include/linux/major.h \
  include/linux/delay.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/delay.h \
  include/linux/rculist.h \
  include/linux/dynamic_queue_limits.h \
  include/linux/ethtool.h \
  include/linux/compat.h \
    $(wildcard include/config/arch/want/old/compat/ipc.h) \
  include/net/net_namespace.h \
    $(wildcard include/config/ipv6.h) \
    $(wildcard include/config/ip/dccp.h) \
    $(wildcard include/config/netfilter.h) \
    $(wildcard include/config/wext/core.h) \
    $(wildcard include/config/net.h) \
  include/net/netns/core.h \
  include/net/netns/mib.h \
    $(wildcard include/config/xfrm/statistics.h) \
  include/net/snmp.h \
  include/linux/snmp.h \
  include/linux/u64_stats_sync.h \
  include/net/netns/unix.h \
  include/net/netns/packet.h \
  include/net/netns/ipv4.h \
    $(wildcard include/config/ip/multiple/tables.h) \
    $(wildcard include/config/security.h) \
    $(wildcard include/config/ip/mroute.h) \
    $(wildcard include/config/ip/mroute/multiple/tables.h) \
  include/net/inet_frag.h \
  include/net/netns/ipv6.h \
    $(wildcard include/config/ipv6/multiple/tables.h) \
    $(wildcard include/config/ipv6/mroute.h) \
    $(wildcard include/config/ipv6/mroute/multiple/tables.h) \
  include/net/dst_ops.h \
  include/linux/percpu_counter.h \
  include/net/netns/dccp.h \
  include/net/netns/x_tables.h \
    $(wildcard include/config/bridge/nf/ebtables.h) \
  include/linux/netfilter.h \
    $(wildcard include/config/nf/nat/needed.h) \
  include/linux/in.h \
  include/net/flow.h \
  include/linux/proc_fs.h \
    $(wildcard include/config/proc/devicetree.h) \
    $(wildcard include/config/proc/kcore.h) \
  include/linux/fs.h \
    $(wildcard include/config/fs/posix/acl.h) \
    $(wildcard include/config/quota.h) \
    $(wildcard include/config/fsnotify.h) \
    $(wildcard include/config/ima.h) \
    $(wildcard include/config/epoll.h) \
    $(wildcard include/config/debug/writecount.h) \
    $(wildcard include/config/file/locking.h) \
    $(wildcard include/config/auditsyscall.h) \
    $(wildcard include/config/block.h) \
    $(wildcard include/config/fs/xip.h) \
    $(wildcard include/config/migration.h) \
  include/linux/limits.h \
  include/linux/blk_types.h \
    $(wildcard include/config/blk/cgroup.h) \
    $(wildcard include/config/blk/dev/integrity.h) \
  include/linux/kdev_t.h \
  include/linux/dcache.h \
  include/linux/rculist_bl.h \
  include/linux/list_bl.h \
  include/linux/path.h \
  include/linux/radix-tree.h \
  include/linux/pid.h \
  include/linux/semaphore.h \
  include/linux/fiemap.h \
  include/linux/migrate_mode.h \
  include/linux/quota.h \
    $(wildcard include/config/quota/netlink/interface.h) \
  include/linux/dqblk_xfs.h \
  include/linux/dqblk_v1.h \
  include/linux/dqblk_v2.h \
  include/linux/dqblk_qtree.h \
  include/linux/nfs_fs_i.h \
  include/linux/magic.h \
  include/net/netns/conntrack.h \
  include/linux/list_nulls.h \
  include/net/netns/xfrm.h \
  include/linux/xfrm.h \
  include/linux/seq_file_net.h \
  include/linux/seq_file.h \
  include/net/dsa.h \
  include/net/netprio_cgroup.h \
    $(wildcard include/config/cgroups.h) \
  include/linux/cgroup.h \
  include/linux/sched.h \
    $(wildcard include/config/sched/debug.h) \
    $(wildcard include/config/no/hz.h) \
    $(wildcard include/config/lockup/detector.h) \
    $(wildcard include/config/detect/hung/task.h) \
    $(wildcard include/config/core/dump/default/elf/headers.h) \
    $(wildcard include/config/sched/autogroup.h) \
    $(wildcard include/config/virt/cpu/accounting.h) \
    $(wildcard include/config/bsd/process/acct.h) \
    $(wildcard include/config/taskstats.h) \
    $(wildcard include/config/audit.h) \
    $(wildcard include/config/inotify/user.h) \
    $(wildcard include/config/fanotify.h) \
    $(wildcard include/config/posix/mqueue.h) \
    $(wildcard include/config/keys.h) \
    $(wildcard include/config/perf/events.h) \
    $(wildcard include/config/schedstats.h) \
    $(wildcard include/config/task/delay/acct.h) \
    $(wildcard include/config/fair/group/sched.h) \
    $(wildcard include/config/rt/group/sched.h) \
    $(wildcard include/config/blk/dev/io/trace.h) \
    $(wildcard include/config/rcu/boost.h) \
    $(wildcard include/config/compat/brk.h) \
    $(wildcard include/config/cc/stackprotector.h) \
    $(wildcard include/config/sysvipc.h) \
    $(wildcard include/config/rt/mutexes.h) \
    $(wildcard include/config/task/xacct.h) \
    $(wildcard include/config/cpusets.h) \
    $(wildcard include/config/futex.h) \
    $(wildcard include/config/fault/injection.h) \
    $(wildcard include/config/latencytop.h) \
    $(wildcard include/config/function/graph/tracer.h) \
    $(wildcard include/config/have/unstable/sched/clock.h) \
    $(wildcard include/config/irq/time/accounting.h) \
    $(wildcard include/config/cfs/bandwidth.h) \
    $(wildcard include/config/cgroup/sched.h) \
  arch/armv7l/include/generated/asm/cputime.h \
  include/asm-generic/cputime.h \
  include/linux/sem.h \
  include/linux/ipc.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/ipcbuf.h \
  include/asm-generic/ipcbuf.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/sembuf.h \
  include/linux/signal.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/signal.h \
  include/asm-generic/signal-defs.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/sigcontext.h \
  arch/armv7l/include/generated/asm/siginfo.h \
  include/asm-generic/siginfo.h \
  include/linux/proportions.h \
  include/linux/seccomp.h \
    $(wildcard include/config/seccomp.h) \
    $(wildcard include/config/seccomp/filter.h) \
  include/linux/rtmutex.h \
    $(wildcard include/config/debug/rt/mutexes.h) \
  include/linux/resource.h \
  arch/armv7l/include/generated/asm/resource.h \
  include/asm-generic/resource.h \
  include/linux/task_io_accounting.h \
    $(wildcard include/config/task/io/accounting.h) \
  include/linux/latencytop.h \
  include/linux/cred.h \
    $(wildcard include/config/debug/credentials.h) \
  include/linux/key.h \
  include/linux/selinux.h \
    $(wildcard include/config/security/selinux.h) \
  include/linux/llist.h \
    $(wildcard include/config/arch/have/nmi/safe/cmpxchg.h) \
  include/linux/aio.h \
  include/linux/aio_abi.h \
  include/linux/cgroupstats.h \
  include/linux/taskstats.h \
  include/linux/prio_heap.h \
  include/linux/idr.h \
  include/linux/cgroup_subsys.h \
    $(wildcard include/config/cgroup/debug.h) \
    $(wildcard include/config/cgroup/cpuacct.h) \
    $(wildcard include/config/cgroup/device.h) \
    $(wildcard include/config/cgroup/freezer.h) \
    $(wildcard include/config/net/cls/cgroup.h) \
    $(wildcard include/config/cgroup/perf.h) \
  include/linux/hardirq.h \
  include/linux/ftrace_irq.h \
    $(wildcard include/config/ftrace/nmi/enter.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/hardirq.h \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/irq.h \
    $(wildcard include/config/sparse/irq.h) \
  arch/arm/mach-omap2/include/mach/irqs.h \
  arch/arm/plat-omap/include/plat/irqs.h \
    $(wildcard include/config/mach/omap/innovator.h) \
    $(wildcard include/config/twl4030/core.h) \
    $(wildcard include/config/gpio/twl4030.h) \
    $(wildcard include/config/twl6040/codec.h) \
    $(wildcard include/config/arch/omap2plus.h) \
    $(wildcard include/config/fiq.h) \
  arch/arm/plat-omap/include/plat/irqs-44xx.h \
  arch/arm/mach-omap2/include/mach/hardware.h \
  arch/arm/plat-omap/include/plat/hardware.h \
    $(wildcard include/config/reg/base.h) \
    $(wildcard include/config/arch/omap1.h) \
  arch/arm/plat-omap/include/plat/cpu.h \
    $(wildcard include/config/arch/omap730.h) \
    $(wildcard include/config/arch/omap850.h) \
    $(wildcard include/config/arch/omap15xx.h) \
    $(wildcard include/config/arch/omap16xx.h) \
    $(wildcard include/config/arch/omap2.h) \
    $(wildcard include/config/soc/omap2420.h) \
    $(wildcard include/config/soc/omap2430.h) \
    $(wildcard include/config/arch/omap3.h) \
    $(wildcard include/config/soc/omap3430.h) \
    $(wildcard include/config/arch/omap4.h) \
  arch/arm/plat-omap/include/plat/multi.h \
  arch/arm/plat-omap/include/plat/serial.h \
  arch/arm/plat-omap/include/plat/omap7xx.h \
    $(wildcard include/config/base.h) \
  arch/arm/plat-omap/include/plat/omap1510.h \
  arch/arm/plat-omap/include/plat/omap16xx.h \
  arch/arm/plat-omap/include/plat/omap24xx.h \
  arch/arm/plat-omap/include/plat/omap34xx.h \
  arch/arm/plat-omap/include/plat/omap44xx.h \
  arch/arm/plat-omap/include/plat/ti81xx.h \
  arch/arm/plat-omap/include/plat/am33xx.h \
  include/linux/irq_cpustat.h \
  include/linux/neighbour.h \
  include/linux/circ_buf.h \
  include/linux/etherdevice.h \
    $(wildcard include/config/have/efficient/unaligned/access.h) \
  /usr/src/linux-headers-3.5.0-2-linaro-omap/arch/armv7l/include/asm/unaligned.h \
  include/linux/unaligned/le_byteshift.h \
  include/linux/unaligned/be_byteshift.h \
  include/linux/unaligned/generic.h \
  include/linux/wireless.h \
  include/net/iw_handler.h \
    $(wildcard include/config/wext/priv.h) \
  include/linux/if_arp.h \
  include/linux/rtnetlink.h \
  include/linux/if_addr.h \
  include/linux/interrupt.h \
    $(wildcard include/config/irq/forced/threading.h) \
    $(wildcard include/config/generic/irq/probe.h) \
  include/linux/irqreturn.h \
  include/linux/ip.h \
  include/linux/kthread.h \
  include/linux/usb.h \
    $(wildcard include/config/usb/mon.h) \
  include/linux/mod_devicetable.h \
  include/linux/usb/ch9.h \
    $(wildcard include/config/size.h) \
    $(wildcard include/config/att/one.h) \
    $(wildcard include/config/att/selfpower.h) \
    $(wildcard include/config/att/wakeup.h) \
    $(wildcard include/config/att/battery.h) \
  include/linux/pm_runtime.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_byteorder.h \
    $(wildcard include/config/little/endian.h) \
    $(wildcard include/config/big/endian.h) \
    $(wildcard include/config/platform/mstar389.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/byteorder/little_endian.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/drv_types.h \
    $(wildcard include/config/1t1r.h) \
    $(wildcard include/config/2t2r.h) \
    $(wildcard include/config/intel/proxim.h) \
    $(wildcard include/config/dualmac/concurrent.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/wlan_bssdef.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/drv_types_linux.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_ht.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/wifi.h \
    $(wildcard include/config/rtl8712fw.h) \
    $(wildcard include/config/error.h) \
    $(wildcard include/config/method/flash.h) \
    $(wildcard include/config/method/ethernet.h) \
    $(wildcard include/config/method/label.h) \
    $(wildcard include/config/method/display.h) \
    $(wildcard include/config/method/e/nfc.h) \
    $(wildcard include/config/method/i/nfc.h) \
    $(wildcard include/config/method/nfc.h) \
    $(wildcard include/config/method/pbc.h) \
    $(wildcard include/config/method/keypad.h) \
    $(wildcard include/config/method/vpbc.h) \
    $(wildcard include/config/method/ppbc.h) \
    $(wildcard include/config/method/vdisplay.h) \
    $(wildcard include/config/method/pdisplay.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_cmd.h \
    $(wildcard include/config/rtl8711fw.h) \
    $(wildcard include/config/event/thread/mode.h) \
    $(wildcard include/config/c2h/wk.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_rf.h \
    $(wildcard include/config/.h) \
    $(wildcard include/config/1t.h) \
    $(wildcard include/config/2t.h) \
    $(wildcard include/config/1r.h) \
    $(wildcard include/config/2r.h) \
    $(wildcard include/config/1t2r.h) \
    $(wildcard include/config/turbo.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_led.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/ieee80211.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_security.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_xmit.h \
    $(wildcard include/config/platform/arm/sunxi.h) \
    $(wildcard include/config/platform/arm/sun6i.h) \
    $(wildcard include/config/platform/mstar.h) \
    $(wildcard include/config/rtl8192d.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/xmit_osdep.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_recv.h \
    $(wildcard include/config/recv/thread/mode.h) \
    $(wildcard include/config/rx/indicate/queue.h) \
    $(wildcard include/config/bsd/rx/use/mbuf.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/hal_intf.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/hal_com.h \
    $(wildcard include/config/chip/ver/integration.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_qos.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_pwrctrl.h \
    $(wildcard include/config/lps/lclk.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_io.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/osdep_intf.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_eeprom.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/sta_info.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/wifi.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_mlme.h \
    $(wildcard include/config/intel/widi.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/mlme_osdep.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_debug.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_event.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_mlme_ext.h \
    $(wildcard include/config/dfs.h) \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_p2p.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_tdls.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_ap.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/rtw_br_ext.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/circ_buf.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/ip.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/usb_ops.h \
  /root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/include/usb_ops_linux.h \

/root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/rtw_xmit.o: $(deps_/root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/rtw_xmit.o)

$(deps_/root/realtek/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911/driver/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911/core/rtw_xmit.o):

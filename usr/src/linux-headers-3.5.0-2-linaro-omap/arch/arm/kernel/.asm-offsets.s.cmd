cmd_arch/arm/kernel/asm-offsets.s := arm-linux-gnueabihf-gcc -Wp,-MD,arch/arm/kernel/.asm-offsets.s.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabihf/4.6/include -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include -include /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kconfig.h  -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/. -I. -D__KERNEL__ -mlittle-endian   -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/mach-omap2/include   -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/plat-omap/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(asm_offsets)"  -D"KBUILD_MODNAME=KBUILD_STR(asm_offsets)" -fverbose-asm -S -o arch/arm/kernel/asm-offsets.s /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c

source_arch/arm/kernel/asm-offsets.s := /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c

deps_arch/arm/kernel/asm-offsets.s := \
    $(wildcard include/config/cc/stackprotector.h) \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/arm/thumbee.h) \
    $(wildcard include/config/iwmmxt.h) \
    $(wildcard include/config/crunch.h) \
    $(wildcard include/config/cache/l2x0.h) \
    $(wildcard include/config/cpu/has/asid.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/sched.h \
    $(wildcard include/config/sched/debug.h) \
    $(wildcard include/config/prove/rcu.h) \
    $(wildcard include/config/no/hz.h) \
    $(wildcard include/config/lockup/detector.h) \
    $(wildcard include/config/detect/hung/task.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/core/dump/default/elf/headers.h) \
    $(wildcard include/config/sched/autogroup.h) \
    $(wildcard include/config/virt/cpu/accounting.h) \
    $(wildcard include/config/bsd/process/acct.h) \
    $(wildcard include/config/taskstats.h) \
    $(wildcard include/config/audit.h) \
    $(wildcard include/config/cgroups.h) \
    $(wildcard include/config/inotify/user.h) \
    $(wildcard include/config/fanotify.h) \
    $(wildcard include/config/epoll.h) \
    $(wildcard include/config/posix/mqueue.h) \
    $(wildcard include/config/keys.h) \
    $(wildcard include/config/perf/events.h) \
    $(wildcard include/config/schedstats.h) \
    $(wildcard include/config/task/delay/acct.h) \
    $(wildcard include/config/fair/group/sched.h) \
    $(wildcard include/config/rt/group/sched.h) \
    $(wildcard include/config/preempt/notifiers.h) \
    $(wildcard include/config/blk/dev/io/trace.h) \
    $(wildcard include/config/preempt/rcu.h) \
    $(wildcard include/config/tree/preempt/rcu.h) \
    $(wildcard include/config/rcu/boost.h) \
    $(wildcard include/config/compat/brk.h) \
    $(wildcard include/config/sysvipc.h) \
    $(wildcard include/config/auditsyscall.h) \
    $(wildcard include/config/rt/mutexes.h) \
    $(wildcard include/config/debug/mutexes.h) \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/lockdep.h) \
    $(wildcard include/config/block.h) \
    $(wildcard include/config/task/xacct.h) \
    $(wildcard include/config/cpusets.h) \
    $(wildcard include/config/futex.h) \
    $(wildcard include/config/compat.h) \
    $(wildcard include/config/numa.h) \
    $(wildcard include/config/fault/injection.h) \
    $(wildcard include/config/latencytop.h) \
    $(wildcard include/config/function/graph/tracer.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/cgroup/mem/res/ctlr.h) \
    $(wildcard include/config/have/hw/breakpoint.h) \
    $(wildcard include/config/uprobes.h) \
    $(wildcard include/config/cpumask/offstack.h) \
    $(wildcard include/config/have/unstable/sched/clock.h) \
    $(wildcard include/config/irq/time/accounting.h) \
    $(wildcard include/config/hotplug/cpu.h) \
    $(wildcard include/config/proc/fs.h) \
    $(wildcard include/config/cfs/bandwidth.h) \
    $(wildcard include/config/stack/growsup.h) \
    $(wildcard include/config/debug/stack/usage.h) \
    $(wildcard include/config/preempt/count.h) \
    $(wildcard include/config/preempt.h) \
    $(wildcard include/config/cgroup/sched.h) \
    $(wildcard include/config/mm/owner.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/param.h \
    $(wildcard include/config/hz.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/capability.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/types.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/int-ll64.h \
  arch/arm/include/generated/asm/bitsperlong.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitsperlong.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/posix_types.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/stddef.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/compiler-gcc4.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/posix_types.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/posix_types.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/threads.h \
    $(wildcard include/config/nr/cpus.h) \
    $(wildcard include/config/base/small.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/ring/buffer.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/sysinfo.h \
  /usr/lib/gcc/arm-linux-gnueabihf/4.6/include/stdarg.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/linkage.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/linkage.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/bitops.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/bitops.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/irqflags.h \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/typecheck.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/irqflags.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/ptrace.h \
    $(wildcard include/config/cpu/endian/be8.h) \
    $(wildcard include/config/arm/thumb.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/hwcap.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/non-atomic.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/fls64.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/sched.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/hweight.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/arch_hweight.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/const_hweight.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/lock.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/le.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/byteorder.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/byteorder/little_endian.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/swab.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/swab.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/byteorder/generic.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bitops/ext2-atomic-setbit.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/log2.h \
    $(wildcard include/config/arch/has/ilog2/u32.h) \
    $(wildcard include/config/arch/has/ilog2/u64.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/printk.h \
    $(wildcard include/config/printk.h) \
    $(wildcard include/config/dynamic/debug.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/init.h \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/hotplug.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/dynamic_debug.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/div64.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/compiler.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/thumb2/kernel.h) \
    $(wildcard include/config/debug/bugverbose.h) \
    $(wildcard include/config/arm/lpae.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bug.h \
    $(wildcard include/config/generic/bug.h) \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/timex.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/time.h \
    $(wildcard include/config/arch/uses/gettimeoffset.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/cache.h \
    $(wildcard include/config/arch/has/cache/line/size.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/cache.h \
    $(wildcard include/config/arm/l1/cache/shift.h) \
    $(wildcard include/config/aeabi.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/seqlock.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/spinlock.h \
    $(wildcard include/config/debug/spinlock.h) \
    $(wildcard include/config/generic/lockbreak.h) \
    $(wildcard include/config/debug/lock/alloc.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/preempt.h \
    $(wildcard include/config/debug/preempt.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/thread_info.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/bug.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/thread_info.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/fpstate.h \
    $(wildcard include/config/vfpv3.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/domain.h \
    $(wildcard include/config/io/36.h) \
    $(wildcard include/config/cpu/use/domains.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/barrier.h \
    $(wildcard include/config/cpu/32v6k.h) \
    $(wildcard include/config/cpu/xsc3.h) \
    $(wildcard include/config/cpu/fa526.h) \
    $(wildcard include/config/arch/has/barriers.h) \
    $(wildcard include/config/arm/dma/mem/bufferable.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/outercache.h \
    $(wildcard include/config/outer/cache/sync.h) \
    $(wildcard include/config/outer/cache.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/list.h \
    $(wildcard include/config/debug/list.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/poison.h \
    $(wildcard include/config/illegal/pointer/value.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/const.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/stringify.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/bottom_half.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/spinlock_types.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/spinlock_types_up.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/lockdep.h \
    $(wildcard include/config/lock/stat.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rwlock_types.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/spinlock_up.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/processor.h \
    $(wildcard include/config/arm/errata/754327.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/hw_breakpoint.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rwlock.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/spinlock_api_up.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/atomic.h \
    $(wildcard include/config/arch/has/atomic/or.h) \
    $(wildcard include/config/generic/atomic64.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/atomic.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/cmpxchg.h \
    $(wildcard include/config/cpu/sa1100.h) \
    $(wildcard include/config/cpu/sa110.h) \
    $(wildcard include/config/cpu/v6.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/cmpxchg-local.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/atomic-long.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/math64.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/param.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/timex.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/mach-omap2/include/mach/timex.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/plat-omap/include/plat/timex.h \
    $(wildcard include/config/omap/32k/timer.h) \
    $(wildcard include/config/omap/32k/timer/hz.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/jiffies.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rbtree.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/cpumask.h \
    $(wildcard include/config/debug/per/cpu/maps.h) \
    $(wildcard include/config/disable/obsolete/cpumask/functions.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/bitmap.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/string.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/errno.h \
  arch/arm/include/generated/asm/errno.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/errno.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/errno-base.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/nodemask.h \
    $(wildcard include/config/highmem.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/numa.h \
    $(wildcard include/config/nodes/shift.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/mm_types.h \
    $(wildcard include/config/split/ptlock/cpus.h) \
    $(wildcard include/config/have/cmpxchg/double.h) \
    $(wildcard include/config/have/aligned/struct/page.h) \
    $(wildcard include/config/want/page/debug/flags.h) \
    $(wildcard include/config/kmemcheck.h) \
    $(wildcard include/config/aio.h) \
    $(wildcard include/config/mmu/notifier.h) \
    $(wildcard include/config/transparent/hugepage.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/auxvec.h \
  arch/arm/include/generated/asm/auxvec.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/auxvec.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/prio_tree.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rwsem.h \
    $(wildcard include/config/rwsem/generic/spinlock.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rwsem-spinlock.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/completion.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/wait.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/current.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/page-debug-flags.h \
    $(wildcard include/config/page/poisoning.h) \
    $(wildcard include/config/page/guard.h) \
    $(wildcard include/config/page/debug/something/else.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/uprobes.h \
    $(wildcard include/config/arch/supports/uprobes.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/page.h \
    $(wildcard include/config/cpu/copy/v4wt.h) \
    $(wildcard include/config/cpu/copy/v4wb.h) \
    $(wildcard include/config/cpu/copy/feroceon.h) \
    $(wildcard include/config/cpu/copy/fa.h) \
    $(wildcard include/config/cpu/xscale.h) \
    $(wildcard include/config/cpu/copy/v6.h) \
    $(wildcard include/config/have/arch/pfn/valid.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/glue.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/pgtable-2level-types.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/memory.h \
    $(wildcard include/config/need/mach/memory/h.h) \
    $(wildcard include/config/page/offset.h) \
    $(wildcard include/config/dram/size.h) \
    $(wildcard include/config/dram/base.h) \
    $(wildcard include/config/have/tcm.h) \
    $(wildcard include/config/arm/patch/phys/virt.h) \
    $(wildcard include/config/phys/offset.h) \
  arch/arm/include/generated/asm/sizes.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/sizes.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/memory_model.h \
    $(wildcard include/config/flatmem.h) \
    $(wildcard include/config/discontigmem.h) \
    $(wildcard include/config/sparsemem/vmemmap.h) \
    $(wildcard include/config/sparsemem.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/getorder.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/mmu.h \
  arch/arm/include/generated/asm/cputime.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/cputime.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/smp.h \
    $(wildcard include/config/use/generic/smp/helpers.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/sem.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/ipc.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/ipcbuf.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/ipcbuf.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/sembuf.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rcupdate.h \
    $(wildcard include/config/rcu/torture/test.h) \
    $(wildcard include/config/tree/rcu.h) \
    $(wildcard include/config/rcu/trace.h) \
    $(wildcard include/config/tiny/rcu.h) \
    $(wildcard include/config/tiny/preempt/rcu.h) \
    $(wildcard include/config/debug/objects/rcu/head.h) \
    $(wildcard include/config/preempt/rt.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/debugobjects.h \
    $(wildcard include/config/debug/objects.h) \
    $(wildcard include/config/debug/objects/free.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rcutiny.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/signal.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/signal.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/signal-defs.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/sigcontext.h \
  arch/arm/include/generated/asm/siginfo.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/siginfo.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/pid.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/percpu.h \
    $(wildcard include/config/need/per/cpu/embed/first/chunk.h) \
    $(wildcard include/config/need/per/cpu/page/first/chunk.h) \
    $(wildcard include/config/have/setup/per/cpu/area.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/pfn.h \
  arch/arm/include/generated/asm/percpu.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/percpu.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/percpu-defs.h \
    $(wildcard include/config/debug/force/weak/per/cpu.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/topology.h \
    $(wildcard include/config/sched/smt.h) \
    $(wildcard include/config/sched/mc.h) \
    $(wildcard include/config/sched/book.h) \
    $(wildcard include/config/use/percpu/numa/node/id.h) \
    $(wildcard include/config/have/memoryless/nodes.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/mmzone.h \
    $(wildcard include/config/force/max/zoneorder.h) \
    $(wildcard include/config/cma.h) \
    $(wildcard include/config/zone/dma.h) \
    $(wildcard include/config/zone/dma32.h) \
    $(wildcard include/config/memory/hotplug.h) \
    $(wildcard include/config/have/memblock/node/map.h) \
    $(wildcard include/config/flat/node/mem/map.h) \
    $(wildcard include/config/no/bootmem.h) \
    $(wildcard include/config/have/memory/present.h) \
    $(wildcard include/config/need/node/memmap/size.h) \
    $(wildcard include/config/have/memblock/node.h) \
    $(wildcard include/config/need/multiple/nodes.h) \
    $(wildcard include/config/have/arch/early/pfn/to/nid.h) \
    $(wildcard include/config/sparsemem/extreme.h) \
    $(wildcard include/config/nodes/span/other/nodes.h) \
    $(wildcard include/config/holes/in/zone.h) \
    $(wildcard include/config/arch/has/holes/memorymodel.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/pageblock-flags.h \
    $(wildcard include/config/hugetlb/page.h) \
    $(wildcard include/config/hugetlb/page/size/variable.h) \
  include/generated/bounds.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/memory_hotplug.h \
    $(wildcard include/config/memory/hotremove.h) \
    $(wildcard include/config/have/arch/nodedata/extension.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/notifier.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/mutex.h \
    $(wildcard include/config/have/arch/mutex/cpu/relax.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/mutex-debug.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/srcu.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/workqueue.h \
    $(wildcard include/config/debug/objects/work.h) \
    $(wildcard include/config/freezer.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/timer.h \
    $(wildcard include/config/timer/stats.h) \
    $(wildcard include/config/debug/objects/timers.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/ktime.h \
    $(wildcard include/config/ktime/scalar.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/topology.h \
    $(wildcard include/config/arm/cpu/topology.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/topology.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/proportions.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/percpu_counter.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/seccomp.h \
    $(wildcard include/config/seccomp.h) \
    $(wildcard include/config/seccomp/filter.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rculist.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/rtmutex.h \
    $(wildcard include/config/debug/rt/mutexes.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/plist.h \
    $(wildcard include/config/debug/pi/list.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/resource.h \
  arch/arm/include/generated/asm/resource.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/resource.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/hrtimer.h \
    $(wildcard include/config/high/res/timers.h) \
    $(wildcard include/config/timerfd.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/timerqueue.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/task_io_accounting.h \
    $(wildcard include/config/task/io/accounting.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/latencytop.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/cred.h \
    $(wildcard include/config/debug/credentials.h) \
    $(wildcard include/config/security.h) \
    $(wildcard include/config/user/ns.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/key.h \
    $(wildcard include/config/sysctl.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/sysctl.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/selinux.h \
    $(wildcard include/config/security/selinux.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/uidgid.h \
    $(wildcard include/config/uidgid/strict/type/checks.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/highuid.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/llist.h \
    $(wildcard include/config/arch/have/nmi/safe/cmpxchg.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/aio.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/aio_abi.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/uio.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/mm.h \
    $(wildcard include/config/ia64.h) \
    $(wildcard include/config/ksm.h) \
    $(wildcard include/config/debug/pagealloc.h) \
    $(wildcard include/config/hibernation.h) \
    $(wildcard include/config/hugetlbfs.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/gfp.h \
    $(wildcard include/config/pm/sleep.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/mmdebug.h \
    $(wildcard include/config/debug/vm.h) \
    $(wildcard include/config/debug/virtual.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/debug_locks.h \
    $(wildcard include/config/debug/locking/api/selftests.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/range.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/bit_spinlock.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/shrinker.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/pgtable.h \
    $(wildcard include/config/highpte.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/proc-fns.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/glue-proc.h \
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
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/pgtable-nopud.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/pgtable-hwdef.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/pgtable-2level-hwdef.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/pgtable-2level.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/pgtable.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/page-flags.h \
    $(wildcard include/config/pageflags/extended.h) \
    $(wildcard include/config/arch/uses/pg/uncached.h) \
    $(wildcard include/config/memory/failure.h) \
    $(wildcard include/config/swap.h) \
    $(wildcard include/config/s390.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/huge_mm.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/vmstat.h \
    $(wildcard include/config/vm/event/counters.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/vm_event_item.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/dma-mapping.h \
    $(wildcard include/config/has/dma.h) \
    $(wildcard include/config/arch/has/dma/set/coherent/mask.h) \
    $(wildcard include/config/have/dma/attrs.h) \
    $(wildcard include/config/need/dma/map/state.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/device.h \
    $(wildcard include/config/debug/devres.h) \
    $(wildcard include/config/devtmpfs.h) \
    $(wildcard include/config/sysfs/deprecated.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/ioport.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kobject.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/sysfs.h \
    $(wildcard include/config/sysfs.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kobject_ns.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kref.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/klist.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/pm.h \
    $(wildcard include/config/pm.h) \
    $(wildcard include/config/pm/runtime.h) \
    $(wildcard include/config/pm/clk.h) \
    $(wildcard include/config/pm/generic/domains.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/ratelimit.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/device.h \
    $(wildcard include/config/dmabounce.h) \
    $(wildcard include/config/iommu/api.h) \
    $(wildcard include/config/arm/dma/use/iommu.h) \
    $(wildcard include/config/arch/omap.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/pm_wakeup.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/err.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/dma-attrs.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/dma-direction.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/scatterlist.h \
    $(wildcard include/config/debug/sg.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/scatterlist.h \
    $(wildcard include/config/arm/has/sg/chain.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/scatterlist.h \
    $(wildcard include/config/need/sg/dma/length.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/io.h \
    $(wildcard include/config/need/mach/io/h.h) \
    $(wildcard include/config/pcmcia/soc/common.h) \
    $(wildcard include/config/pci.h) \
    $(wildcard include/config/isa.h) \
    $(wildcard include/config/pccard.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/pci_iomap.h \
    $(wildcard include/config/no/generic/pci/ioport/map.h) \
    $(wildcard include/config/generic/pci/iomap.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/dma-mapping.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/dma-debug.h \
    $(wildcard include/config/dma/api/debug.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/dma-coherent.h \
    $(wildcard include/config/have/generic/dma/coherent.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/dma-mapping-common.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kmemcheck.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/cacheflush.h \
    $(wildcard include/config/smp/on/up.h) \
    $(wildcard include/config/arm/errata/411920.h) \
    $(wildcard include/config/cpu/cache/vipt.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/glue-cache.h \
    $(wildcard include/config/cpu/cache/v3.h) \
    $(wildcard include/config/cpu/cache/v4.h) \
    $(wildcard include/config/cpu/cache/v4wb.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/shmparam.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/cachetype.h \
    $(wildcard include/config/cpu/cache/vivt.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/glue-df.h \
    $(wildcard include/config/cpu/arm710.h) \
    $(wildcard include/config/cpu/abrt/lv4t.h) \
    $(wildcard include/config/cpu/abrt/ev4.h) \
    $(wildcard include/config/cpu/abrt/ev4t.h) \
    $(wildcard include/config/cpu/abrt/ev5tj.h) \
    $(wildcard include/config/cpu/abrt/ev5t.h) \
    $(wildcard include/config/cpu/abrt/ev6.h) \
    $(wildcard include/config/cpu/abrt/ev7.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/glue-pf.h \
    $(wildcard include/config/cpu/pabrt/legacy.h) \
    $(wildcard include/config/cpu/pabrt/v6.h) \
    $(wildcard include/config/cpu/pabrt/v7.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/mach/arch.h \
    $(wildcard include/config/multi/irq/handler.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/procinfo.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/hardware/cache-l2x0.h \
    $(wildcard include/config/of.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kbuild.h \

arch/arm/kernel/asm-offsets.s: $(deps_arch/arm/kernel/asm-offsets.s)

$(deps_arch/arm/kernel/asm-offsets.s):

cmd_kernel/bounds.s := arm-linux-gnueabihf-gcc -Wp,-MD,kernel/.bounds.s.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabihf/4.6/include -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include -include /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kconfig.h  -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/. -I. -D__KERNEL__ -mlittle-endian   -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/mach-omap2/include   -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/plat-omap/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(bounds)"  -D"KBUILD_MODNAME=KBUILD_STR(bounds)" -fverbose-asm -S -o kernel/bounds.s /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/kernel/bounds.c

source_kernel/bounds.s := /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/kernel/bounds.c

deps_kernel/bounds.s := \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/page-flags.h \
    $(wildcard include/config/pageflags/extended.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/arch/uses/pg/uncached.h) \
    $(wildcard include/config/memory/failure.h) \
    $(wildcard include/config/transparent/hugepage.h) \
    $(wildcard include/config/highmem.h) \
    $(wildcard include/config/swap.h) \
    $(wildcard include/config/s390.h) \
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
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/bug.h \
    $(wildcard include/config/generic/bug.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/thumb2/kernel.h) \
    $(wildcard include/config/debug/bugverbose.h) \
    $(wildcard include/config/arm/lpae.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/linkage.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/linkage.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/asm-generic/bug.h \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
    $(wildcard include/config/smp.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/ring/buffer.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/numa.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/sysinfo.h \
  /usr/lib/gcc/arm-linux-gnueabihf/4.6/include/stdarg.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/bitops.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include/asm/bitops.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/irqflags.h \
    $(wildcard include/config/trace/irqflags.h) \
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
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/mmzone.h \
    $(wildcard include/config/force/max/zoneorder.h) \
    $(wildcard include/config/cma.h) \
    $(wildcard include/config/cgroup/mem/res/ctlr.h) \
    $(wildcard include/config/zone/dma.h) \
    $(wildcard include/config/zone/dma32.h) \
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
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kbuild.h \
  /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/page_cgroup.h \
    $(wildcard include/config/cgroup/mem/res/ctlr/swap.h) \

kernel/bounds.s: $(deps_kernel/bounds.s)

$(deps_kernel/bounds.s):

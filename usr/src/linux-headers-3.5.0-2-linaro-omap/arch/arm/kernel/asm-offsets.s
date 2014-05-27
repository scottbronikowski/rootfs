	.arch armv7-a
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 4
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"asm-offsets.c"
@ GNU C (Ubuntu/Linaro 4.6.3-1ubuntu5) version 4.6.3 (arm-linux-gnueabihf)
@	compiled by GNU C version 4.6.3, GMP version 5.0.2, MPFR version 3.1.0-p3, MPC version 0.9
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -nostdinc
@ -I /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include
@ -I arch/arm/include/generated -I include
@ -I /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include
@ -I /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/. -I .
@ -I /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/mach-omap2/include
@ -I /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/plat-omap/include
@ -imultilib sf -imultiarch arm-linux-gnueabi -D __KERNEL__
@ -D __LINUX_ARM_ARCH__=7 -U arm -D KBUILD_STR(s)=#s
@ -D KBUILD_BASENAME=KBUILD_STR(asm_offsets)
@ -D KBUILD_MODNAME=KBUILD_STR(asm_offsets)
@ -isystem /usr/lib/gcc/arm-linux-gnueabihf/4.6/include
@ -include /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kconfig.h
@ -MD arch/arm/kernel/.asm-offsets.s.d
@ /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c
@ -mlittle-endian -marm -mabi=aapcs-linux -mno-thumb-interwork
@ -march=armv7-a -msoft-float -mfpu=vfpv3-d16
@ -auxbase-strip arch/arm/kernel/asm-offsets.s -Os -Wall -Wundef
@ -Wstrict-prototypes -Wno-trigraphs -Werror=implicit-function-declaration
@ -Wno-format-security -Wframe-larger-than=1024
@ -Wno-unused-but-set-variable -Wdeclaration-after-statement
@ -Wno-pointer-sign -fno-strict-aliasing -fno-common
@ -fno-delete-null-pointer-checks -fno-dwarf2-cfi-asm -funwind-tables
@ -fno-stack-protector -fomit-frame-pointer
@ -fno-inline-functions-called-once -fno-strict-overflow -fconserve-stack
@ -fverbose-asm
@ options enabled:  -fauto-inc-dec -fbranch-count-reg -fcaller-saves
@ -fcombine-stack-adjustments -fcompare-elim -fcprop-registers
@ -fcrossjumping -fcse-follow-jumps -fdefer-pop -fdevirtualize
@ -fearly-inlining -feliminate-unused-debug-types -fexpensive-optimizations
@ -fforward-propagate -ffunction-cse -fgcse -fgcse-lm
@ -fguess-branch-probability -fident -fif-conversion -fif-conversion2
@ -findirect-inlining -finline -finline-functions -finline-small-functions
@ -fipa-cp -fipa-profile -fipa-pure-const -fipa-reference -fipa-sra
@ -fira-share-save-slots -fira-share-spill-slots -fivopts
@ -fkeep-static-consts -fleading-underscore -fmath-errno -fmerge-constants
@ -fmerge-debug-strings -fmove-loop-invariants -fomit-frame-pointer
@ -foptimize-register-move -foptimize-sibling-calls -fpartial-inlining
@ -fpeephole -fpeephole2 -fprefetch-loop-arrays -freg-struct-return
@ -fregmove -freorder-blocks -freorder-functions -frerun-cse-after-loop
@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
@ -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
@ -fsched-stalled-insns-dep -fschedule-insns2 -fsection-anchors
@ -fshow-column -fsigned-zeros -fsplit-ivs-in-unroller -fsplit-wide-types
@ -fstrict-volatile-bitfields -fthread-jumps -ftoplevel-reorder
@ -ftrapping-math -ftree-bit-ccp -ftree-builtin-call-dce -ftree-ccp
@ -ftree-ch -ftree-copy-prop -ftree-copyrename -ftree-cselim -ftree-dce
@ -ftree-dominator-opts -ftree-dse -ftree-forwprop -ftree-fre
@ -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
@ -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop -ftree-pre
@ -ftree-pta -ftree-reassoc -ftree-scev-cprop -ftree-sink
@ -ftree-slp-vectorize -ftree-sra -ftree-switch-conversion -ftree-ter
@ -ftree-vect-loop-version -ftree-vrp -funit-at-a-time -funwind-tables
@ -fverbose-asm -fzero-initialized-in-bss -mglibc -mlittle-endian
@ -msched-prolog -munaligned-access -mvectorize-with-neon-quad

@ Compiler executable checksum: a6307c82fe8e2ed98c5aea4a84de9cda

	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	.fnstart
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
#APP
@ 46 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TSK_ACTIVE_MM #452 offsetof(struct task_struct, active_mm)	@
@ 0 "" 2
@ 50 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 51 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_FLAGS #0 offsetof(struct thread_info, flags)	@
@ 0 "" 2
@ 52 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_PREEMPT #4 offsetof(struct thread_info, preempt_count)	@
@ 0 "" 2
@ 53 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_ADDR_LIMIT #8 offsetof(struct thread_info, addr_limit)	@
@ 0 "" 2
@ 54 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_TASK #12 offsetof(struct thread_info, task)	@
@ 0 "" 2
@ 55 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_EXEC_DOMAIN #16 offsetof(struct thread_info, exec_domain)	@
@ 0 "" 2
@ 56 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_CPU #20 offsetof(struct thread_info, cpu)	@
@ 0 "" 2
@ 57 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_CPU_DOMAIN #24 offsetof(struct thread_info, cpu_domain)	@
@ 0 "" 2
@ 58 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_CPU_SAVE #28 offsetof(struct thread_info, cpu_context)	@
@ 0 "" 2
@ 59 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_USED_CP #80 offsetof(struct thread_info, used_cp)	@
@ 0 "" 2
@ 60 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_TP_VALUE #96 offsetof(struct thread_info, tp_value)	@
@ 0 "" 2
@ 61 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_FPSTATE #288 offsetof(struct thread_info, fpstate)	@
@ 0 "" 2
@ 62 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_VFPSTATE #432 offsetof(struct thread_info, vfpstate)	@
@ 0 "" 2
@ 67 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->TI_THUMBEE_STATE #704 offsetof(struct thread_info, thumbee_state)	@
@ 0 "" 2
@ 75 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 76 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R0 #0 offsetof(struct pt_regs, ARM_r0)	@
@ 0 "" 2
@ 77 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R1 #4 offsetof(struct pt_regs, ARM_r1)	@
@ 0 "" 2
@ 78 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R2 #8 offsetof(struct pt_regs, ARM_r2)	@
@ 0 "" 2
@ 79 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R3 #12 offsetof(struct pt_regs, ARM_r3)	@
@ 0 "" 2
@ 80 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R4 #16 offsetof(struct pt_regs, ARM_r4)	@
@ 0 "" 2
@ 81 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R5 #20 offsetof(struct pt_regs, ARM_r5)	@
@ 0 "" 2
@ 82 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R6 #24 offsetof(struct pt_regs, ARM_r6)	@
@ 0 "" 2
@ 83 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R7 #28 offsetof(struct pt_regs, ARM_r7)	@
@ 0 "" 2
@ 84 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R8 #32 offsetof(struct pt_regs, ARM_r8)	@
@ 0 "" 2
@ 85 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R9 #36 offsetof(struct pt_regs, ARM_r9)	@
@ 0 "" 2
@ 86 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_R10 #40 offsetof(struct pt_regs, ARM_r10)	@
@ 0 "" 2
@ 87 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_FP #44 offsetof(struct pt_regs, ARM_fp)	@
@ 0 "" 2
@ 88 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_IP #48 offsetof(struct pt_regs, ARM_ip)	@
@ 0 "" 2
@ 89 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_SP #52 offsetof(struct pt_regs, ARM_sp)	@
@ 0 "" 2
@ 90 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_LR #56 offsetof(struct pt_regs, ARM_lr)	@
@ 0 "" 2
@ 91 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_PC #60 offsetof(struct pt_regs, ARM_pc)	@
@ 0 "" 2
@ 92 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_PSR #64 offsetof(struct pt_regs, ARM_cpsr)	@
@ 0 "" 2
@ 93 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_OLD_R0 #68 offsetof(struct pt_regs, ARM_ORIG_r0)	@
@ 0 "" 2
@ 94 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->S_FRAME_SIZE #72 sizeof(struct pt_regs)	@
@ 0 "" 2
@ 95 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 108 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->MM_CONTEXT_ID #340 offsetof(struct mm_struct, context.id)	@
@ 0 "" 2
@ 109 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 111 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->VMA_VM_MM #0 offsetof(struct vm_area_struct, vm_mm)	@
@ 0 "" 2
@ 112 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->VMA_VM_FLAGS #24 offsetof(struct vm_area_struct, vm_flags)	@
@ 0 "" 2
@ 113 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 114 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->VM_EXEC #4 VM_EXEC	@
@ 0 "" 2
@ 115 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 116 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->PAGE_SZ #4096 PAGE_SIZE	@
@ 0 "" 2
@ 117 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 118 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->SYS_ERROR0 #10420224 0x9f0000	@
@ 0 "" 2
@ 119 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 120 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->SIZEOF_MACHINE_DESC #72 sizeof(struct machine_desc)	@
@ 0 "" 2
@ 121 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->MACHINFO_TYPE #0 offsetof(struct machine_desc, nr)	@
@ 0 "" 2
@ 122 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->MACHINFO_NAME #4 offsetof(struct machine_desc, name)	@
@ 0 "" 2
@ 123 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 124 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->PROC_INFO_SZ #52 sizeof(struct proc_info_list)	@
@ 0 "" 2
@ 125 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->PROCINFO_INITFUNC #16 offsetof(struct proc_info_list, __cpu_flush)	@
@ 0 "" 2
@ 126 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->PROCINFO_MM_MMUFLAGS #8 offsetof(struct proc_info_list, __cpu_mm_mmu_flags)	@
@ 0 "" 2
@ 127 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->PROCINFO_IO_MMUFLAGS #12 offsetof(struct proc_info_list, __cpu_io_mmu_flags)	@
@ 0 "" 2
@ 128 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 141 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->CACHE_FLUSH_KERN_ALL #4 offsetof(struct cpu_cache_fns, flush_kern_all)	@
@ 0 "" 2
@ 143 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->
@ 0 "" 2
@ 144 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->DMA_BIDIRECTIONAL #0 DMA_BIDIRECTIONAL	@
@ 0 "" 2
@ 145 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->DMA_TO_DEVICE #1 DMA_TO_DEVICE	@
@ 0 "" 2
@ 146 "/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/kernel/asm-offsets.c" 1
	
->DMA_FROM_DEVICE #2 DMA_FROM_DEVICE	@
@ 0 "" 2
	mov	r0, #0	@,
	bx	lr	@
	.fnend
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",%progbits

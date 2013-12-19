cmd_scripts/mod/empty.o := arm-linux-gnueabihf-gcc -Wp,-MD,scripts/mod/.empty.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabihf/4.6/include -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include -include /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/include/linux/kconfig.h  -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/scripts/mod -Iscripts/mod -D__KERNEL__ -mlittle-endian   -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/mach-omap2/include   -I/home/adam/Code/linaro-12.10/kernel_build/test_build/linux/arch/arm/plat-omap/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(empty)"  -D"KBUILD_MODNAME=KBUILD_STR(empty)" -c -o scripts/mod/.tmp_empty.o /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/scripts/mod/empty.c

source_scripts/mod/empty.o := /home/adam/Code/linaro-12.10/kernel_build/test_build/linux/scripts/mod/empty.c

deps_scripts/mod/empty.o := \

scripts/mod/empty.o: $(deps_scripts/mod/empty.o)

$(deps_scripts/mod/empty.o):

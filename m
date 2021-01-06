From: kernel test robot <lkp@intel.com>
Date: Wed, 6 Jan 2021 15:51:53 +0800
Subject: [PATCH 5/6] soc: aspeed: Add eSPI driver
In-Reply-To: <20210106055939.19386-6-chiawei_wang@aspeedtech.com>
References: <20210106055939.19386-6-chiawei_wang@aspeedtech.com>
Message-ID: <202101061550.NGVM0Yzf-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Wang",

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.11-rc2 next-20210104]
[cannot apply to joel-aspeed/for-next robh/for-next tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chia-Wei-Wang/arm-aspeed-Add-eSPI-support/20210106-140337
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
config: ia64-randconfig-m031-20210106 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4ee780938ea027aa22e3dbd0b9041477da033ee0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chia-Wei-Wang/arm-aspeed-Add-eSPI-support/20210106-140337
        git checkout 4ee780938ea027aa22e3dbd0b9041477da033ee0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/aspeed-espi.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
--
>> error: include/uapi/linux/aspeed-espi.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/aspeed-espi.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1294: headers] Error 2
   make[1]: Target 'headers_install' not remade because of errors.
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'headers_install' not remade because of errors.
--
>> error: include/uapi/linux/aspeed-espi.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/aspeed-espi.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1294: headers] Error 2
   In file included from include/linux/kernel.h:16,
                    from include/asm-generic/bug.h:20,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/printk.h:219:5: error: static declaration of 'printk' follows non-static declaration
     219 | int printk(const char *s, ...)
         |     ^~~~~~
   In file included from arch/ia64/include/uapi/asm/intrinsics.h:22,
                    from arch/ia64/include/asm/intrinsics.h:11,
                    from arch/ia64/include/asm/bitops.h:19,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:20,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/ia64/include/uapi/asm/cmpxchg.h:142:14: note: previous declaration of 'printk' was here
     142 |   extern int printk(const char *fmt, ...);  \
         |              ^~~~~~
   arch/ia64/include/asm/bitops.h:309:3: note: in expansion of macro 'CMPXCHG_BUGCHECK'
     309 |   CMPXCHG_BUGCHECK(m);
         |   ^~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1206: prepare0] Error 2
   make[1]: Target 'modules_prepare' not remade because of errors.
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.
--
   cc1: warning: ./arch/ia64/include/generated: No such file or directory [-Wmissing-include-dirs]
   cc1: warning: ./arch/ia64/include/generated/uapi: No such file or directory [-Wmissing-include-dirs]
   cc1: warning: ./include/generated/uapi: No such file or directory [-Wmissing-include-dirs]
   arch/ia64/kernel/nr-irqs.c:15:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      15 | void foo(void)
         |      ^~~
>> error: include/uapi/linux/aspeed-espi.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/aspeed-espi.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1294: headers] Error 2
   In file included from include/linux/kernel.h:16,
                    from include/asm-generic/bug.h:20,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/printk.h:219:5: error: static declaration of 'printk' follows non-static declaration
     219 | int printk(const char *s, ...)
         |     ^~~~~~
   In file included from arch/ia64/include/uapi/asm/intrinsics.h:22,
                    from arch/ia64/include/asm/intrinsics.h:11,
                    from arch/ia64/include/asm/bitops.h:19,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:20,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/ia64/include/uapi/asm/cmpxchg.h:142:14: note: previous declaration of 'printk' was here
     142 |   extern int printk(const char *fmt, ...);  \
         |              ^~~~~~
   arch/ia64/include/asm/bitops.h:309:3: note: in expansion of macro 'CMPXCHG_BUGCHECK'
     309 |   CMPXCHG_BUGCHECK(m);
         |   ^~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1206: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS
   Selected by
   - FAULT_INJECTION_STACKTRACE_FILTER && FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT && !X86_64 && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33093 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210106/3ef56c17/attachment-0001.gz>

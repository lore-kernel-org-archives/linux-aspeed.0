From: kernel test robot <lkp@intel.com>
Date: Tue, 30 Mar 2021 17:50:48 +0800
Subject: [PATCH v1 2/3] drivers: char: ipmi: Add Aspeed SSIF BMC driver
In-Reply-To: <20210329121759.5644-3-quan@os.amperecomputing.com>
References: <20210329121759.5644-3-quan@os.amperecomputing.com>
Message-ID: <202103301757.XbGw9AcP-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Quan,

I love your patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on wsa/i2c/for-next ipmi/for-next v5.12-rc5 next-20210329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Quan-Nguyen/Add-Aspeed-SSIF-BMC-driver/20210329-202143
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git d72260cc7879c72c186900e7c153007a6137ed8e
config: arc-randconfig-r024-20210330 (attached as .config)
compiler: arceb-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c640bd37ce66eb1364922be61ac3a46108952438
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Quan-Nguyen/Add-Aspeed-SSIF-BMC-driver/20210329-202143
        git checkout c640bd37ce66eb1364922be61ac3a46108952438
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arceb-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
   stackdepot.c:(.text+0x3a): undefined reference to `__irqentry_text_start'
   arceb-elf-ld: stackdepot.c:(.text+0x3a): undefined reference to `__irqentry_text_start'
   arceb-elf-ld: stackdepot.c:(.text+0x5a): undefined reference to `__irqentry_text_end'
   arceb-elf-ld: stackdepot.c:(.text+0x5a): undefined reference to `__irqentry_text_end'
   arceb-elf-ld: stackdepot.c:(.text+0x62): undefined reference to `__softirqentry_text_start'
   arceb-elf-ld: stackdepot.c:(.text+0x62): undefined reference to `__softirqentry_text_start'
   arceb-elf-ld: stackdepot.c:(.text+0x6a): undefined reference to `__softirqentry_text_end'
   arceb-elf-ld: stackdepot.c:(.text+0x6a): undefined reference to `__softirqentry_text_end'
   arceb-elf-ld: drivers/char/ipmi/ssif_bmc.o: in function `ssif_bmc_alloc':
>> ssif_bmc.c:(.text+0x51e): undefined reference to `i2c_slave_register'
>> arceb-elf-ld: ssif_bmc.c:(.text+0x51e): undefined reference to `i2c_slave_register'
   arceb-elf-ld: drivers/char/ipmi/ssif_bmc.o: in function `ssif_bmc_cb':
>> ssif_bmc.c:(.text+0x6b8): undefined reference to `i2c_smbus_pec'
>> arceb-elf-ld: ssif_bmc.c:(.text+0x6b8): undefined reference to `i2c_smbus_pec'
   arceb-elf-ld: ssif_bmc.c:(.text+0x6c2): undefined reference to `i2c_smbus_pec'
   arceb-elf-ld: ssif_bmc.c:(.text+0x6c2): undefined reference to `i2c_smbus_pec'
   arceb-elf-ld: ssif_bmc.c:(.text+0x6d6): undefined reference to `i2c_smbus_pec'
   arceb-elf-ld: drivers/char/ipmi/ssif_bmc.o:ssif_bmc.c:(.text+0x6d6): more undefined references to `i2c_smbus_pec' follow
--
>> drivers/char/ipmi/ssif_bmc_aspeed.c:41:6: warning: no previous prototype for 'aspeed_i2c_enable_interrupt' [-Wmissing-prototypes]
      41 | void aspeed_i2c_enable_interrupt(struct aspeed_i2c_bus *bus, unsigned long mask)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/char/ipmi/ssif_bmc_aspeed.c:49:6: warning: no previous prototype for 'aspeed_i2c_disable_interrupt' [-Wmissing-prototypes]
      49 | void aspeed_i2c_disable_interrupt(struct aspeed_i2c_bus *bus, unsigned long mask)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/char/ipmi/ssif_bmc_aspeed.c:57:6: warning: no previous prototype for 'aspeed_set_ssif_bmc_status' [-Wmissing-prototypes]
      57 | void aspeed_set_ssif_bmc_status(struct ssif_bmc_ctx *ssif_bmc, unsigned int status)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31109 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210330/c7e876c6/attachment-0001.gz>

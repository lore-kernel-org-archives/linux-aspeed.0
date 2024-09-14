From: kernel test robot <lkp@intel.com>
Date: Sat, 14 Sep 2024 23:33:50 +0800
Subject: [PATCH v3 5/6] gpio: aspeed: Change the macro to support
 deferred probe
In-Reply-To: <20240913074325.239390-6-billy_tsai@aspeedtech.com>
References: <20240913074325.239390-6-billy_tsai@aspeedtech.com>
Message-ID: <202409142334.UEVN1oRP-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-gpio-aspeed-ast2400-gpio-Support-ast2700/20240913-154911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240913074325.239390-6-billy_tsai%40aspeedtech.com
patch subject: [PATCH v3 5/6] gpio: aspeed: Change the macro to support deferred probe
config: arm-randconfig-003-20240914 (https://download.01.org/0day-ci/archive/20240914/202409142334.UEVN1oRP-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409142334.UEVN1oRP-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409142334.UEVN1oRP-lkp at intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
>> WARNING: modpost: drivers/gpio/gpio-aspeed: section mismatch in reference: aspeed_gpio_driver+0x0 (section: .data) -> aspeed_gpio_probe (section: .init.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

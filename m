From: kernel test robot <lkp@intel.com>
Date: Thu, 23 May 2024 20:48:59 +0800
Subject: [PATCH v6 17/20] ARM: dts: aspeed: Add IBM Huygens BMC system
In-Reply-To: <20240522192524.3286237-18-eajames@linux.ibm.com>
References: <20240522192524.3286237-18-eajames@linux.ibm.com>
Message-ID: <202405232008.olE9azVd-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

kernel test robot noticed the following build errors:

[auto build test ERROR on andi-shyti/i2c/i2c-host]
[also build test ERROR on linus/master v6.9 next-20240523]
[cannot apply to robh/for-next broonie-spi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/spi-dt-bindings-Document-the-IBM-FSI-attached-SPI-controller/20240523-033334
base:   git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20240522192524.3286237-18-eajames%40linux.ibm.com
patch subject: [PATCH v6 17/20] ARM: dts: aspeed: Add IBM Huygens BMC system
config: arm-randconfig-001-20240523 (https://download.01.org/0day-ci/archive/20240523/202405232008.olE9azVd-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405232008.olE9azVd-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405232008.olE9azVd-lkp at intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-huygens.dts:13.2-37 Properties must precede subnodes
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

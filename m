From: kernel test robot <lkp@intel.com>
Date: Sat, 23 Sep 2023 03:08:37 +0800
Subject: [PATCH v1 1/1] ARM: dts: aspeed: yosemite4: Add i2c-mux/eeprom
 devices
In-Reply-To: <20230922064127.283625-2-Delphine_CC_Chiu@wiwynn.com>
References: <20230922064127.283625-2-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <202309230217.cHc3qLuk-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Delphine,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Delphine-CC-Chiu/ARM-dts-aspeed-yosemite4-Add-i2c-mux-eeprom-devices/20230922-144218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20230922064127.283625-2-Delphine_CC_Chiu%40wiwynn.com
patch subject: [PATCH v1 1/1] ARM: dts: aspeed: yosemite4: Add i2c-mux/eeprom devices
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230923/202309230217.cHc3qLuk-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309230217.cHc3qLuk-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309230217.cHc3qLuk-lkp at intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1229.1-7 Label or path jtag1 not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

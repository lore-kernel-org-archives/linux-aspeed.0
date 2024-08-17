From: kernel test robot <lkp@intel.com>
Date: Sat, 17 Aug 2024 13:40:49 +0800
Subject: [PATCH v12 28/28] ARM: dts: aspeed: yosemite4: fix GPIO linename
 typo
In-Reply-To: <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <202408171324.4kdqlh1v-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Delphine,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Delphine-CC-Chiu/ARM-dts-aspeed-yosemite4-Revise-i2c-mux-devices/20240816-173326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240816092417.3651434-29-Delphine_CC_Chiu%40wiwynn.com
patch subject: [PATCH v12 28/28] ARM: dts: aspeed: yosemite4: fix GPIO linename typo
config: arm-randconfig-001-20240817 (https://download.01.org/0day-ci/archive/20240817/202408171324.4kdqlh1v-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408171324.4kdqlh1v-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408171324.4kdqlh1v-lkp at intel.com/

All errors (new ones prefixed by >>):

   Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1721.1-6 Label or path i3c0 not found
   Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1764.1-6 Label or path i3c1 not found
>> Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1833.1-7 Label or path jtag1 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

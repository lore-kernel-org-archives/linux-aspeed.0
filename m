From: kernel test robot <lkp@intel.com>
Date: Wed, 6 Sep 2023 09:57:46 +0800
Subject: [PATCH v8 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
In-Reply-To: <20230905062223.774871-2-peteryin.openbmc@gmail.com>
References: <20230905062223.774871-2-peteryin.openbmc@gmail.com>
Message-ID: <202309060936.2lEsdiub-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230905]
[also build test ERROR on linus/master v6.5]
[cannot apply to robh/for-next v6.5 v6.5-rc7 v6.5-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Yin/ARM-dts-aspeed-Minerva-Add-Facebook-Minerva-AST2600-BMC/20230906-005659
base:   next-20230905
patch link:    https://lore.kernel.org/r/20230905062223.774871-2-peteryin.openbmc%40gmail.com
patch subject: [PATCH v8 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva (AST2600) BMC
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230906/202309060936.2lEsdiub-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060936.2lEsdiub-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060936.2lEsdiub-lkp at intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts:261.1-7 Label or path jtag1 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

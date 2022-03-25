From: kernel test robot <lkp@intel.com>
Date: Fri, 25 Mar 2022 17:02:22 +0800
Subject: [PATCH v2] ARM: dts: aspeed: ast2600-evb: Support KVM
In-Reply-To: <HK0PR06MB2307383743B9AE1D714A899BE61A9@HK0PR06MB2307.apcprd06.prod.outlook.com>
References: <HK0PR06MB2307383743B9AE1D714A899BE61A9@HK0PR06MB2307.apcprd06.prod.outlook.com>
Message-ID: <202203251620.taj6u6mo-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Howard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.17]
[cannot apply to joel-aspeed/for-next next-20220324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Howard-Chiu/ARM-dts-aspeed-ast2600-evb-Support-KVM/20220325-103839
base:    f443e374ae131c168a065ea1748feac6b2e76613
config: arm-aspeed_g4_defconfig (https://download.01.org/0day-ci/archive/20220325/202203251620.taj6u6mo-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/9037b86779cd7616b378b3bafd1f32b4c862f0bd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Howard-Chiu/ARM-dts-aspeed-ast2600-evb-Support-KVM/20220325-103839
        git checkout 9037b86779cd7616b378b3bafd1f32b4c862f0bd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-ast2600-evb.dts:322.1-7 Label or path video not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

From: kernel test robot <lkp@intel.com>
Date: Wed, 8 Dec 2021 04:05:15 +0800
Subject: [PATCH v4 6/6] arm:boot:dts:aspeed-g6 Add more gfx reset control
In-Reply-To: <20211207102749.18118-8-tommy_huang@aspeedtech.com>
References: <20211207102749.18118-8-tommy_huang@aspeedtech.com>
Message-ID: <202112080327.zlIz9vRq-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tommy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.16-rc4]
[also build test ERROR on next-20211207]
[cannot apply to joel-aspeed/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tommy-Haung/Add-Aspeed-AST2600-soc-display-support/20211207-183100
base:    0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: arm-defconfig (https://download.01.org/0day-ci/archive/20211208/202112080327.zlIz9vRq-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1f021d3aa80957f6bd0434bf4b5d66898b8d2e9c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tommy-Haung/Add-Aspeed-AST2600-soc-display-support/20211207-183100
        git checkout 1f021d3aa80957f6bd0434bf4b5d66898b8d2e9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-g6.dtsi:359.23-24 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

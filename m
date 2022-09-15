From: kernel test robot <lkp@intel.com>
Date: Thu, 15 Sep 2022 16:30:59 +0800
Subject: [PATCH v3] ARM: dts: aspeed: yosemit V2: Enable OCP debug card
In-Reply-To: <20220914095207.GA24690@hcl-ThinkPad-T495>
References: <20220914095207.GA24690@hcl-ThinkPad-T495>
Message-ID: <202209151642.BiM4LmOZ-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Karthikeyan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm/for-next]
[also build test ERROR on arm64/for-next/core clk/clk-next rockchip/for-next shawnguo/for-next soc/for-next xilinx-xlnx/master linus/master v6.0-rc5 next-20220914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Karthikeyan-Pasupathi/ARM-dts-aspeed-yosemit-V2-Enable-OCP-debug-card/20220914-175427
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220915/202209151642.BiM4LmOZ-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f4ff107abc0f057d0a55ced8a8db831db6f7d59e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Karthikeyan-Pasupathi/ARM-dts-aspeed-yosemit-V2-Enable-OCP-debug-card/20220914-175427
        git checkout f4ff107abc0f057d0a55ced8a8db831db6f7d59e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:222.9-10 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

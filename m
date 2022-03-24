From: kernel test robot <lkp@intel.com>
Date: Thu, 24 Mar 2022 16:56:08 +0800
Subject: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
 driver
In-Reply-To: <20220323004009.943298-3-ryan_chen@aspeedtech.com>
References: <20220323004009.943298-3-ryan_chen@aspeedtech.com>
Message-ID: <202203241617.RVjnwFdn-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi ryan_chen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on robh/for-next pza/reset/next v5.17 next-20220323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/ryan_chen/Add-ASPEED-AST2600-I2C-new-controller-driver/20220323-084205
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220324/202203241617.RVjnwFdn-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/4fa1d6c517dfca057852514880a8e52e5da51572
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review ryan_chen/Add-ASPEED-AST2600-I2C-new-controller-driver/20220323-084205
        git checkout 4fa1d6c517dfca057852514880a8e52e5da51572
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/i2c/busses/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-new-aspeed.c:1407:19: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'void *' [-Wvoid-pointer-to-int-cast]
           u8 i2c_count = (((u32)(i2c_bus->reg_base) & 0xFFF)/0x80);
                            ^~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1407 drivers/i2c/busses/i2c-new-aspeed.c

  1402	
  1403	static void aspeed_new_i2c_init(struct aspeed_new_i2c_bus *i2c_bus)
  1404	{
  1405		struct platform_device *pdev = to_platform_device(i2c_bus->dev);
  1406		u32 fun_ctrl = AST_I2CC_BUS_AUTO_RELEASE | AST_I2CC_MASTER_EN;
> 1407		u8 i2c_count = (((u32)(i2c_bus->reg_base) & 0xFFF)/0x80);
  1408	
  1409		/* I2C Reset */
  1410		writel(0, i2c_bus->reg_base + AST_I2CC_FUN_CTRL);
  1411	
  1412		if (of_property_read_bool(pdev->dev.of_node, "multi-master"))
  1413			i2c_bus->multi_master = true;
  1414		else
  1415			fun_ctrl |= AST_I2CC_MULTI_MASTER_DIS;
  1416	
  1417		/* AST2600 i2c10 need to overcome sda glich with is flag. */
  1418		if (i2c_count == 0xA)
  1419			fun_ctrl |= AST_I2CC_SDA_DRIVE_1T_EN;
  1420	
  1421		/* Enable Master Mode */
  1422		writel(fun_ctrl, i2c_bus->reg_base + AST_I2CC_FUN_CTRL);
  1423		/* disable slave address */
  1424		writel(0, i2c_bus->reg_base + AST_I2CS_ADDR_CTRL);
  1425	
  1426		/* Set AC Timing */
  1427		writel(aspeed_select_i2c_clock(i2c_bus), i2c_bus->reg_base + AST_I2CC_AC_TIMING);
  1428	
  1429		/* Clear Interrupt */
  1430		writel(0xfffffff, i2c_bus->reg_base + AST_I2CM_ISR);
  1431	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

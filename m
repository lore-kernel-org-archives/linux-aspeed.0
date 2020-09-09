From: kernel test robot <lkp@intel.com>
Date: Wed, 9 Sep 2020 15:59:12 +0800
Subject: [PATCH v2 3/5] i2c: aspeed: Mask IRQ status to relevant bits
In-Reply-To: <20200908200101.64974-4-eajames@linux.ibm.com>
References: <20200908200101.64974-4-eajames@linux.ibm.com>
Message-ID: <202009091551.SHV1AEmW%lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

I love your patch! Perhaps something to improve:

[auto build test WARNING on joel-aspeed/for-next]
[also build test WARNING on wsa/i2c/for-next linus/master v5.9-rc4 next-20200908]
[cannot apply to input/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Eddie-James/input-misc-Add-IBM-Operation-Panel-driver/20200909-120637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git for-next
config: x86_64-randconfig-a016-20200909 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 8893d0816ccdf8998d2e21b5430e9d6abe7ef465)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-aspeed.c:88:9: warning: 'ASPEED_I2CD_INTR_ALL' macro redefined [-Wmacro-redefined]
   #define ASPEED_I2CD_INTR_ALL                                                   \
           ^
   drivers/i2c/busses/i2c-aspeed.c:72:9: note: previous definition is here
   #define ASPEED_I2CD_INTR_ALL                            0xf000ffff
           ^
   1 warning generated.

# https://github.com/0day-ci/linux/commit/6d9e57527652ab1a348f68145e41e6a19d5dc0dc
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Eddie-James/input-misc-Add-IBM-Operation-Panel-driver/20200909-120637
git checkout 6d9e57527652ab1a348f68145e41e6a19d5dc0dc
vim +/ASPEED_I2CD_INTR_ALL +88 drivers/i2c/busses/i2c-aspeed.c

f327c686d3ba44e Brendan Higgins 2017-06-20  65  
f327c686d3ba44e Brendan Higgins 2017-06-20  66  /* 0x0c : I2CD Interrupt Control Register &
f327c686d3ba44e Brendan Higgins 2017-06-20  67   * 0x10 : I2CD Interrupt Status Register
f327c686d3ba44e Brendan Higgins 2017-06-20  68   *
f327c686d3ba44e Brendan Higgins 2017-06-20  69   * These share bit definitions, so use the same values for the enable &
f327c686d3ba44e Brendan Higgins 2017-06-20  70   * status bits.
f327c686d3ba44e Brendan Higgins 2017-06-20  71   */
6d9e57527652ab1 Eddie James     2020-09-08  72  #define ASPEED_I2CD_INTR_ALL				0xf000ffff
f327c686d3ba44e Brendan Higgins 2017-06-20  73  #define ASPEED_I2CD_INTR_SDA_DL_TIMEOUT			BIT(14)
f327c686d3ba44e Brendan Higgins 2017-06-20  74  #define ASPEED_I2CD_INTR_BUS_RECOVER_DONE		BIT(13)
f9eb91350bb20b3 Brendan Higgins 2017-06-20  75  #define ASPEED_I2CD_INTR_SLAVE_MATCH			BIT(7)
f327c686d3ba44e Brendan Higgins 2017-06-20  76  #define ASPEED_I2CD_INTR_SCL_TIMEOUT			BIT(6)
f327c686d3ba44e Brendan Higgins 2017-06-20  77  #define ASPEED_I2CD_INTR_ABNORMAL			BIT(5)
f327c686d3ba44e Brendan Higgins 2017-06-20  78  #define ASPEED_I2CD_INTR_NORMAL_STOP			BIT(4)
f327c686d3ba44e Brendan Higgins 2017-06-20  79  #define ASPEED_I2CD_INTR_ARBIT_LOSS			BIT(3)
f327c686d3ba44e Brendan Higgins 2017-06-20  80  #define ASPEED_I2CD_INTR_RX_DONE			BIT(2)
f327c686d3ba44e Brendan Higgins 2017-06-20  81  #define ASPEED_I2CD_INTR_TX_NAK				BIT(1)
f327c686d3ba44e Brendan Higgins 2017-06-20  82  #define ASPEED_I2CD_INTR_TX_ACK				BIT(0)
3e9efc3299dd78a Jae Hyun Yoo    2018-08-23  83  #define ASPEED_I2CD_INTR_MASTER_ERRORS					       \
3e9efc3299dd78a Jae Hyun Yoo    2018-08-23  84  		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
3e9efc3299dd78a Jae Hyun Yoo    2018-08-23  85  		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
3e9efc3299dd78a Jae Hyun Yoo    2018-08-23  86  		 ASPEED_I2CD_INTR_ABNORMAL |				       \
3e9efc3299dd78a Jae Hyun Yoo    2018-08-23  87  		 ASPEED_I2CD_INTR_ARBIT_LOSS)
f327c686d3ba44e Brendan Higgins 2017-06-20 @88  #define ASPEED_I2CD_INTR_ALL						       \
f327c686d3ba44e Brendan Higgins 2017-06-20  89  		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
f327c686d3ba44e Brendan Higgins 2017-06-20  90  		 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
f327c686d3ba44e Brendan Higgins 2017-06-20  91  		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
f327c686d3ba44e Brendan Higgins 2017-06-20  92  		 ASPEED_I2CD_INTR_ABNORMAL |				       \
f327c686d3ba44e Brendan Higgins 2017-06-20  93  		 ASPEED_I2CD_INTR_NORMAL_STOP |				       \
f327c686d3ba44e Brendan Higgins 2017-06-20  94  		 ASPEED_I2CD_INTR_ARBIT_LOSS |				       \
f327c686d3ba44e Brendan Higgins 2017-06-20  95  		 ASPEED_I2CD_INTR_RX_DONE |				       \
f327c686d3ba44e Brendan Higgins 2017-06-20  96  		 ASPEED_I2CD_INTR_TX_NAK |				       \
f327c686d3ba44e Brendan Higgins 2017-06-20  97  		 ASPEED_I2CD_INTR_TX_ACK)
f327c686d3ba44e Brendan Higgins 2017-06-20  98  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37048 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200909/d07b9eff/attachment-0001.gz>

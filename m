From: kernel test robot <lkp@intel.com>
Date: Sun, 5 Dec 2021 04:45:48 +0800
Subject: [PATCH v7] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <20211202091303.979044-1-howard.chiu@quantatw.com>
References: <20211202091303.979044-1-howard.chiu@quantatw.com>
Message-ID: <202112050427.TQfPqAXr-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Howard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on v5.16-rc3 next-20211203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Howard-Chiu/ARM-dts-aspeed-Adding-Facebook-Bletchley-BMC/20211202-171524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm-randconfig-c002-20211202 (https://download.01.org/0day-ci/archive/20211205/202112050427.TQfPqAXr-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4c77c422c22eee6a98c7e5f25325ab535a06c4c5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Howard-Chiu/ARM-dts-aspeed-Adding-Facebook-Bletchley-BMC/20211202-171524
        git checkout 4c77c422c22eee6a98c7e5f25325ab535a06c4c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts:810.1-5 Label or path pwm not found
>> Error: arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts:820.1-6 Label or path tach not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

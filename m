From: kernel test robot <lkp@intel.com>
Date: Fri, 14 Jan 2022 05:01:48 +0800
Subject: [PATCH v5 05/13] peci: Add peci-aspeed controller driver
In-Reply-To: <20220112230247.982212-6-iwona.winiarska@intel.com>
References: <20220112230247.982212-6-iwona.winiarska@intel.com>
Message-ID: <202201140455.rWgkX1hh-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Iwona,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linux/master linus/master v5.16 next-20220113]
[cannot apply to joel-aspeed/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Iwona-Winiarska/Introduce-PECI-subsystem/20220113-071131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: ia64-randconfig-r033-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140455.rWgkX1hh-lkp at intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9b4f2401a427cff2efc191f507d73ec8ae1ad872
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Iwona-Winiarska/Introduce-PECI-subsystem/20220113-071131
        git checkout 9b4f2401a427cff2efc191f507d73ec8ae1ad872
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_clk_hw_register" [drivers/peci/controller/peci-aspeed.ko] undefined!
>> ERROR: modpost: "__clk_get_name" [drivers/peci/controller/peci-aspeed.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

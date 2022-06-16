From: kernel test robot <lkp@intel.com>
Date: Fri, 17 Jun 2022 04:04:50 +0800
Subject: [PATCH v8 1/3] ipmi: ssif_bmc: Add SSIF BMC driver
In-Reply-To: <20220615090259.1121405-2-quan@os.amperecomputing.com>
References: <20220615090259.1121405-2-quan@os.amperecomputing.com>
Message-ID: <202206170337.0kCTfR63-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Quan,

I love your patch! Yet something to improve:

[auto build test ERROR on cminyard-ipmi/for-next]
[also build test ERROR on wsa/i2c/for-next v5.19-rc2 next-20220616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Quan-Nguyen/Add-SSIF-BMC-driver/20220615-170539
base:   https://github.com/cminyard/linux-ipmi for-next
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220617/202206170337.0kCTfR63-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0feb5f0351d090633e7522dbec22de419a04b85f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Quan-Nguyen/Add-SSIF-BMC-driver/20220615-170539
        git checkout 0feb5f0351d090633e7522dbec22de419a04b85f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/ipmi_ssif_bmc.h:13:2: error: unknown type name '__u8'
           __u8    payload[IPMI_SSIF_PAYLOAD_MAX];
           ^
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

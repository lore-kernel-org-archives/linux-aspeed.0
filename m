From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Mar 2022 14:20:44 +0800
Subject: [PATCH v6 1/4] ipmi: ssif_bmc: Add SSIF BMC driver
In-Reply-To: <20220310114119.13736-2-quan@os.amperecomputing.com>
References: <20220310114119.13736-2-quan@os.amperecomputing.com>
Message-ID: <202203111440.hG9yioyl-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Quan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on wsa/i2c/for-next cminyard-ipmi/for-next v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Quan-Nguyen/Add-SSIF-BMC-driver/20220310-194342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 3dd9a926ec2308e49445f22abef149fc64e9332e
config: mips-randconfig-s031-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111440.hG9yioyl-lkp at intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/a977225b8997c2fdb51eddeee79de36075d3ce4d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Quan-Nguyen/Add-SSIF-BMC-driver/20220310-194342
        git checkout a977225b8997c2fdb51eddeee79de36075d3ce4d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/char/ipmi/ssif_bmc.c:181:27: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t ( *poll )( ... ) @@     got unsigned int ( * )( ... ) @@
   drivers/char/ipmi/ssif_bmc.c:181:27: sparse:     expected restricted __poll_t ( *poll )( ... )
   drivers/char/ipmi/ssif_bmc.c:181:27: sparse:     got unsigned int ( * )( ... )

vim +181 drivers/char/ipmi/ssif_bmc.c

   171	
   172	/*
   173	 * System calls to device interface for user apps
   174	 */
   175	static const struct file_operations ssif_bmc_fops = {
   176		.owner		= THIS_MODULE,
   177		.open		= ssif_bmc_open,
   178		.read		= ssif_bmc_read,
   179		.write		= ssif_bmc_write,
   180		.release	= ssif_bmc_release,
 > 181		.poll		= ssif_bmc_poll,
   182	};
   183	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

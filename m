From: kernel test robot <lkp@intel.com>
Date: Sat, 18 Jun 2022 22:49:16 +0800
Subject: [PATCH 2/5] kunit: flatten kunit_suite*** to kunit_suite** in
 .kunit_test_suites
In-Reply-To: <20220618090310.1174932-3-davidgow@google.com>
References: <20220618090310.1174932-3-davidgow@google.com>
Message-ID: <202206182258.EahbTrAv-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc2 next-20220617]
[cannot apply to mcgrof/modules-next joel-aspeed/for-next ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4b35035bcf80ddb47c0112c4fbd84a63a2836a18
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220618/202206182258.EahbTrAv-lkp at intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c2386c54cc9fd471e5353f375ff71734214ed3c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
        git checkout c2386c54cc9fd471e5353f375ff71734214ed3c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653 HEAD fddb3ea0ed5627098eabc542fdba5a8b4b769066 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/thunderbolt/test.c: In function 'tb_test_init':
>> drivers/thunderbolt/test.c:2824:16: error: too few arguments to function '__kunit_test_suites_init'
    2824 |         return __kunit_test_suites_init(tb_test_suites);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/thunderbolt/test.c:9:
   include/kunit/test.h:240:5: note: declared here
     240 | int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thunderbolt/test.c: In function 'tb_test_exit':
>> drivers/thunderbolt/test.c:2829:16: error: too few arguments to function '__kunit_test_suites_exit'
    2829 |         return __kunit_test_suites_exit(tb_test_suites);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/thunderbolt/test.c:9:
   include/kunit/test.h:242:6: note: declared here
     242 | void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thunderbolt/test.c:2829:16: error: 'return' with a value, in function returning void [-Werror=return-type]
    2829 |         return __kunit_test_suites_exit(tb_test_suites);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thunderbolt/test.c:2827:6: note: declared here
    2827 | void tb_test_exit(void)
         |      ^~~~~~~~~~~~
   drivers/thunderbolt/test.c: In function 'tb_test_init':
   drivers/thunderbolt/test.c:2825:1: error: control reaches end of non-void function [-Werror=return-type]
    2825 | }
         | ^
   cc1: some warnings being treated as errors


vim +/__kunit_test_suites_init +2824 drivers/thunderbolt/test.c

2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2821  
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2822  int tb_test_init(void)
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2823  {
2c6ea4e2cefe2e Mika Westerberg 2020-08-24 @2824  	return __kunit_test_suites_init(tb_test_suites);
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2825  }
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2826  
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2827  void tb_test_exit(void)
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2828  {
2c6ea4e2cefe2e Mika Westerberg 2020-08-24 @2829  	return __kunit_test_suites_exit(tb_test_suites);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

From: kernel test robot <lkp@intel.com>
Date: Sat, 18 Jun 2022 21:58:28 +0800
Subject: [PATCH 2/5] kunit: flatten kunit_suite*** to kunit_suite** in
 .kunit_test_suites
In-Reply-To: <20220618090310.1174932-3-davidgow@google.com>
References: <20220618090310.1174932-3-davidgow@google.com>
Message-ID: <202206182117.58z5vWxq-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc2 next-20220617]
[cannot apply to mcgrof/modules-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4b35035bcf80ddb47c0112c4fbd84a63a2836a18
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220618/202206182117.58z5vWxq-lkp at intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c2386c54cc9fd471e5353f375ff71734214ed3c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
        git checkout c2386c54cc9fd471e5353f375ff71734214ed3c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653 HEAD fddb3ea0ed5627098eabc542fdba5a8b4b769066 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-aspeed.c: In function 'aspeed_sdc_tests_init':
>> drivers/mmc/host/sdhci-of-aspeed.c:612:16: error: too few arguments to function '__kunit_test_suites_init'
     612 |         return __kunit_test_suites_init(aspeed_sdc_test_suites);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mmc/host/sdhci-of-aspeed-test.c:4,
                    from drivers/mmc/host/sdhci-of-aspeed.c:608:
   include/kunit/test.h:240:5: note: declared here
     240 | int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-aspeed.c: In function 'aspeed_sdc_tests_exit':
>> drivers/mmc/host/sdhci-of-aspeed.c:617:9: error: too few arguments to function '__kunit_test_suites_exit'
     617 |         __kunit_test_suites_exit(aspeed_sdc_test_suites);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mmc/host/sdhci-of-aspeed-test.c:4,
                    from drivers/mmc/host/sdhci-of-aspeed.c:608:
   include/kunit/test.h:242:6: note: declared here
     242 | void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-aspeed.c: In function 'aspeed_sdc_tests_init':
   drivers/mmc/host/sdhci-of-aspeed.c:613:1: error: control reaches end of non-void function [-Werror=return-type]
     613 | }
         | ^
   cc1: some warnings being treated as errors


vim +/__kunit_test_suites_init +612 drivers/mmc/host/sdhci-of-aspeed.c

4af307f574260c Andrew Jeffery 2021-01-22  609  
4af307f574260c Andrew Jeffery 2021-01-22  610  static inline int aspeed_sdc_tests_init(void)
4af307f574260c Andrew Jeffery 2021-01-22  611  {
4af307f574260c Andrew Jeffery 2021-01-22 @612  	return __kunit_test_suites_init(aspeed_sdc_test_suites);
4af307f574260c Andrew Jeffery 2021-01-22  613  }
4af307f574260c Andrew Jeffery 2021-01-22  614  
4af307f574260c Andrew Jeffery 2021-01-22  615  static inline void aspeed_sdc_tests_exit(void)
4af307f574260c Andrew Jeffery 2021-01-22  616  {
4af307f574260c Andrew Jeffery 2021-01-22 @617  	__kunit_test_suites_exit(aspeed_sdc_test_suites);
4af307f574260c Andrew Jeffery 2021-01-22  618  }
4af307f574260c Andrew Jeffery 2021-01-22  619  #else
4af307f574260c Andrew Jeffery 2021-01-22  620  static inline int aspeed_sdc_tests_init(void)
4af307f574260c Andrew Jeffery 2021-01-22  621  {
4af307f574260c Andrew Jeffery 2021-01-22  622  	return 0;
4af307f574260c Andrew Jeffery 2021-01-22  623  }
4af307f574260c Andrew Jeffery 2021-01-22  624  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

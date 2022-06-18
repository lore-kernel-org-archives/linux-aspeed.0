From: kernel test robot <lkp@intel.com>
Date: Sat, 18 Jun 2022 20:47:26 +0800
Subject: [PATCH 1/5] kunit: unify module and builtin suite definitions
In-Reply-To: <20220618090310.1174932-2-davidgow@google.com>
References: <20220618090310.1174932-2-davidgow@google.com>
Message-ID: <202206182025.UNVY0coI-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc2 next-20220617]
[cannot apply to mcgrof/modules-next joel-aspeed/for-next ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4b35035bcf80ddb47c0112c4fbd84a63a2836a18
config: riscv-randconfig-r034-20220617 (https://download.01.org/0day-ci/archive/20220618/202206182025.UNVY0coI-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 91688716ba49942051dccdf7b9c4f81a7ec8feaf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/14ff6ae01a41e301f1409874dd5aa38f73bc96f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
        git checkout 14ff6ae01a41e301f1409874dd5aa38f73bc96f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash lib/kunit/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/kunit/test.c:618:23: error: no member named 'num_kunit_suites' in 'struct module'
           for (i = 0; i < mod->num_kunit_suites; i++)
                           ~~~  ^
>> lib/kunit/test.c:619:33: error: no member named 'kunit_suites' in 'struct module'
                   __kunit_test_suites_init(mod->kunit_suites[i]);
                                            ~~~  ^
   lib/kunit/test.c:626:23: error: no member named 'num_kunit_suites' in 'struct module'
           for (i = 0; i < mod->num_kunit_suites; i++)
                           ~~~  ^
   lib/kunit/test.c:627:33: error: no member named 'kunit_suites' in 'struct module'
                   __kunit_test_suites_exit(mod->kunit_suites[i]);
                                            ~~~  ^
   4 errors generated.


vim +618 lib/kunit/test.c

   612	
   613	#ifdef CONFIG_MODULES
   614	static void kunit_module_init(struct module *mod)
   615	{
   616		unsigned int i;
   617	
 > 618		for (i = 0; i < mod->num_kunit_suites; i++)
 > 619			__kunit_test_suites_init(mod->kunit_suites[i]);
   620	}
   621	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

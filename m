From: kernel test robot <lkp@intel.com>
Date: Fri, 5 Jan 2024 03:01:51 +0800
Subject: [PATCH v11 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
In-Reply-To: <20240104034120.3516290-4-billy_tsai@aspeedtech.com>
References: <20240104034120.3516290-4-billy_tsai@aspeedtech.com>
Message-ID: <202401050234.nDBceclJ-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.7-rc8 next-20240104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-hwmon-fan-Add-fan-binding-to-schema/20240104-114552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240104034120.3516290-4-billy_tsai%40aspeedtech.com
patch subject: [PATCH v11 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240105/202401050234.nDBceclJ-lkp at intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240105/202401050234.nDBceclJ-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401050234.nDBceclJ-lkp at intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/aspeed-g6-pwm-tach.c:270:3: error: field designator 'owner' does not refer to any field in type 'const struct pwm_ops'
     270 |         .owner = THIS_MODULE,
         |         ~^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +270 drivers/hwmon/aspeed-g6-pwm-tach.c

   266	
   267	static const struct pwm_ops aspeed_pwm_ops = {
   268		.apply = aspeed_pwm_apply,
   269		.get_state = aspeed_pwm_get_state,
 > 270		.owner = THIS_MODULE,
   271	};
   272	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

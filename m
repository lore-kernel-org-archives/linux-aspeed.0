From: kernel test robot <lkp@intel.com>
Date: Fri, 18 Aug 2023 02:57:08 +0800
Subject: [PATCH v7 2/2] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
In-Reply-To: <20230817120029.221484-3-billy_tsai@aspeedtech.com>
References: <20230817120029.221484-3-billy_tsai@aspeedtech.com>
Message-ID: <202308180218.lgWU1tp1-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.5-rc6 next-20230817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-hwmon-Support-Aspeed-g6-PWM-TACH-Control/20230817-200427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230817120029.221484-3-billy_tsai%40aspeedtech.com
patch subject: [PATCH v7 2/2] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach
config: powerpc-randconfig-r011-20230818 (https://download.01.org/0day-ci/archive/20230818/202308180218.lgWU1tp1-lkp at intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180218.lgWU1tp1-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180218.lgWU1tp1-lkp at intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/aspeed-g6-pwm-tach.c:431:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     431 |         int ret, count;
         |             ^
   1 warning generated.


vim +/ret +431 drivers/hwmon/aspeed-g6-pwm-tach.c

   426	
   427	static int aspeed_tach_create_fan(struct device *dev,
   428					  struct aspeed_pwm_tach_data *priv)
   429	{
   430		u8 *tach_ch;
 > 431		int ret, count;
   432	
   433		count = of_property_count_u8_elems(dev->of_node, "aspeed,fan-tach-ch");
   434		if (count < 1)
   435			return -EINVAL;
   436		tach_ch = devm_kcalloc(dev, count, sizeof(*tach_ch), GFP_KERNEL);
   437		if (!tach_ch)
   438			return -ENOMEM;
   439		ret = of_property_read_u8_array(dev->of_node, "aspeed,fan-tach-ch",
   440						tach_ch, count);
   441	
   442		aspeed_present_fan_tach(priv, tach_ch, count);
   443	
   444		return 0;
   445	}
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

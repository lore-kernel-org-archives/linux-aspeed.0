From: kernel test robot <lkp@intel.com>
Date: Sat, 31 Aug 2024 11:39:13 +0800
Subject: [PATCH v2 4/4] gpio: aspeed: Support G7 Aspeed gpio controller
In-Reply-To: <20240830034047.2251482-5-billy_tsai@aspeedtech.com>
References: <20240830034047.2251482-5-billy_tsai@aspeedtech.com>
Message-ID: <202408311104.T3i0AxEf-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-gpio-aspeed-ast2400-gpio-Support-ast2700/20240830-114325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240830034047.2251482-5-billy_tsai%40aspeedtech.com
patch subject: [PATCH v2 4/4] gpio: aspeed: Support G7 Aspeed gpio controller
config: openrisc-randconfig-r131-20240830 (https://download.01.org/0day-ci/archive/20240831/202408311104.T3i0AxEf-lkp at intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240831/202408311104.T3i0AxEf-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311104.T3i0AxEf-lkp at intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpio/gpio-aspeed.c:1181:26: sparse: sparse: symbol 'aspeed_g4_llops' was not declared. Should it be static?
>> drivers/gpio/gpio-aspeed.c:1215:26: sparse: sparse: symbol 'aspeed_g7_llops' was not declared. Should it be static?

vim +/aspeed_g7_llops +1215 drivers/gpio/gpio-aspeed.c

  1214	
> 1215	struct aspeed_gpio_llops aspeed_g7_llops = {
  1216		.copro_request = NULL,
  1217		.copro_release = NULL,
  1218		.reg_bits_set = aspeed_g7_reg_bits_set,
  1219		.reg_bits_read = aspeed_g7_reg_bits_read,
  1220	};
  1221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

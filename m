From: kernel test robot <lkp@intel.com>
Date: Sat, 31 Aug 2024 09:46:38 +0800
Subject: [PATCH v2 3/4] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <20240830034047.2251482-4-billy_tsai@aspeedtech.com>
References: <20240830034047.2251482-4-billy_tsai@aspeedtech.com>
Message-ID: <202408310953.Z0c7NIuz-lkp@intel.com>
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
patch link:    https://lore.kernel.org/r/20240830034047.2251482-4-billy_tsai%40aspeedtech.com
patch subject: [PATCH v2 3/4] gpio: aspeed: Create llops to handle hardware access
config: openrisc-randconfig-r131-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310953.Z0c7NIuz-lkp at intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240831/202408310953.Z0c7NIuz-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310953.Z0c7NIuz-lkp at intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpio/gpio-aspeed.c:1107:26: sparse: sparse: symbol 'aspeed_g4_llops' was not declared. Should it be static?

vim +/aspeed_g4_llops +1107 drivers/gpio/gpio-aspeed.c

  1106	
> 1107	struct aspeed_gpio_llops aspeed_g4_llops = {
  1108		.copro_request = aspeed_gpio_copro_request,
  1109		.copro_release = aspeed_gpio_copro_release,
  1110		.reg_bits_set = aspeed_g4_reg_bits_set,
  1111		.reg_bits_read = aspeed_g4_reg_bits_read,
  1112	};
  1113	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

From: kernel test robot <lkp@intel.com>
Date: Thu, 22 Aug 2024 07:13:52 +0800
Subject: [PATCH v1 2/2] gpio: Add G7 Aspeed gpio controller driver
In-Reply-To: <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
References: <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
Message-ID: <202408220503.hxIARcuf-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

kernel test robot noticed the following build errors:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.11-rc4 next-20240821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-gpio-aspeed-ast2400-gpio-Support-ast2700/20240821-150951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240821070740.2378602-3-billy_tsai%40aspeedtech.com
patch subject: [PATCH v1 2/2] gpio: Add G7 Aspeed gpio controller driver
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240822/202408220503.hxIARcuf-lkp at intel.com/config)
compiler: mips-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408220503.hxIARcuf-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408220503.hxIARcuf-lkp at intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/gpio/gpio-aspeed-g7.c: In function 'aspeed_gpio_g7_request':
>> drivers/gpio/gpio-aspeed-g7.c:474:48: error: passing argument 1 of 'pinctrl_gpio_request' makes pointer from integer without a cast [-Wint-conversion]
     474 |         return pinctrl_gpio_request(chip->base + offset);
         |                                     ~~~~~~~~~~~^~~~~~~~
         |                                                |
         |                                                unsigned int
   In file included from drivers/gpio/gpio-aspeed-g7.c:16:
   include/linux/pinctrl/consumer.h:30:44: note: expected 'struct gpio_chip *' but argument is of type 'unsigned int'
      30 | int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset);
         |                          ~~~~~~~~~~~~~~~~~~^~
>> drivers/gpio/gpio-aspeed-g7.c:474:16: error: too few arguments to function 'pinctrl_gpio_request'
     474 |         return pinctrl_gpio_request(chip->base + offset);
         |                ^~~~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/consumer.h:30:5: note: declared here
      30 | int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset);
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed-g7.c: In function 'aspeed_gpio_g7_free':
>> drivers/gpio/gpio-aspeed-g7.c:479:38: error: passing argument 1 of 'pinctrl_gpio_free' makes pointer from integer without a cast [-Wint-conversion]
     479 |         pinctrl_gpio_free(chip->base + offset);
         |                           ~~~~~~~~~~~^~~~~~~~
         |                                      |
         |                                      unsigned int
   include/linux/pinctrl/consumer.h:31:42: note: expected 'struct gpio_chip *' but argument is of type 'unsigned int'
      31 | void pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset);
         |                        ~~~~~~~~~~~~~~~~~~^~
>> drivers/gpio/gpio-aspeed-g7.c:479:9: error: too few arguments to function 'pinctrl_gpio_free'
     479 |         pinctrl_gpio_free(chip->base + offset);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/consumer.h:31:6: note: declared here
      31 | void pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset);
         |      ^~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed-g7.c: In function 'aspeed_gpio_g7_set_config':
>> drivers/gpio/gpio-aspeed-g7.c:676:48: error: passing argument 1 of 'pinctrl_gpio_set_config' makes pointer from integer without a cast [-Wint-conversion]
     676 |                 return pinctrl_gpio_set_config(offset, config);
         |                                                ^~~~~~
         |                                                |
         |                                                unsigned int
   include/linux/pinctrl/consumer.h:36:47: note: expected 'struct gpio_chip *' but argument is of type 'unsigned int'
      36 | int pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
         |                             ~~~~~~~~~~~~~~~~~~^~
>> drivers/gpio/gpio-aspeed-g7.c:676:24: error: too few arguments to function 'pinctrl_gpio_set_config'
     676 |                 return pinctrl_gpio_set_config(offset, config);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pinctrl/consumer.h:36:5: note: declared here
      36 | int pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed-g7.c: In function 'aspeed_gpio_g7_request':
>> drivers/gpio/gpio-aspeed-g7.c:475:1: warning: control reaches end of non-void function [-Wreturn-type]
     475 | }
         | ^


vim +/pinctrl_gpio_request +474 drivers/gpio/gpio-aspeed-g7.c

   468	
   469	static int aspeed_gpio_g7_request(struct gpio_chip *chip, unsigned int offset)
   470	{
   471		if (!have_gpio(gpiochip_get_data(chip), offset))
   472			return -ENODEV;
   473	
 > 474		return pinctrl_gpio_request(chip->base + offset);
 > 475	}
   476	
   477	static void aspeed_gpio_g7_free(struct gpio_chip *chip, unsigned int offset)
   478	{
 > 479		pinctrl_gpio_free(chip->base + offset);
   480	}
   481	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

From: kernel test robot <lkp@intel.com>
Date: Sat, 31 Aug 2024 00:07:37 +0800
Subject: [PATCH v2 3/4] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <20240830034047.2251482-4-billy_tsai@aspeedtech.com>
References: <20240830034047.2251482-4-billy_tsai@aspeedtech.com>
Message-ID: <202408302344.bCpCF6bu-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240830 (https://download.01.org/0day-ci/archive/20240830/202408302344.bCpCF6bu-lkp at intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408302344.bCpCF6bu-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408302344.bCpCF6bu-lkp at intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-aspeed.c:394:6: warning: variable 'copro' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     394 |         if (gpio->llops->copro_request)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed.c:399:6: note: uninitialized use occurs here
     399 |         if (copro && gpio->llops->copro_release)
         |             ^~~~~
   drivers/gpio/gpio-aspeed.c:394:2: note: remove the 'if' if its condition is always true
     394 |         if (gpio->llops->copro_request)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     395 |                 copro = gpio->llops->copro_request(gpio, offset);
   drivers/gpio/gpio-aspeed.c:391:12: note: initialize the variable 'copro' to silence this warning
     391 |         bool copro;
         |                   ^
         |                    = 0
   drivers/gpio/gpio-aspeed.c:415:6: warning: variable 'copro' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     415 |         if (gpio->llops->copro_request)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed.c:418:6: note: uninitialized use occurs here
     418 |         if (copro && gpio->llops->copro_release)
         |             ^~~~~
   drivers/gpio/gpio-aspeed.c:415:2: note: remove the 'if' if its condition is always true
     415 |         if (gpio->llops->copro_request)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     416 |                 copro = gpio->llops->copro_request(gpio, offset);
   drivers/gpio/gpio-aspeed.c:408:12: note: initialize the variable 'copro' to silence this warning
     408 |         bool copro;
         |                   ^
         |                    = 0
   drivers/gpio/gpio-aspeed.c:438:6: warning: variable 'copro' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     438 |         if (gpio->llops->copro_request)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed.c:443:6: note: uninitialized use occurs here
     443 |         if (copro && gpio->llops->copro_release)
         |             ^~~~~
   drivers/gpio/gpio-aspeed.c:438:2: note: remove the 'if' if its condition is always true
     438 |         if (gpio->llops->copro_request)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     439 |                 copro = gpio->llops->copro_request(gpio, offset);
   drivers/gpio/gpio-aspeed.c:431:12: note: initialize the variable 'copro' to silence this warning
     431 |         bool copro;
         |                   ^
         |                    = 0
   drivers/gpio/gpio-aspeed.c:502:6: warning: variable 'copro' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     502 |         if (gpio->llops->copro_request)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed.c:507:6: note: uninitialized use occurs here
     507 |         if (copro && gpio->llops->copro_release)
         |             ^~~~~
   drivers/gpio/gpio-aspeed.c:502:2: note: remove the 'if' if its condition is always true
     502 |         if (gpio->llops->copro_request)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     503 |                 copro = gpio->llops->copro_request(gpio, offset);
   drivers/gpio/gpio-aspeed.c:495:12: note: initialize the variable 'copro' to silence this warning
     495 |         bool copro;
         |                   ^
         |                    = 0
   drivers/gpio/gpio-aspeed.c:528:6: warning: variable 'copro' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     528 |         if (gpio->llops->copro_request)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed.c:533:6: note: uninitialized use occurs here
     533 |         if (copro && gpio->llops->copro_release)
         |             ^~~~~
   drivers/gpio/gpio-aspeed.c:528:2: note: remove the 'if' if its condition is always true
     528 |         if (gpio->llops->copro_request)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     529 |                 copro = gpio->llops->copro_request(gpio, offset);
   drivers/gpio/gpio-aspeed.c:517:12: note: initialize the variable 'copro' to silence this warning
     517 |         bool copro;
         |                   ^
         |                    = 0
   drivers/gpio/gpio-aspeed.c:589:6: warning: variable 'copro' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     589 |         if (gpio->llops->copro_request)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed.c:596:6: note: uninitialized use occurs here
     596 |         if (copro && gpio->llops->copro_release)
         |             ^~~~~
   drivers/gpio/gpio-aspeed.c:589:2: note: remove the 'if' if its condition is always true
     589 |         if (gpio->llops->copro_request)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     590 |                 copro = gpio->llops->copro_request(gpio, offset);
   drivers/gpio/gpio-aspeed.c:561:12: note: initialize the variable 'copro' to silence this warning
     561 |         bool copro;
         |                   ^
         |                    = 0
   drivers/gpio/gpio-aspeed.c:659:6: warning: variable 'copro' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     659 |         if (gpio->llops->copro_request)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-aspeed.c:664:6: note: uninitialized use occurs here
     664 |         if (copro && gpio->llops->copro_release)
         |             ^~~~~
   drivers/gpio/gpio-aspeed.c:659:2: note: remove the 'if' if its condition is always true
     659 |         if (gpio->llops->copro_request)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     660 |                 copro = gpio->llops->copro_request(gpio, offset);
   drivers/gpio/gpio-aspeed.c:656:12: note: initialize the variable 'copro' to silence this warning
     656 |         bool copro;
         |                   ^
         |                    = 0
   7 warnings generated.


vim +394 drivers/gpio/gpio-aspeed.c

   385	
   386	static void aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
   387				    int val)
   388	{
   389		struct aspeed_gpio *gpio = gpiochip_get_data(gc);
   390		unsigned long flags;
   391		bool copro;
   392	
   393		raw_spin_lock_irqsave(&gpio->lock, flags);
 > 394		if (gpio->llops->copro_request)
   395			copro = gpio->llops->copro_request(gpio, offset);
   396	
   397		__aspeed_gpio_set(gc, offset, val);
   398	
   399		if (copro && gpio->llops->copro_release)
   400			gpio->llops->copro_release(gpio, offset);
   401		raw_spin_unlock_irqrestore(&gpio->lock, flags);
   402	}
   403	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

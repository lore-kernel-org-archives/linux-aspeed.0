From: kernel test robot <lkp@intel.com>
Date: Thu, 16 Jul 2020 03:37:26 +0800
Subject: [PATCH 1/2] gpio/aspeed-sgpio: enable access to all 80 input &
 output sgpios
In-Reply-To: <20200715135418.3194860-1-jk@codeconstruct.com.au>
References: <20200715135418.3194860-1-jk@codeconstruct.com.au>
Message-ID: <202007160322.peZTUYoc%lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on gpio/for-next]
[also build test WARNING on joel-aspeed/for-next v5.8-rc5 next-20200715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeremy-Kerr/gpio-aspeed-sgpio-enable-access-to-all-80-input-output-sgpios/20200715-221503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-aspeed-sgpio.c:162:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
     162 | static const bool aspeed_sgpio_is_input(unsigned int offset)
         |        ^~~~~
   drivers/gpio/gpio-aspeed-sgpio.c: In function 'aspeed_sgpio_dir_out':
>> drivers/gpio/gpio-aspeed-sgpio.c:233:6: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
     233 |  int rc;
         |      ^~

vim +162 drivers/gpio/gpio-aspeed-sgpio.c

   161	
 > 162	static const bool aspeed_sgpio_is_input(unsigned int offset)
   163	{
   164		return offset < SGPIO_OUTPUT_OFFSET;
   165	}
   166	
   167	static int aspeed_sgpio_get(struct gpio_chip *gc, unsigned int offset)
   168	{
   169		struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
   170		const struct aspeed_sgpio_bank *bank = to_bank(offset);
   171		unsigned long flags;
   172		enum aspeed_sgpio_reg reg;
   173		int rc = 0;
   174	
   175		spin_lock_irqsave(&gpio->lock, flags);
   176	
   177		reg = aspeed_sgpio_is_input(offset) ? reg_val : reg_rdata;
   178		rc = !!(ioread32(bank_reg(gpio, bank, reg)) & GPIO_BIT(offset));
   179	
   180		spin_unlock_irqrestore(&gpio->lock, flags);
   181	
   182		return rc;
   183	}
   184	
   185	static int sgpio_set_value(struct gpio_chip *gc, unsigned int offset, int val)
   186	{
   187		struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
   188		const struct aspeed_sgpio_bank *bank = to_bank(offset);
   189		void __iomem *addr_r, *addr_w;
   190		u32 reg = 0;
   191	
   192		if (aspeed_sgpio_is_input(offset))
   193			return -EINVAL;
   194	
   195		/* Since this is an output, read the cached value from rdata, then
   196		 * update val. */
   197		addr_r = bank_reg(gpio, bank, reg_rdata);
   198		addr_w = bank_reg(gpio, bank, reg_val);
   199	
   200		reg = ioread32(addr_r);
   201	
   202		if (val)
   203			reg |= GPIO_BIT(offset);
   204		else
   205			reg &= ~GPIO_BIT(offset);
   206	
   207		iowrite32(reg, addr_w);
   208	
   209		return 0;
   210	}
   211	
   212	static void aspeed_sgpio_set(struct gpio_chip *gc, unsigned int offset, int val)
   213	{
   214		struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
   215		unsigned long flags;
   216	
   217		spin_lock_irqsave(&gpio->lock, flags);
   218	
   219		sgpio_set_value(gc, offset, val);
   220	
   221		spin_unlock_irqrestore(&gpio->lock, flags);
   222	}
   223	
   224	static int aspeed_sgpio_dir_in(struct gpio_chip *gc, unsigned int offset)
   225	{
   226		return aspeed_sgpio_is_input(offset) ? 0 : -EINVAL;
   227	}
   228	
   229	static int aspeed_sgpio_dir_out(struct gpio_chip *gc, unsigned int offset, int val)
   230	{
   231		struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
   232		unsigned long flags;
 > 233		int rc;
   234	
   235		/* No special action is required for setting the direction; we'll
   236		 * error-out in sgpio_set_value if this isn't an output GPIO */
   237	
   238		spin_lock_irqsave(&gpio->lock, flags);
   239		rc = sgpio_set_value(gc, offset, val);
   240		spin_unlock_irqrestore(&gpio->lock, flags);
   241	
   242		return 0;
   243	}
   244	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 73535 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200716/0386f5c3/attachment-0001.gz>

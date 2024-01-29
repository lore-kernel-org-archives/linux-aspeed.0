From: kernel test robot <lkp@intel.com>
Date: Tue, 30 Jan 2024 00:02:16 +0800
Subject: [PATCH v13 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
In-Reply-To: <20240124060705.1342461-4-billy_tsai@aspeedtech.com>
References: <20240124060705.1342461-4-billy_tsai@aspeedtech.com>
Message-ID: <202401292303.6SVAncvn-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.8-rc2 next-20240129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-hwmon-fan-Add-fan-binding-to-schema/20240124-141405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240124060705.1342461-4-billy_tsai%40aspeedtech.com
patch subject: [PATCH v13 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach
config: riscv-randconfig-r071-20240129 (https://download.01.org/0day-ci/archive/20240129/202401292303.6SVAncvn-lkp at intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401292303.6SVAncvn-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401292303.6SVAncvn-lkp at intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/aspeed-g6-pwm-tach.c:496:2: error: implicit declaration of function 'of_platform_populate' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           of_platform_populate(dev->of_node, NULL, NULL, dev);
           ^
   1 error generated.


vim +/of_platform_populate +496 drivers/hwmon/aspeed-g6-pwm-tach.c

   446	
   447	static int aspeed_pwm_tach_probe(struct platform_device *pdev)
   448	{
   449		struct device *dev = &pdev->dev, *hwmon;
   450		int ret;
   451		struct device_node *child;
   452		struct aspeed_pwm_tach_data *priv;
   453	
   454		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   455		if (!priv)
   456			return -ENOMEM;
   457		priv->dev = dev;
   458		priv->base = devm_platform_ioremap_resource(pdev, 0);
   459		if (IS_ERR(priv->base))
   460			return PTR_ERR(priv->base);
   461	
   462		priv->clk = devm_clk_get_enabled(dev, NULL);
   463		if (IS_ERR(priv->clk))
   464			return dev_err_probe(dev, PTR_ERR(priv->clk),
   465					     "Couldn't get clock\n");
   466		priv->clk_rate = clk_get_rate(priv->clk);
   467		priv->reset = devm_reset_control_get_exclusive(dev, NULL);
   468		if (IS_ERR(priv->reset))
   469			return dev_err_probe(dev, PTR_ERR(priv->reset),
   470					     "Couldn't get reset control\n");
   471	
   472		ret = reset_control_deassert(priv->reset);
   473		if (ret)
   474			return dev_err_probe(dev, ret,
   475					     "Couldn't deassert reset control\n");
   476	
   477		priv->chip.dev = dev;
   478		priv->chip.ops = &aspeed_pwm_ops;
   479		priv->chip.npwm = PWM_ASPEED_NR_PWMS;
   480	
   481		ret = devm_pwmchip_add(dev, &priv->chip);
   482		if (ret < 0) {
   483			reset_control_assert(priv->reset);
   484			return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
   485		}
   486	
   487		for_each_child_of_node(dev->of_node, child) {
   488			ret = aspeed_tach_create_fan(dev, child, priv);
   489			if (ret < 0) {
   490				of_node_put(child);
   491				dev_warn(dev, "Failed to create fan %d", ret);
   492				return 0;
   493			}
   494		}
   495	
 > 496		of_platform_populate(dev->of_node, NULL, NULL, dev);
   497	
   498		hwmon = devm_hwmon_device_register_with_info(dev, "aspeed_tach", priv,
   499							     &aspeed_tach_chip_info, NULL);
   500		ret = PTR_ERR_OR_ZERO(hwmon);
   501		if (ret) {
   502			reset_control_assert(priv->reset);
   503			return dev_err_probe(dev, ret,
   504					     "Failed to register hwmon device\n");
   505		}
   506	
   507		return 0;
   508	}
   509	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

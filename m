From: kbuild test robot <lkp@intel.com>
Date: Sat, 22 Sep 2018 14:58:40 +0800
Subject: [PATCH v3] i2c: aspeed: fix invalid clock parameters for very
 large divisors
In-Reply-To: <20180921223446.82685-1-brendanhiggins@google.com>
References: <20180921223446.82685-1-brendanhiggins@google.com>
Message-ID: <201809221423.ZqIJEhvq%fengguang.wu@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Brendan,

I love your patch! Yet something to improve:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.19-rc4 next-20180921]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Brendan-Higgins/i2c-aspeed-fix-invalid-clock-parameters-for-very-large-divisors/20180922-134643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_probe_bus':
>> drivers/i2c/busses/i2c-aspeed.c:920:24: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
      bus->get_clk_reg_val = (u32 (*)(u32))match->data;
                           ^
   cc1: some warnings being treated as errors

vim +920 drivers/i2c/busses/i2c-aspeed.c

87b59ff8d Brendan Higgins 2017-07-28  875  
f327c686d Brendan Higgins 2017-06-20  876  static int aspeed_i2c_probe_bus(struct platform_device *pdev)
f327c686d Brendan Higgins 2017-06-20  877  {
87b59ff8d Brendan Higgins 2017-07-28  878  	const struct of_device_id *match;
f327c686d Brendan Higgins 2017-06-20  879  	struct aspeed_i2c_bus *bus;
f327c686d Brendan Higgins 2017-06-20  880  	struct clk *parent_clk;
f327c686d Brendan Higgins 2017-06-20  881  	struct resource *res;
f327c686d Brendan Higgins 2017-06-20  882  	int irq, ret;
f327c686d Brendan Higgins 2017-06-20  883  
f327c686d Brendan Higgins 2017-06-20  884  	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
f327c686d Brendan Higgins 2017-06-20  885  	if (!bus)
f327c686d Brendan Higgins 2017-06-20  886  		return -ENOMEM;
f327c686d Brendan Higgins 2017-06-20  887  
f327c686d Brendan Higgins 2017-06-20  888  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
f327c686d Brendan Higgins 2017-06-20  889  	bus->base = devm_ioremap_resource(&pdev->dev, res);
f327c686d Brendan Higgins 2017-06-20  890  	if (IS_ERR(bus->base))
f327c686d Brendan Higgins 2017-06-20  891  		return PTR_ERR(bus->base);
f327c686d Brendan Higgins 2017-06-20  892  
f327c686d Brendan Higgins 2017-06-20  893  	parent_clk = devm_clk_get(&pdev->dev, NULL);
f327c686d Brendan Higgins 2017-06-20  894  	if (IS_ERR(parent_clk))
f327c686d Brendan Higgins 2017-06-20  895  		return PTR_ERR(parent_clk);
f327c686d Brendan Higgins 2017-06-20  896  	bus->parent_clk_frequency = clk_get_rate(parent_clk);
f327c686d Brendan Higgins 2017-06-20  897  	/* We just need the clock rate, we don't actually use the clk object. */
f327c686d Brendan Higgins 2017-06-20  898  	devm_clk_put(&pdev->dev, parent_clk);
f327c686d Brendan Higgins 2017-06-20  899  
edd20e95b Joel Stanley    2017-11-01  900  	bus->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
edd20e95b Joel Stanley    2017-11-01  901  	if (IS_ERR(bus->rst)) {
edd20e95b Joel Stanley    2017-11-01  902  		dev_err(&pdev->dev,
6bc33c519 Jae Hyun Yoo    2018-07-02  903  			"missing or invalid reset controller device tree entry\n");
edd20e95b Joel Stanley    2017-11-01  904  		return PTR_ERR(bus->rst);
edd20e95b Joel Stanley    2017-11-01  905  	}
edd20e95b Joel Stanley    2017-11-01  906  	reset_control_deassert(bus->rst);
edd20e95b Joel Stanley    2017-11-01  907  
f327c686d Brendan Higgins 2017-06-20  908  	ret = of_property_read_u32(pdev->dev.of_node,
f327c686d Brendan Higgins 2017-06-20  909  				   "bus-frequency", &bus->bus_frequency);
f327c686d Brendan Higgins 2017-06-20  910  	if (ret < 0) {
f327c686d Brendan Higgins 2017-06-20  911  		dev_err(&pdev->dev,
f327c686d Brendan Higgins 2017-06-20  912  			"Could not read bus-frequency property\n");
f327c686d Brendan Higgins 2017-06-20  913  		bus->bus_frequency = 100000;
f327c686d Brendan Higgins 2017-06-20  914  	}
f327c686d Brendan Higgins 2017-06-20  915  
87b59ff8d Brendan Higgins 2017-07-28  916  	match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);
87b59ff8d Brendan Higgins 2017-07-28  917  	if (!match)
87b59ff8d Brendan Higgins 2017-07-28  918  		bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
87b59ff8d Brendan Higgins 2017-07-28  919  	else
5799c4b2f Jae Hyun Yoo    2018-07-24 @920  		bus->get_clk_reg_val = (u32 (*)(u32))match->data;
87b59ff8d Brendan Higgins 2017-07-28  921  
f327c686d Brendan Higgins 2017-06-20  922  	/* Initialize the I2C adapter */
f327c686d Brendan Higgins 2017-06-20  923  	spin_lock_init(&bus->lock);
f327c686d Brendan Higgins 2017-06-20  924  	init_completion(&bus->cmd_complete);
f327c686d Brendan Higgins 2017-06-20  925  	bus->adap.owner = THIS_MODULE;
f327c686d Brendan Higgins 2017-06-20  926  	bus->adap.retries = 0;
f327c686d Brendan Higgins 2017-06-20  927  	bus->adap.timeout = 5 * HZ;
f327c686d Brendan Higgins 2017-06-20  928  	bus->adap.algo = &aspeed_i2c_algo;
f327c686d Brendan Higgins 2017-06-20  929  	bus->adap.dev.parent = &pdev->dev;
f327c686d Brendan Higgins 2017-06-20  930  	bus->adap.dev.of_node = pdev->dev.of_node;
f327c686d Brendan Higgins 2017-06-20  931  	strlcpy(bus->adap.name, pdev->name, sizeof(bus->adap.name));
f327c686d Brendan Higgins 2017-06-20  932  	i2c_set_adapdata(&bus->adap, bus);
f327c686d Brendan Higgins 2017-06-20  933  
f327c686d Brendan Higgins 2017-06-20  934  	bus->dev = &pdev->dev;
f327c686d Brendan Higgins 2017-06-20  935  
f327c686d Brendan Higgins 2017-06-20  936  	/* Clean up any left over interrupt state. */
f327c686d Brendan Higgins 2017-06-20  937  	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);
f327c686d Brendan Higgins 2017-06-20  938  	writel(0xffffffff, bus->base + ASPEED_I2C_INTR_STS_REG);
f327c686d Brendan Higgins 2017-06-20  939  	/*
f327c686d Brendan Higgins 2017-06-20  940  	 * bus.lock does not need to be held because the interrupt handler has
f327c686d Brendan Higgins 2017-06-20  941  	 * not been enabled yet.
f327c686d Brendan Higgins 2017-06-20  942  	 */
f327c686d Brendan Higgins 2017-06-20  943  	ret = aspeed_i2c_init(bus, pdev);
f327c686d Brendan Higgins 2017-06-20  944  	if (ret < 0)
f327c686d Brendan Higgins 2017-06-20  945  		return ret;
f327c686d Brendan Higgins 2017-06-20  946  
f327c686d Brendan Higgins 2017-06-20  947  	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
f327c686d Brendan Higgins 2017-06-20  948  	ret = devm_request_irq(&pdev->dev, irq, aspeed_i2c_bus_irq,
f327c686d Brendan Higgins 2017-06-20  949  			       0, dev_name(&pdev->dev), bus);
f327c686d Brendan Higgins 2017-06-20  950  	if (ret < 0)
f327c686d Brendan Higgins 2017-06-20  951  		return ret;
f327c686d Brendan Higgins 2017-06-20  952  
f327c686d Brendan Higgins 2017-06-20  953  	ret = i2c_add_adapter(&bus->adap);
f327c686d Brendan Higgins 2017-06-20  954  	if (ret < 0)
f327c686d Brendan Higgins 2017-06-20  955  		return ret;
f327c686d Brendan Higgins 2017-06-20  956  
f327c686d Brendan Higgins 2017-06-20  957  	platform_set_drvdata(pdev, bus);
f327c686d Brendan Higgins 2017-06-20  958  
f327c686d Brendan Higgins 2017-06-20  959  	dev_info(bus->dev, "i2c bus %d registered, irq %d\n",
f327c686d Brendan Higgins 2017-06-20  960  		 bus->adap.nr, irq);
f327c686d Brendan Higgins 2017-06-20  961  
f327c686d Brendan Higgins 2017-06-20  962  	return 0;
f327c686d Brendan Higgins 2017-06-20  963  }
f327c686d Brendan Higgins 2017-06-20  964  

:::::: The code at line 920 was first introduced by commit
:::::: 5799c4b2f1dbc0166d9b1d94443deaafc6e7a070 i2c: aspeed: Add an explicit type casting for *get_clk_reg_val

:::::: TO: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
:::::: CC: Wolfram Sang <wsa@the-dreams.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 67088 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20180922/44a1c0f8/attachment-0001.gz>

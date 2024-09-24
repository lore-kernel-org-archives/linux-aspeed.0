From: kernel test robot <lkp@intel.com>
Date: Tue, 24 Sep 2024 10:53:52 +0800
Subject: [PATCH v5 3/6] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <20240923100611.1597113-4-billy_tsai@aspeedtech.com>
References: <20240923100611.1597113-4-billy_tsai@aspeedtech.com>
Message-ID: <202409241029.XEkME4VI-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.11 next-20240923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-gpio-aspeed-ast2400-gpio-Support-ast2700/20240923-180936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240923100611.1597113-4-billy_tsai%40aspeedtech.com
patch subject: [PATCH v5 3/6] gpio: aspeed: Create llops to handle hardware access
config: alpha-randconfig-r131-20240924 (https://download.01.org/0day-ci/archive/20240924/202409241029.XEkME4VI-lkp at intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240924/202409241029.XEkME4VI-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409241029.XEkME4VI-lkp at intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpio/gpio-aspeed.c:1208:54: sparse: sparse: Using plain integer as NULL pointer

vim +1208 drivers/gpio/gpio-aspeed.c

  1183	
  1184	static int __init aspeed_gpio_probe(struct platform_device *pdev)
  1185	{
  1186		const struct of_device_id *gpio_id;
  1187		struct gpio_irq_chip *girq;
  1188		struct aspeed_gpio *gpio;
  1189		int rc, irq, i, banks, err;
  1190		u32 ngpio;
  1191	
  1192		gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
  1193		if (!gpio)
  1194			return -ENOMEM;
  1195	
  1196		gpio->base = devm_platform_ioremap_resource(pdev, 0);
  1197		if (IS_ERR(gpio->base))
  1198			return PTR_ERR(gpio->base);
  1199	
  1200		gpio->dev = &pdev->dev;
  1201	
  1202		raw_spin_lock_init(&gpio->lock);
  1203	
  1204		gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
  1205		if (!gpio_id)
  1206			return -EINVAL;
  1207	
> 1208		gpio->clk = devm_clk_get_enabled(&pdev->dev, 0);
  1209		if (IS_ERR(gpio->clk)) {
  1210			dev_warn(&pdev->dev,
  1211					"Failed to get clock from devicetree, debouncing disabled\n");
  1212			gpio->clk = NULL;
  1213		}
  1214	
  1215		gpio->config = gpio_id->data;
  1216	
  1217		if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->reg_bit_get ||
  1218		    !gpio->config->llops->reg_bank_get)
  1219			return -EINVAL;
  1220	
  1221		gpio->chip.parent = &pdev->dev;
  1222		err = of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpio);
  1223		gpio->chip.ngpio = (u16) ngpio;
  1224		if (err)
  1225			gpio->chip.ngpio = gpio->config->nr_gpios;
  1226		gpio->chip.direction_input = aspeed_gpio_dir_in;
  1227		gpio->chip.direction_output = aspeed_gpio_dir_out;
  1228		gpio->chip.get_direction = aspeed_gpio_get_direction;
  1229		gpio->chip.request = aspeed_gpio_request;
  1230		gpio->chip.free = aspeed_gpio_free;
  1231		gpio->chip.get = aspeed_gpio_get;
  1232		gpio->chip.set = aspeed_gpio_set;
  1233		gpio->chip.set_config = aspeed_gpio_set_config;
  1234		gpio->chip.label = dev_name(&pdev->dev);
  1235		gpio->chip.base = -1;
  1236	
  1237		if (gpio->config->require_dcache) {
  1238			/* Allocate a cache of the output registers */
  1239			banks = DIV_ROUND_UP(gpio->chip.ngpio, 32);
  1240			gpio->dcache = devm_kcalloc(&pdev->dev, banks, sizeof(u32), GFP_KERNEL);
  1241			if (!gpio->dcache)
  1242				return -ENOMEM;
  1243			/*
  1244			 * Populate it with initial values read from the HW
  1245			 */
  1246			for (i = 0; i < banks; i++)
  1247				gpio->dcache[i] =
  1248					gpio->config->llops->reg_bank_get(gpio, (i << 5), reg_rdata);
  1249		}
  1250	
  1251		if (gpio->config->llops->privilege_init)
  1252			gpio->config->llops->privilege_init(gpio);
  1253	
  1254		/* Set up an irqchip */
  1255		irq = platform_get_irq(pdev, 0);
  1256		if (irq < 0)
  1257			return irq;
  1258		gpio->irq = irq;
  1259		girq = &gpio->chip.irq;
  1260		gpio_irq_chip_set_chip(girq, &aspeed_gpio_irq_chip);
  1261	
  1262		girq->parent_handler = aspeed_gpio_irq_handler;
  1263		girq->num_parents = 1;
  1264		girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents), GFP_KERNEL);
  1265		if (!girq->parents)
  1266			return -ENOMEM;
  1267		girq->parents[0] = gpio->irq;
  1268		girq->default_type = IRQ_TYPE_NONE;
  1269		girq->handler = handle_bad_irq;
  1270		girq->init_valid_mask = aspeed_init_irq_valid_mask;
  1271	
  1272		gpio->offset_timer =
  1273			devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
  1274		if (!gpio->offset_timer)
  1275			return -ENOMEM;
  1276	
  1277		rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
  1278		if (rc < 0)
  1279			return rc;
  1280	
  1281		return 0;
  1282	}
  1283	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

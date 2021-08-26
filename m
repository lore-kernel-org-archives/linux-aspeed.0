From: kernel test robot <lkp@intel.com>
Date: Fri, 27 Aug 2021 04:05:57 +0800
Subject: [PATCH v3 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
References: <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
Message-ID: <202108270339.2LOAeemT-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chia-Wei,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm/for-next keystone/next soc/for-next rockchip/for-next arm64/for-next/core linus/master joel-aspeed/for-next v5.14-rc7 next-20210826]
[cannot apply to xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chia-Wei-Wang/arm-aspeed-Add-eSPI-support/20210826-141737
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r025-20210826 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project ea08c4cd1c0869ec5024a8bb3f5cdf06ab03ae83)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/2980a1777c50754fe145f2e73ded8739931c0712
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chia-Wei-Wang/arm-aspeed-Add-eSPI-support/20210826-141737
        git checkout 2980a1777c50754fe145f2e73ded8739931c0712
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/soc/aspeed/aspeed-espi-ctrl.c:22:
   drivers/soc/aspeed/aspeed-espi-perif.h:446:8: error: incompatible pointer types passing 'phys_addr_t *' (aka 'unsigned long long *') to parameter of type 'u32 *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
                                             &espi_perif->mcyc_saddr);
                                             ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h:1249:17: note: passing argument to parameter 'out_value' here
                                          u32 *out_value)
                                               ^
>> drivers/soc/aspeed/aspeed-espi-ctrl.c:98:23: warning: cast to smaller integer type 'uint32_t' (aka 'unsigned int') from 'const void *' [-Wvoid-pointer-to-int-cast]
           espi_ctrl->version = (uint32_t)of_device_get_match_data(dev);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +98 drivers/soc/aspeed/aspeed-espi-ctrl.c

    87	
    88	static int aspeed_espi_ctrl_probe(struct platform_device *pdev)
    89	{
    90		int rc = 0;
    91		struct aspeed_espi_ctrl *espi_ctrl;
    92		struct device *dev = &pdev->dev;
    93	
    94		espi_ctrl = devm_kzalloc(dev, sizeof(*espi_ctrl), GFP_KERNEL);
    95		if (!espi_ctrl)
    96			return -ENOMEM;
    97	
  > 98		espi_ctrl->version = (uint32_t)of_device_get_match_data(dev);
    99	
   100		espi_ctrl->map = syscon_node_to_regmap(dev->parent->of_node);
   101		if (IS_ERR(espi_ctrl->map)) {
   102			dev_err(dev, "cannot get remap\n");
   103			return -ENODEV;
   104		}
   105	
   106		espi_ctrl->irq = platform_get_irq(pdev, 0);
   107		if (espi_ctrl->irq < 0)
   108			return espi_ctrl->irq;
   109	
   110		espi_ctrl->clk = devm_clk_get(dev, NULL);
   111		if (IS_ERR(espi_ctrl->clk)) {
   112			dev_err(dev, "cannot get clock\n");
   113			return -ENODEV;
   114		}
   115	
   116		rc = clk_prepare_enable(espi_ctrl->clk);
   117		if (rc) {
   118			dev_err(dev, "cannot enable clock\n");
   119			return rc;
   120		}
   121	
   122		espi_ctrl->perif = aspeed_espi_perif_alloc(dev, espi_ctrl);
   123		if (IS_ERR(espi_ctrl->perif)) {
   124			dev_err(dev, "failed to allocate peripheral channel\n");
   125			return PTR_ERR(espi_ctrl->perif);
   126		}
   127	
   128		espi_ctrl->vw = aspeed_espi_vw_alloc(dev, espi_ctrl);
   129		if (IS_ERR(espi_ctrl->vw)) {
   130			dev_err(dev, "failed to allocate virtual wire channel\n");
   131			return PTR_ERR(espi_ctrl->vw);
   132		}
   133	
   134		espi_ctrl->oob = aspeed_espi_oob_alloc(dev, espi_ctrl);
   135		if (IS_ERR(espi_ctrl->oob)) {
   136			dev_err(dev, "failed to allocate out-of-band channel\n");
   137			return PTR_ERR(espi_ctrl->oob);
   138		}
   139	
   140		espi_ctrl->flash = aspeed_espi_flash_alloc(dev, espi_ctrl);
   141		if (rc) {
   142			dev_err(dev, "failed to allocate flash channel\n");
   143			return PTR_ERR(espi_ctrl->flash);
   144		}
   145	
   146		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T0, 0x0);
   147		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T1, 0x0);
   148		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_EN, 0xffffffff);
   149	
   150		regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_T0, 0x1);
   151		regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_EN, 0x1);
   152	
   153		rc = devm_request_irq(dev, espi_ctrl->irq,
   154				      aspeed_espi_ctrl_isr,
   155				      0, DEVICE_NAME, espi_ctrl);
   156		if (rc) {
   157			dev_err(dev, "failed to request IRQ\n");
   158			return rc;
   159		}
   160	
   161		regmap_update_bits(espi_ctrl->map, ESPI_INT_EN,
   162				   ESPI_INT_EN_HW_RST_DEASSERT,
   163				   ESPI_INT_EN_HW_RST_DEASSERT);
   164	
   165		dev_set_drvdata(dev, espi_ctrl);
   166	
   167		dev_info(dev, "module loaded\n");
   168	
   169		return 0;
   170	}
   171	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35430 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210827/0435282b/attachment-0001.gz>

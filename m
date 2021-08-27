From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 27 Aug 2021 03:52:03 +0000
Subject: [PATCH v3 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <202108270732.OvBQ4K3D-lkp@intel.com>
References: <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
 <202108270732.OvBQ4K3D-lkp@intel.com>
Message-ID: <HK0PR06MB377927BDCA9CC79B598251B291C89@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aspeed 5th and 6th generation SoCs are based on the ARM 32-bits architecture.
Should we follow the report to make the driver 64-bits compatible?
Or revise the driver to use more specific data types?

Thanks.

Chiawei

> From: kernel test robot <lkp@intel.com>
> Sent: Friday, August 27, 2021 7:30 AM
> 
> Hi Chia-Wei,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next] [also build test ERROR on
> arm/for-next keystone/next soc/for-next rockchip/for-next
> arm64/for-next/core linus/master joel-aspeed/for-next v5.14-rc7
> next-20210826] [cannot apply to xlnx/master] [If your patch is applied to the
> wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/Chia-Wei-Wang/arm-aspeed-Add-e
> SPI-support/20210826-141737
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm64-randconfig-r002-20210826 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0 reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://github.com/0day-ci/linux/commit/2980a1777c50754fe145f2e73ded873
> 9931c0712
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review
> Chia-Wei-Wang/arm-aspeed-Add-eSPI-support/20210826-141737
>         git checkout 2980a1777c50754fe145f2e73ded8739931c0712
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0
> make.cross ARCH=arm64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/soc/aspeed/aspeed-espi-ctrl.c:22:
>    drivers/soc/aspeed/aspeed-espi-perif.h: In function
> 'aspeed_espi_perif_alloc':
> >> drivers/soc/aspeed/aspeed-espi-perif.h:446:43: error: passing
> >> argument 3 of 'of_property_read_u32' from incompatible pointer type
> >> [-Werror=incompatible-pointer-types]
>      446 |
> &espi_perif->mcyc_saddr);
>          |
> ^~~~~~~~~~~~~~~~~~~~~~~
>          |                                           |
>          |                                           phys_addr_t
> * {aka long long unsigned int *}
>    In file included from include/linux/of_device.h:9,
>                     from drivers/soc/aspeed/aspeed-espi-ctrl.c:9:
>    include/linux/of.h:1249:45: note: expected 'u32 *' {aka 'unsigned int *'} but
> argument is of type 'phys_addr_t *' {aka 'long long unsigned int *'}
>     1249 |                                        u32 *out_value)
>          |                                        ~~~~~^~~~~~~~~
>    drivers/soc/aspeed/aspeed-espi-ctrl.c: In function
> 'aspeed_espi_ctrl_probe':
>    drivers/soc/aspeed/aspeed-espi-ctrl.c:98:30: warning: cast from pointer to
> integer of different size [-Wpointer-to-int-cast]
>       98 |         espi_ctrl->version =
> (uint32_t)of_device_get_match_data(dev);
>          |                              ^
>    cc1: some warnings being treated as errors
> 
> 
> vim +/of_property_read_u32 +446 drivers/soc/aspeed/aspeed-espi-perif.h
> 
>    422
>    423	static void *aspeed_espi_perif_alloc(struct device *dev, struct
> aspeed_espi_ctrl *espi_ctrl)
>    424	{
>    425		int rc;
>    426		struct aspeed_espi_perif *espi_perif;
>    427		struct aspeed_espi_perif_dma *dma;
>    428
>    429		espi_perif = devm_kzalloc(dev, sizeof(*espi_perif),
> GFP_KERNEL);
>    430		if (!espi_perif)
>    431			return ERR_PTR(-ENOMEM);
>    432
>    433		espi_perif->ctrl = espi_ctrl;
>    434
>    435		init_waitqueue_head(&espi_perif->wq);
>    436
>    437		spin_lock_init(&espi_perif->lock);
>    438
>    439		mutex_init(&espi_perif->pc_rx_mtx);
>    440		mutex_init(&espi_perif->pc_tx_mtx);
>    441		mutex_init(&espi_perif->np_tx_mtx);
>    442
>    443		espi_perif->mcyc_enable =
> of_property_read_bool(dev->of_node, "perif,memcyc-enable");
>    444		if (espi_perif->mcyc_enable) {
>    445			rc = of_property_read_u32(dev->of_node,
> "perif,memcyc-src-addr",
>  > 446						  &espi_perif->mcyc_saddr);
>    447			if (rc) {
>    448				dev_err(dev, "cannot get Host source address for
> memory cycle\n");
>    449				return ERR_PTR(-ENODEV);
>    450			}
>    451
>    452			rc = of_property_read_u32(dev->of_node,
> "perif,memcyc-size",
>    453						  &espi_perif->mcyc_size);
>    454			if (rc) {
>    455				dev_err(dev, "cannot get size for memory cycle\n");
>    456				return ERR_PTR(-ENODEV);
>    457			}
>    458
>    459			if (espi_perif->mcyc_size < PERIF_MEMCYC_SIZE_MIN)
>    460				espi_perif->mcyc_size = PERIF_MEMCYC_SIZE_MIN;
>    461			else
>    462				espi_perif->mcyc_size =
> roundup_pow_of_two(espi_perif->mcyc_size);
>    463
>    464			espi_perif->mcyc_mask = ~(espi_perif->mcyc_size - 1);
>    465			espi_perif->mcyc_virt = dma_alloc_coherent(dev,
> espi_perif->mcyc_size,
>    466								   &espi_perif->mcyc_taddr,
> GFP_KERNEL);
>    467			if (!espi_perif->mcyc_virt) {
>    468				dev_err(dev, "cannot allocate memory cycle
> region\n");
>    469				return ERR_PTR(-ENOMEM);
>    470			}
>    471		}
>    472
>    473		if (of_property_read_bool(dev->of_node, "perif,dma-mode")) {
>    474			dma = &espi_perif->dma;
>    475
>    476			dma->pc_tx_virt = dma_alloc_coherent(dev, PAGE_SIZE,
>    477							     &dma->pc_tx_addr,
> GFP_KERNEL);
>    478			if (!dma->pc_tx_virt) {
>    479				dev_err(dev, "cannot allocate posted TX DMA
> buffer\n");
>    480				return ERR_PTR(-ENOMEM);
>    481			}
>    482
>    483			dma->pc_rx_virt = dma_alloc_coherent(dev, PAGE_SIZE,
>    484							     &dma->pc_rx_addr,
> GFP_KERNEL);
>    485			if (!dma->pc_rx_virt) {
>    486				dev_err(dev, "cannot allocate posted RX DMA
> buffer\n");
>    487				return ERR_PTR(-ENOMEM);
>    488			}
>    489
>    490			dma->np_tx_virt = dma_alloc_coherent(dev, PAGE_SIZE,
>    491					&dma->np_tx_addr, GFP_KERNEL);
>    492			if (!dma->np_tx_virt) {
>    493				dev_err(dev, "cannot allocate non-posted TX DMA
> buffer\n");
>    494				return ERR_PTR(-ENOMEM);
>    495			}
>    496
>    497			espi_perif->dma_mode = 1;
>    498		}
>    499
>    500		espi_perif->mdev.parent = dev;
>    501		espi_perif->mdev.minor = MISC_DYNAMIC_MINOR;
>    502		espi_perif->mdev.name = devm_kasprintf(dev, GFP_KERNEL,
> "%s", PERIF_MDEV_NAME);
>    503		espi_perif->mdev.fops = &aspeed_espi_perif_fops;
>    504		rc = misc_register(&espi_perif->mdev);
>    505		if (rc) {
>    506			dev_err(dev, "cannot register device\n");
>    507			return ERR_PTR(rc);
>    508		}
>    509
>    510		aspeed_espi_perif_enable(espi_perif);
>    511
>    512		return espi_perif;
>    513	}
>    514
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Mar 2024 10:49:20 +0100
Subject: [PATCH v2 1/4] Add eSPI device driver (flash channel)
In-Reply-To: <20240319093405.39833-2-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-2-manojkiran.eda@gmail.com>
Message-ID: <fdb557a6-f505-487b-899b-3b794f9dbaf0@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19/03/2024 10:34, Manojkiran Eda wrote:
> This patch adds the driver support for the eSPI controller of
> Aspeed 5/6th generation SoCs. This controller is a slave device
> communicating with a master over Enhanced Serial Peripheral
> Interface (eSPI).
> 
> eSPI supports 4 channels, namely peripheral, virtual wire,
> out-of-band, and flash, and operates at max frequency of 66MHz.
> 
> But at the moment, this patch set only supports the mafs mode
> (master attached flash sharing mode) in the flash channel.
> 
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
>  drivers/soc/aspeed/Kconfig                  |  38 ++
>  drivers/soc/aspeed/Makefile                 |   2 +
>  drivers/soc/aspeed/aspeed-espi-ctrl.c       | 197 +++++++++
>  drivers/soc/aspeed/aspeed-espi-ctrl.h       | 169 +++++++
>  drivers/soc/aspeed/aspeed-espi-flash-mafs.c | 467 ++++++++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-flash.h      |  71 +++
>  6 files changed, 944 insertions(+)
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.h
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-flash-mafs.c
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.h
> 
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> index f579ee0b5afa..c300ee8fe33a 100644
> --- a/drivers/soc/aspeed/Kconfig
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -52,6 +52,44 @@ config ASPEED_SOCINFO
>  	help
>  	  Say yes to support decoding of ASPEED BMC information.
>  
> +menu "ASPEED eSPI Support"
> +
> +config ASPEED_ESPI
> +	bool "ASPEED eSPI slave driver"

Why this is not tristate?

> +	select REGMAP
> +	select MFD_SYSCON
> +	depends on ASPEED_ESPI_FLASH
> +	default n
> +	help
> +	  Enable driver support for the Aspeed eSPI engine. The eSPI engine
> +	  plays as a slave device in BMC to communicate with the Host over
> +	  the eSPI interface.
> +
> +menu "ASPEED eSPI Flash channel support"

You have way too many menus...

> +
> +config  ASPEED_ESPI_FLASH

This is not used, drop.

> +	bool "ASPEED eSPI flash channel support"
> +	default n
> +	depends on ASPEED_ESPI_FLASH_MAFS
> +	select ASPEED_ESPI
> +	help
> +	  Enable eSPI flash channel support.
> +
> +menu "ASPEED eSPI flash modes"
> +
> +config ASPEED_ESPI_FLASH_MAFS
> +	bool "Master attached flash sharing (MAFS) support in eSPI"

Why this is not tristate?


> +	default n
> +	select ASPEED_ESPI_FLASH
> +	help
> +	  Select this option if you have a Master attached flash connected to
> +	  the eSPI controller.
> +
> +endmenu # eSPI Flash Modes
> +endmenu # eSPI Flash Channel support
> +endmenu # eSPI Support
> +
> +
>  endmenu
>  
>  endif
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> index b35d74592964..cecbba700071 100644
> --- a/drivers/soc/aspeed/Makefile
> +++ b/drivers/soc/aspeed/Makefile
> @@ -4,3 +4,5 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
>  obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
>  obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
> +obj-$(CONFIG_ASPEED_ESPI)               += aspeed-espi-ctrl.o
> +obj-$(CONFIG_ASPEED_ESPI_FLASH_MAFS)    += aspeed-espi-flash-mafs.o

Why did you put spi drivers in soc? SPI drivers usually go to spi, don't
they?



> diff --git a/drivers/soc/aspeed/aspeed-espi-ctrl.c b/drivers/soc/aspeed/aspeed-espi-ctrl.c
> new file mode 100644
> index 000000000000..7e2b86849fd0
> --- /dev/null
> +++ b/drivers/soc/aspeed/aspeed-espi-ctrl.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Aspeed Technology Inc.
> + */
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
> +
> +#include "aspeed-espi-ctrl.h"
> +#include "aspeed-espi-flash.h"
> +
> +/**

No need for kerneldoc for private functions.

> + * aspeed_espi_ctrl_isr - function to handle various interrupts
> + * @irq: interrupt line
> + * @arg: pointer to access device registers
> + *
> + * Returns IRQ_HANDLED
> + */
> +static irqreturn_t aspeed_espi_ctrl_isr(int irq, void *arg)
> +{
> +	uint32_t sts;
> +	struct aspeed_espi_ctrl *espi_ctrl = (struct aspeed_espi_ctrl *)arg;
> +
> +	regmap_read(espi_ctrl->map, ESPI_INT_STS, &sts);
> +
> +	if (sts & ESPI_INT_STS_FLASH_BITS) {
> +		aspeed_espi_flash_event(sts, espi_ctrl->flash);
> +		regmap_write(espi_ctrl->map, ESPI_INT_STS,
> +			     sts & ESPI_INT_STS_FLASH_BITS);
> +	}
> +
> +	if (sts & ESPI_INT_STS_HW_RST_DEASSERT) {
> +		aspeed_espi_flash_enable(espi_ctrl->flash);
> +
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T0, 0x0);
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T1, 0x0);
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_EN, 0xffffffff);
> +
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_T0, 0x1);
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_EN, 0x1);
> +
> +		regmap_update_bits(espi_ctrl->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_HW_RST_DEASSERT,
> +				   ESPI_INT_EN_HW_RST_DEASSERT);
> +
> +		regmap_update_bits(
> +			espi_ctrl->map, ESPI_SYSEVT,
> +			ESPI_SYSEVT_SLV_BOOT_STS | ESPI_SYSEVT_SLV_BOOT_DONE,
> +			ESPI_SYSEVT_SLV_BOOT_STS | ESPI_SYSEVT_SLV_BOOT_DONE);
> +
> +		regmap_write(espi_ctrl->map, ESPI_INT_STS,
> +			     ESPI_INT_STS_HW_RST_DEASSERT);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * aspeed_espi_ctrl_probe - function to probe the platform driver
> + * @pdev: platform device
> + *
> + * Returns 0 on success, -ENOMEM on error

Drop useless kerneldoc / entire function comment. That's just probe...

> + */
> +static int aspeed_espi_ctrl_probe(struct platform_device *pdev)
> +{
> +	int rc = 0;
> +	struct aspeed_espi_ctrl *espi_ctrl;
> +	struct device *dev = &pdev->dev;
> +
> +	espi_ctrl = devm_kzalloc(dev, sizeof(*espi_ctrl), GFP_KERNEL);
> +	if (!espi_ctrl)
> +		return -ENOMEM;
> +
> +	espi_ctrl->model = of_device_get_match_data(dev);
> +
> +	espi_ctrl->map = syscon_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(espi_ctrl->map)) {
> +		dev_err(dev, "cannot get remap\n");
> +		return PTR_ERR(espi_ctrl->map);

return dev_err_probe

> +	}
> +
> +	espi_ctrl->irq = platform_get_irq(pdev, 0);
> +	if (espi_ctrl->irq < 0)
> +		return espi_ctrl->irq;
> +
> +	espi_ctrl->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(espi_ctrl->clk)) {
> +		dev_err(dev, "cannot get clock\n");
> +		return PTR_ERR(espi_ctrl->clk);

return dev_err_probe

> +	}
> +
> +	rc = clk_prepare_enable(espi_ctrl->clk);
> +	if (rc) {
> +		dev_err(dev, "cannot enable clock\n");
> +		return rc;
> +	}
> +
> +	/*
> +	 * This takes care of deferred probe , incase the mtd core
> +	 * subsystem is not probed yet.
> +	 */
> +	espi_ctrl->flash = aspeed_espi_flash_alloc(dev, espi_ctrl);
> +	if (IS_ERR(espi_ctrl->flash)) {
> +		dev_err(dev, "failed to allocate flash channel\n");
> +		pr_info("flash alloc failed with return code %ld\n",
> +			PTR_ERR(espi_ctrl->flash));

Please clean up the code. Drop.

> +		return PTR_ERR(espi_ctrl->flash);
> +	}
> +
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T0, 0x0);
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T1, 0x0);
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_EN, 0xffffffff);
> +
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_T0, 0x1);
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_EN, 0x1);
> +
> +	rc = devm_request_irq(dev, espi_ctrl->irq, aspeed_espi_ctrl_isr, 0,
> +			      DEVICE_NAME, espi_ctrl);
> +	if (rc) {
> +		dev_err(dev, "failed to request IRQ\n");
> +		return rc;
> +	}
> +
> +	// clear the interrupt enable register
> +	regmap_write(espi_ctrl->map, ESPI_INT_EN_CLR, 0x7fffffff);
> +
> +	// Disable the interrupts in all channels except flash channel
> +	regmap_update_bits(espi_ctrl->map, ESPI_INT_EN,
> +			   ESPI_INT_EN_FLASH_BITS | ESPI_INT_EN_HW_RST_DEASSERT,
> +			   ESPI_INT_EN_FLASH_BITS |
> +				   ESPI_INT_STS_HW_RST_DEASSERT);

Why do you first request interrupt and then disable them? What if it
fires earlier?

> +
> +	dev_set_drvdata(dev, espi_ctrl);
> +
> +	dev_info(dev, "module loaded\n");

No, drop such simple function success statements.
> +
> +	return 0;
> +}
> +
> +/**
> + * aspeed_espi_ctrl_remove - Release the driver
> + * @pdev: the platform device
> + *
> + * Returns 0
> + */

Drop entire comment, useless.


...

> +
> +void *aspeed_espi_flash_alloc(struct device *dev,
> +			      struct aspeed_espi_ctrl *espi_ctrl)
> +{
> +	int ret, index;
> +	struct aspeed_espi_flash_dma *dma;
> +	struct mtd_info *mtd;
> +	struct aspeed_espi_flash *espi_flash;
> +	struct resource res;
> +	u32 reg;
> +
> +	espi_flash =
> +		devm_kzalloc(dev, sizeof(struct aspeed_espi_flash), GFP_KERNEL);

sizeof(*)

> +	if (!espi_flash)
> +		return ERR_PTR(-ENOMEM);
> +
> +	espi_flash->ctrl = espi_ctrl;
> +
> +	/* Bus lock */
> +	mutex_init(&espi_flash->lock);
> +
> +	init_waitqueue_head(&espi_flash->wq);
> +
> +	spin_lock_init(&espi_flash->spinlock);
> +
> +	dma = &espi_flash->dma;
> +
> +	dma->tx_virt =
> +		dma_alloc_coherent(dev, PAGE_SIZE, &dma->tx_addr, GFP_KERNEL);

Wrong wrapping.

> +	if (!dma->tx_virt) {
> +		dev_err(dev, "cannot allocate DMA TX buffer\n");

Do not print anything on allocation failures.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	dma->rx_virt =
> +		dma_alloc_coherent(dev, PAGE_SIZE, &dma->rx_addr, GFP_KERNEL);
> +	if (!dma->rx_virt) {
> +		dev_err(dev, "cannot allocate DMA RX buffer\n");

Drop

> +		return ERR_PTR(-ENOMEM);
> +	}
> +	index = of_property_match_string(dev->of_node, "reg-names",
> +					 "espi_flash");
> +	ret = of_address_to_resource(dev->of_node, index, &res);

Why such unusual code? Why you cannot just map the io space?

> +	if (ret < 0) {
> +		dev_err(dev,
> +			"Could not find espi_flash resource block size in devtree\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +	reg = resource_size(&res);
> +	mtd = &espi_flash->mtd;
> +	mtd->dev.parent = dev;
> +	mtd->size = reg;
> +	mtd->flags = MTD_CAP_NORFLASH;
> +	mtd->_erase = aspeed_espi_flash_erase;
> +	mtd->_read = aspeed_espi_flash_read;
> +	mtd->_write = aspeed_espi_flash_write;
> +	mtd->type = MTD_NORFLASH;
> +	mtd->name = "espi-flash-mafs";
> +
> +	regmap_read(espi_ctrl->map, ESPI_CH3_CAP_N_CONF, &reg);
> +	reg = (reg & ESPI_CH3_CAP_N_CONF_ERASE_MASK) >>
> +	      ESPI_CH3_CAP_N_CONF_ERASE_SHIFT;
> +	espi_flash->erase_mask = reg;
> +	switch (reg) {
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_4KB:
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_4KB_64KB:
> +		mtd->erasesize = 0x1000;
> +		espi_flash->erase_mask = 1;
> +		break;
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_64KB:
> +		mtd->erasesize = 0x10000;
> +		break;
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_128KB:
> +		mtd->erasesize = 0x20000;
> +		break;
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_256KB:
> +		mtd->erasesize = 0x40000;
> +		break;
> +	default:
> +		dev_notice(dev, "Unknown erase size %x\n", reg);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	mtd->writesize = 1;
> +	mtd->owner = THIS_MODULE;
> +	mtd->priv = espi_flash;
> +
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_notice(dev, "aspeed-espi-mtd: Failed to register mtd device\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	aspeed_espi_flash_enable(espi_flash);
> +	return espi_flash;
> +}

Missing export as GPL


> +
> +void aspeed_espi_flash_free(struct device *dev,
> +			    struct aspeed_espi_flash *espi_flash)
> +{
> +	struct aspeed_espi_flash_dma *dma = &espi_flash->dma;
> +
> +	dma_free_coherent(dev, PAGE_SIZE, dma->tx_virt, dma->tx_addr);
> +	dma_free_coherent(dev, PAGE_SIZE, dma->rx_virt, dma->rx_addr);
> +
> +	mtd_device_unregister(&espi_flash->mtd);
> +}

Missing export as GPL




Best regards,
Krzysztof


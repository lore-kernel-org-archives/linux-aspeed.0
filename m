From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 29 Jul 2019 15:32:50 +0200
Subject: [PATCH 2/4] net: phy: Add mdio-aspeed
In-Reply-To: <20190729043926.32679-3-andrew@aj.id.au>
References: <20190729043926.32679-1-andrew@aj.id.au>
 <20190729043926.32679-3-andrew@aj.id.au>
Message-ID: <20190729133250.GB4110@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 29, 2019 at 02:09:24PM +0930, Andrew Jeffery wrote:
> The AST2600 design separates the MDIO controllers from the MAC, which is
> where they were placed in the AST2400 and AST2500. Further, the register
> interface is reworked again, so now we have three possible different
> interface implementations, however this driver only supports the
> interface provided by the AST2600. The AST2400 and AST2500 will continue
> to be supported by the MDIO support embedded in the FTGMAC100 driver.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/net/phy/Kconfig       |  13 +++
>  drivers/net/phy/Makefile      |   1 +
>  drivers/net/phy/mdio-aspeed.c | 159 ++++++++++++++++++++++++++++++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 drivers/net/phy/mdio-aspeed.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 20f14c5fbb7e..206d8650ee7f 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -21,6 +21,19 @@ config MDIO_BUS
>  
>  if MDIO_BUS
>  
> +config MDIO_ASPEED
> +	tristate "ASPEED MDIO bus controller"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on OF_MDIO && HAS_IOMEM
> +	help
> +	  This module provides a driver for the independent MDIO bus
> +	  controllers found in the ASPEED AST2600 SoC. This is a driver for the
> +	  third revision of the ASPEED MDIO register interface - the first two
> +	  revisions are the "old" and "new" interfaces found in the AST2400 and
> +	  AST2500, embedded in the MAC. For legacy reasons, FTGMAC100 driver
> +	  continues to drive the embedded MDIO controller for the AST2400 and
> +	  AST2500 SoCs, so say N if AST2600 support is not required.
> +
>  config MDIO_BCM_IPROC
>  	tristate "Broadcom iProc MDIO bus controller"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 839acb292c38..ba07c27e4208 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -22,6 +22,7 @@ libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
>  obj-$(CONFIG_PHYLINK)		+= phylink.o
>  obj-$(CONFIG_PHYLIB)		+= libphy.o
>  
> +obj-$(CONFIG_MDIO_ASPEED)	+= mdio-aspeed.o
>  obj-$(CONFIG_MDIO_BCM_IPROC)	+= mdio-bcm-iproc.o
>  obj-$(CONFIG_MDIO_BCM_UNIMAC)	+= mdio-bcm-unimac.o
>  obj-$(CONFIG_MDIO_BITBANG)	+= mdio-bitbang.o
> diff --git a/drivers/net/phy/mdio-aspeed.c b/drivers/net/phy/mdio-aspeed.c
> new file mode 100644
> index 000000000000..71496a9ff54a
> --- /dev/null
> +++ b/drivers/net/phy/mdio-aspeed.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (C) 2019 IBM Corp. */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/mdio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_mdio.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME "mdio-aspeed"
> +
> +#define ASPEED_MDIO_CTRL		0x0
> +#define   ASPEED_MDIO_CTRL_FIRE		BIT(31)
> +#define   ASPEED_MDIO_CTRL_ST		BIT(28)
> +#define     ASPEED_MDIO_CTRL_ST_C45	0
> +#define     ASPEED_MDIO_CTRL_ST_C22	1
> +#define   ASPEED_MDIO_CTRL_OP		GENMASK(27, 26)
> +#define     MDIO_C22_OP_WRITE		0b01
> +#define     MDIO_C22_OP_READ		0b10
> +#define   ASPEED_MDIO_CTRL_PHYAD	GENMASK(25, 21)
> +#define   ASPEED_MDIO_CTRL_REGAD	GENMASK(20, 16)
> +#define   ASPEED_MDIO_CTRL_MIIWDATA	GENMASK(15, 0)
> +
> +#define ASPEED_MDIO_DATA		0x4
> +#define   ASPEED_MDIO_DATA_MDC_THRES	GENMASK(31, 24)
> +#define   ASPEED_MDIO_DATA_MDIO_EDGE	BIT(23)
> +#define   ASPEED_MDIO_DATA_MDIO_LATCH	GENMASK(22, 20)
> +#define   ASPEED_MDIO_DATA_IDLE		BIT(16)
> +#define   ASPEED_MDIO_DATA_MIIRDATA	GENMASK(15, 0)
> +
> +#define ASPEED_MDIO_RETRIES		10
> +
> +struct aspeed_mdio {
> +	void __iomem *base;
> +};
> +
> +static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
> +{
> +	struct aspeed_mdio *ctx = bus->priv;
> +	u32 ctrl;
> +	int i;
> +
> +	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d\n", __func__, addr,
> +		regnum);
> +
> +	/* Just clause 22 for the moment */
> +	ctrl = ASPEED_MDIO_CTRL_FIRE

Hi Andrew

In the binding, you say C45 is supported. Here you don't. It would be
nice to be consistent.


> +		| FIELD_PREP(ASPEED_MDIO_CTRL_ST, ASPEED_MDIO_CTRL_ST_C22)
> +		| FIELD_PREP(ASPEED_MDIO_CTRL_OP, MDIO_C22_OP_READ)
> +		| FIELD_PREP(ASPEED_MDIO_CTRL_PHYAD, addr)
> +		| FIELD_PREP(ASPEED_MDIO_CTRL_REGAD, regnum);
> +
> +	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> +
> +	for (i = 0; i < ASPEED_MDIO_RETRIES; i++) {
> +		u32 data;
> +
> +		data = ioread32(ctx->base + ASPEED_MDIO_DATA);
> +		if (data & ASPEED_MDIO_DATA_IDLE)
> +			return FIELD_GET(ASPEED_MDIO_DATA_MIIRDATA, data);
> +
> +		udelay(100);
> +	}

One of the readx_poll_timeout functions could be used.

> +
> +	dev_err(&bus->dev, "MDIO read failed\n");
> +	return -EIO;
> +}
> +
> +static int aspeed_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
> +{
> +	struct aspeed_mdio *ctx = bus->priv;
> +	u32 ctrl;
> +	int i;
> +
> +	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d, val: 0x%x\n",
> +		__func__, addr, regnum, val);
> +
> +	/* Just clause 22 for the moment */
> +	ctrl = ASPEED_MDIO_CTRL_FIRE
> +		| FIELD_PREP(ASPEED_MDIO_CTRL_ST, ASPEED_MDIO_CTRL_ST_C22)
> +		| FIELD_PREP(ASPEED_MDIO_CTRL_OP, MDIO_C22_OP_WRITE)
> +		| FIELD_PREP(ASPEED_MDIO_CTRL_PHYAD, addr)
> +		| FIELD_PREP(ASPEED_MDIO_CTRL_REGAD, regnum)
> +		| FIELD_PREP(ASPEED_MDIO_CTRL_MIIWDATA, val);
> +
> +	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> +
> +	for (i = 0; i < ASPEED_MDIO_RETRIES; i++) {
> +		ctrl = ioread32(ctx->base + ASPEED_MDIO_CTRL);
> +		if (!(ctrl & ASPEED_MDIO_CTRL_FIRE))
> +			return 0;
> +
> +		udelay(100);
> +	}

readx_poll_timeout() here as well.

Otherwise this looks good.

	  Andrew

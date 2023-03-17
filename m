From: Rob Herring <robh@kernel.org>
Date: Fri, 17 Mar 2023 16:00:54 -0500
Subject: [PATCH v2 3/5] dmaengine: aspeed: Add AST2600 UART DMA driver
In-Reply-To: <20230314021817.30446-4-chiawei_wang@aspeedtech.com>
References: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
 <20230314021817.30446-4-chiawei_wang@aspeedtech.com>
Message-ID: <20230317210054.GA2790192-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 14, 2023 at 10:18:15AM +0800, Chia-Wei Wang wrote:
> Aspeed AST2600 UART DMA (UDMA) includes 14 channels for the
> DMA transmission and recevie of each UART devices.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/dma/Kconfig        |   9 +
>  drivers/dma/Makefile       |   1 +
>  drivers/dma/ast2600-udma.c | 528 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 538 insertions(+)
>  create mode 100644 drivers/dma/ast2600-udma.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index fb7073fc034f..c35f87dbafd9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -748,6 +748,15 @@ config XILINX_ZYNQMP_DPDMA
>  	  driver provides the dmaengine required by the DisplayPort subsystem
>  	  display driver.
>  
> +config ASPEED_AST2600_UDMA
> +	bool "Aspeed AST2600 UDMA support"
> +	depends on ARCH_ASPEED

|| COMPILE_TEST

> +	help
> +	  Enable support for Aspeed AST2600 UART DMA. Select this option if you
> +	  have a AST2600 SoC integrated system. The driver provides the UART DMA
> +	  support with the dmaengine subsystem, which can be leveraged by generic
> +	  8250 serial drivers.
> +
>  # driver files
>  source "drivers/dma/bestcomm/Kconfig"
>  
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a4fd1ce29510..6cbacebcdcab 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
> +obj-$(CONFIG_ASPEED_AST2600_UDMA) += ast2600-udma.o
>  
>  obj-y += mediatek/
>  obj-y += qcom/
> diff --git a/drivers/dma/ast2600-udma.c b/drivers/dma/ast2600-udma.c
> new file mode 100644
> index 000000000000..ff678724f9d9
> --- /dev/null
> +++ b/drivers/dma/ast2600-udma.c
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) ASPEED Technology Inc.
> + */
> +#include <linux/delay.h>
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>

> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>

You probably don't need these as you should use platform APIs instead.

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Tue, 5 Jan 2021 15:47:00 +0200
Subject: [PATCH v6 4/6] mmc: sdhci-of-aspeed: Add KUnit tests for phase
 calculations
In-Reply-To: <20201218035338.1130849-5-andrew@aj.id.au>
References: <20201218035338.1130849-1-andrew@aj.id.au>
 <20201218035338.1130849-5-andrew@aj.id.au>
Message-ID: <ff588027-0fbb-100e-05a9-4a804662d838@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18/12/20 5:53 am, Andrew Jeffery wrote:
> Converting degrees of phase to logic delays is irritating to test on
> hardware, so lets exercise the function using KUnit.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/mmc/host/Kconfig                |  14 ++++
>  drivers/mmc/host/Makefile               |   1 +
>  drivers/mmc/host/sdhci-of-aspeed-test.c | 100 ++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 596f32637315..d6f00d1d6251 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -168,6 +168,20 @@ config MMC_SDHCI_OF_ASPEED
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_OF_ASPEED_TEST
> +	bool "Tests for the ASPEED SDHCI driver"
> +	depends on MMC_SDHCI_OF_ASPEED && KUNIT=y
> +	help
> +	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
> +	  option only if you will boot the kernel for the purpose of running
> +	  unit tests (e.g. under UML or qemu).
> +
> +	  The KUnit tests generally exercise parts of the driver that do not
> +	  directly touch the hardware, for example, the phase correction
> +	  calculations.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_OF_AT91
>  	tristate "SDHCI OF support for the Atmel SDMMC controller"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 451c25fc2c69..3ee59d5802cf 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
> +obj-$(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)	+= sdhci-of-aspeed-test.o
>  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> new file mode 100644
> index 000000000000..fb79b278fb81
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (C) 2020 IBM Corp. */
> +
> +#include <kunit/test.h>
> +
> +#include "sdhci-of-aspeed.c"

I am not sure including like that is advisable.  Did you consider instead
doing it the other way around i.e. adding an include to the bottom of
sdhci-of-aspeed.c?

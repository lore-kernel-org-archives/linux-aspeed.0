From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 07 Mar 2022 11:36:14 +1030
Subject: [PATCH] ARM: soc: aspeed: Add secure boot controller support
In-Reply-To: <20220304030336.1017197-1-joel@jms.id.au>
References: <20220304030336.1017197-1-joel@jms.id.au>
Message-ID: <ff5acde7-3c64-4d1b-820f-f1ca23d5ddc2@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 4 Mar 2022, at 13:33, Joel Stanley wrote:
> This reads out the status of the secure boot controller and exposes it
> in debugfs.
>
> An example on a AST2600A3 QEMU model:
>
>  # grep -r . /sys/kernel/debug/aspeed/*
>  /sys/kernel/debug/aspeed/abr_image:0
>  /sys/kernel/debug/aspeed/low_security_key:0
>  /sys/kernel/debug/aspeed/otp_protected:0
>  /sys/kernel/debug/aspeed/secure_boot:1
>  /sys/kernel/debug/aspeed/uart_boot:0
>
> On boot the state of the system according to the secure boot controller
> will be printed:
>
>  [    0.037634] AST2600 secure boot enabled
>
> or
>
>  [    0.037935] AST2600 secure boot disabled
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> We're creating a common API for a subset of this information in sysfs:
>
>  https://lore.kernel.org/all/20220204072234.304543-1-joel at jms.id.au/
>
> However, machines with an ASPEED soc need the detailed information from
> the SBE that is not relevant for other systems, so expose it all in
> debugfs.
>
>  drivers/soc/aspeed/aspeed-sbc.c | 71 +++++++++++++++++++++++++++++++++
>  drivers/soc/aspeed/Kconfig      |  7 ++++
>  drivers/soc/aspeed/Makefile     |  1 +
>  3 files changed, 79 insertions(+)
>  create mode 100644 drivers/soc/aspeed/aspeed-sbc.c
>
> diff --git a/drivers/soc/aspeed/aspeed-sbc.c 
> b/drivers/soc/aspeed/aspeed-sbc.c
> new file mode 100644
> index 000000000000..ee466f02ae4c
> --- /dev/null
> +++ b/drivers/soc/aspeed/aspeed-sbc.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright 2022 IBM Corp. */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/debugfs.h>
> +
> +#define SEC_STATUS		0x14
> +#define ABR_IMAGE_SOURCE	BIT(13)
> +#define OTP_PROTECTED		BIT(8)
> +#define LOW_SEC_KEY		BIT(7)
> +#define SECURE_BOOT		BIT(6)
> +#define UART_BOOT		BIT(5)
> +
> +struct sbe {
> +	u8 abr_image;
> +	u8 low_security_key;
> +	u8 otp_protected;
> +	u8 secure_boot;
> +	u8 invert;
> +	u8 uart_boot;
> +};
> +
> +static struct sbe sbe;
> +
> +static int __init aspeed_sbc_init(void)
> +{
> +	struct device_node *np;
> +	void __iomem *base;
> +	struct dentry *debugfs_root;
> +	u32 security_status;

If you change anything else, maybe reverse-christmas-tree this too?

> +
> +	/* AST2600 only */
> +	np = of_find_compatible_node(NULL, NULL, "aspeed,ast2600-sbc");
> +	if (!of_device_is_available(np))
> +		return -ENODEV;
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
> +	security_status = readl(base + SEC_STATUS);
> +
> +	iounmap(base);
> +	of_node_put(np);

The cleanup looks right to me. I half wonder if it would be better with 
a single-exit and gotos, but that's just an idle thought.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> +
> +	sbe.abr_image = !!(security_status & ABR_IMAGE_SOURCE);
> +	sbe.low_security_key = !!(security_status & LOW_SEC_KEY);
> +	sbe.otp_protected = !!(security_status & OTP_PROTECTED);
> +	sbe.secure_boot = !!(security_status & SECURE_BOOT);
> +	/* Invert the bit, as 1 is boot from SPI/eMMC */
> +	sbe.uart_boot =  !(security_status & UART_BOOT);
> +
> +	debugfs_root = debugfs_create_dir("aspeed", NULL);
> +	debugfs_create_u8("abr_image", 0444, debugfs_root, &sbe.abr_image);
> +	debugfs_create_u8("low_security_key", 0444, debugfs_root, 
> &sbe.low_security_key);
> +	debugfs_create_u8("otp_protected", 0444, debugfs_root, 
> &sbe.otp_protected);
> +	debugfs_create_u8("uart_boot", 0444, debugfs_root, &sbe.uart_boot);
> +	debugfs_create_u8("secure_boot", 0444, debugfs_root, 
> &sbe.secure_boot);
> +
> +	pr_info("AST2600 secure boot %s\n", sbe.secure_boot ? "enabled" : 
> "disabled");
> +
> +	return 0;
> +}
> +
> +
> +subsys_initcall(aspeed_sbc_init);
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> index f579ee0b5afa..7a2a5bed8bc5 100644
> --- a/drivers/soc/aspeed/Kconfig
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -52,6 +52,13 @@ config ASPEED_SOCINFO
>  	help
>  	  Say yes to support decoding of ASPEED BMC information.
> 
> +config ASPEED_SBC
> +	bool "ASPEED Secure Boot Controller driver"
> +	default MACH_ASPEED_G6
> +	help
> +	  Say yes to provide information about the secure boot controller in
> +	  debugfs.
> +
>  endmenu
> 
>  endif
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> index b35d74592964..042235ffa05b 100644
> --- a/drivers/soc/aspeed/Makefile
> +++ b/drivers/soc/aspeed/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
>  obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
>  obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
> +obj-$(CONFIG_ASPEED_SBC)		+= aspeed-sbc.o
> -- 
> 2.34.1

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 2 Feb 2023 09:59:21 +0100
Subject: [PATCH v4 3/3] i2c: aspeed: support ast2600 i2c new register mode
 driver
In-Reply-To: <20230201103359.1742140-4-ryan_chen@aspeedtech.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-4-ryan_chen@aspeedtech.com>
Message-ID: <0555a7ae-60b7-a10d-e444-c0b6c3a2cf59@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/02/2023 11:33, Ryan Chen wrote:
> Add i2c new register mode driver to support AST2600 i2c
> new register mode. AST2600 i2c controller have legacy and
> new register mode. The new register mode have global register
> support 4 base clock for scl clock selection, and new clock
> divider mode. The i2c new register mode have separate register
> set to control i2c master and slave.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  MAINTAINERS                             |   10 +
>  drivers/i2c/busses/Kconfig              |   11 +
>  drivers/i2c/busses/Makefile             |    1 +
>  drivers/i2c/busses/i2c-ast2600-global.c |   94 ++
>  drivers/i2c/busses/i2c-ast2600-global.h |   19 +
>  drivers/i2c/busses/i2c-ast2600.c        | 1811 +++++++++++++++++++++++
>  6 files changed, 1946 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-ast2600-global.c
>  create mode 100644 drivers/i2c/busses/i2c-ast2600-global.h
>  create mode 100644 drivers/i2c/busses/i2c-ast2600.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 749710e22b4d..67d338d834b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3209,6 +3209,16 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
>  F:	drivers/usb/gadget/udc/aspeed_udc.c
>  
> +ASPEED AST2600 I2C DRIVER
> +M:	Ryan Chen <ryan_chen@aspeedtech.com>
> +L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
> +F:	Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> +F:	drivers/i2c/busses/i2c-ast2600-global.c
> +F:	drivers/i2c/busses/i2c-ast2600-global.h
> +F:	drivers/i2c/busses/i2c-ast2600.c
> +
>  ASPEED XDMA ENGINE DRIVER
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 7284206b278b..5ef3ee6aa70f 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -389,6 +389,17 @@ config I2C_ALTERA
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-altera.
>  
> +config I2C_AST2600
> +	tristate "Aspeed AST2600 I2C Controller"
> +	depends on ARCH_ASPEED || MACH_ASPEED_G6 || COMPILE_TEST

MACH_ASPEED_G6 is useless and redundant

> +	select I2C_SMBUS
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Aspeed I2C controller with new register set.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-new-aspeed.
> +
>  config I2C_ASPEED
>  	tristate "Aspeed I2C Controller"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index c5cac15f075c..ce83dfdc2094 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
>  obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
>  obj-$(CONFIG_I2C_AMD_MP2)	+= i2c-amd-mp2-pci.o i2c-amd-mp2-plat.o
>  obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
> +obj-$(CONFIG_I2C_AST2600)	+= i2c-ast2600-global.o i2c-ast2600.o

Why this cannot be merged to existing driver?

The same question for bindings... actually let me comment on this
separately.

(...)

> +static const struct of_device_id ast2600_i2c_global_of_match[] = {
> +	{ .compatible = "aspeed,ast2600-i2c-global", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ast2600_i2c_global_of_match);

This not how it works. You cannot have two drivers in one module.
(...)

> +
> +static const struct of_device_id ast2600_i2c_bus_of_table[] = {
> +	{
> +		.compatible = "aspeed,ast2600-i2c",

NAK. We already have it.



Best regards,
Krzysztof


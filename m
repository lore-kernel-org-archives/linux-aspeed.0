From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 16 Jul 2021 01:48:20 +0000
Subject: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
Message-ID: <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Uwe Kleine-K?nig, 

On 2021/7/15, 11:06 PM, "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>> wrote:

    On Fri, Jul 09, 2021 at 02:52:17PM +0800, Billy Tsai wrote:
    >> This patch add the support of PWM controller which can be found at aspeed
    >> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
    >> of multi-function device "pwm-tach controller".
    >> 
    >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    >> ---
    >>  drivers/pwm/Kconfig              |   9 +
    >>  drivers/pwm/Makefile             |   1 +
    >>  drivers/pwm/pwm-aspeed-ast2600.c | 316 +++++++++++++++++++++++++++++++
    >>  3 files changed, 326 insertions(+)
    >>  create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c
    >> 
    >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
    >> index 63be5362fd3a..a5aac3ca4ac7 100644
    >> --- a/drivers/pwm/Kconfig
    >> +++ b/drivers/pwm/Kconfig
    >> @@ -51,6 +51,15 @@ config PWM_AB8500
    >>  	  To compile this driver as a module, choose M here: the module
    >>  	  will be called pwm-ab8500.
    >>  
    >> +config PWM_ASPEED_AST2600
    >> +	tristate "Aspeed ast2600 PWM support"
    >> +	depends on ARCH_ASPEED || COMPILE_TEST

    > I think you need

    >	depdens on HAVE_CLK && HAS_IOMEM

    > here.

Ok, I will add it to next version.

    >> +	help
    >> +	  This driver provides support for Aspeed ast2600 PWM controllers.
    >> +
    >> +	  To compile this driver as a module, choose M here: the module
    >> +	  will be called pwm-aspeed-ast2600.
    >> +
    >>  config PWM_ATMEL
    >>  	tristate "Atmel PWM support"
    >>  	depends on OF
    >> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
    >> index cbdcd55d69ee..ada454f9129a 100644
    >> --- a/drivers/pwm/Makefile
    >> +++ b/drivers/pwm/Makefile
    >> @@ -2,6 +2,7 @@
    >>  obj-$(CONFIG_PWM)		+= core.o
    >>  obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
    >>  obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
    >> +obj-$(CONFIG_PWM_ASPEED_AST2600)	+= pwm-aspeed-ast2600.o
    >>  obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
    >>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
    >>  obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
    >> diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-aspeed-ast2600.c
    >> new file mode 100644
    >> index 000000000000..68a45ba3b32b
    >> --- /dev/null
    >> +++ b/drivers/pwm/pwm-aspeed-ast2600.c
    >> @@ -0,0 +1,316 @@
    >> +// SPDX-License-Identifier: GPL-2.0-or-later
    >> +/*
    >> + * Copyright (C) 2021 Aspeed Technology Inc.
    >> + *
    >> + * PWM controller driver for Aspeed ast2600 SoCs.
    >> + * This drivers doesn't support earlier version of the IP.
    >> + *
    >> + * The formula of pwm period duration:
    >> + * period duration = ((DIV_L + 1) * (PERIOD + 1) << DIV_H) / input-clk
    >> + *
    >> + * The formula of pwm duty cycle duration:
    >> + * duty cycle duration = period duration * DUTY_CYCLE_FALLING_POINT / (PERIOD + 1)
    >> + * = ((DIV_L + 1) * DUTY_CYCLE_FALLING_POINT << DIV_H) / input-clk
    >> + *
    >> + * The software driver fixes the period to 255, which causes the high-frequency
    >> + * precision of the PWM to be coarse, in exchange for the fineness of the duty cycle.
    >> + *
    >> + * Register usage:
    >> + * PIN_ENABLE: When it is unset the pwm controller will always output low to the extern.
    >> + * Use to determine whether the PWM channel is enabled or disabled
    >> + * CLK_ENABLE: When it is unset the pwm controller will reset the duty counter to 0 and
    >> + * output low to the PIN_ENABLE mux after that the driver can still change the pwm period
    >> + * and duty and the value will apply when CLK_ENABLE be set again.
    >> + * Use to determine whether duty_cycle bigger than 0.
    >> + * PWM_ASPEED_CTRL_INVERSE: When it is toggled the output value will inverse immediately.
    >> + * PWM_ASPEED_DUTY_CYCLE_FALLING_POINT/PWM_ASPEED_DUTY_CYCLE_RISING_POINT: When these two
    >> + * values are equal it means the duty cycle = 100%.
    >> + *
    >> + * Limitations:
    >> + * - When changing both duty cycle and period, we cannot prevent in
    >> + *   software that the output might produce a period with mixed
    >> + *   settings.
    >> + * - Disabling the PWM doesn't complete the current period.

    > Another is: The PWM doesn't support duty_cycle 0, on such a request the
    > PWM is disabled which results in a constant inactive level.

    > (This is correct, is it? Or does it yield a constant 0 level?)

Our pwm can support duty_cycle 0 by unset CLK_ENABLE.

Other naming suggestion I will fix in the next version.

Thanks


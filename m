From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 26 Nov 2021 09:26:41 +0000
Subject: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20211011073138.rofxayep6p47zrc6@pengutronix.de>
References: <20210906024339.21124-1-billy_tsai@aspeedtech.com>
 <20210906024339.21124-3-billy_tsai@aspeedtech.com>
 <20211011073138.rofxayep6p47zrc6@pengutronix.de>
Message-ID: <E28D96D2-EBBD-4699-B3F6-4F8925D4DFD3@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Uwe,

On 2021/10/11, 3:32 PM, "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de> wrote:

    On Mon, Sep 06, 2021 at 10:43:39AM +0800, Billy Tsai wrote:
    >   > This patch add the support of PWM controller which can be found at aspeed
    >   > ast2600 soc. The pwm supoorts up to 16 channels and it's part function
    >   > of multi-function device "pwm-tach controller".
    >   > 
    >   > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    >   > ---
    >   >  drivers/pwm/Kconfig              |  10 +
    >   >  drivers/pwm/Makefile             |   1 +
    >   >  drivers/pwm/pwm-aspeed-ast2600.c | 327 +++++++++++++++++++++++++++++++
    >   >  3 files changed, 338 insertions(+)
    >   >  create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c
    >   > 
    >   > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
    >   > index 63be5362fd3a..b0d26f6c2a8f 100644
    >   > --- a/drivers/pwm/Kconfig
    >   > +++ b/drivers/pwm/Kconfig
    >   > @@ -51,6 +51,16 @@ config PWM_AB8500
    >   >  	  To compile this driver as a module, choose M here: the module
    >   >  	  will be called pwm-ab8500.
    >   >  
    >   > +config PWM_ASPEED_AST2600
    >   > +	tristate "Aspeed ast2600 PWM support"
    >   > +	depends on ARCH_ASPEED || COMPILE_TEST
    >   > +	depends on HAVE_CLK && HAS_IOMEM
    >   > +	help
    >   > +	  This driver provides support for Aspeed ast2600 PWM controllers.
    >   > +
    >   > +	  To compile this driver as a module, choose M here: the module
    >   > +	  will be called pwm-aspeed-ast2600.
    >   > +
    >   >  config PWM_ATMEL
    >   >  	tristate "Atmel PWM support"
    >   >  	depends on OF
    >   > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
    >   > index cbdcd55d69ee..ada454f9129a 100644
    >   > --- a/drivers/pwm/Makefile
    >   > +++ b/drivers/pwm/Makefile
    >   > @@ -2,6 +2,7 @@
    >   >  obj-$(CONFIG_PWM)		+= core.o
    >   >  obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
    >   >  obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
    >   > +obj-$(CONFIG_PWM_ASPEED_AST2600)	+= pwm-aspeed-ast2600.o
    >   >  obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
    >   >  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
    >   >  obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
    >   > diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-aspeed-ast2600.c
    >   > new file mode 100644
    >   > index 000000000000..e4507a503698
    >   > --- /dev/null
    >   > +++ b/drivers/pwm/pwm-aspeed-ast2600.c
    >   > @@ -0,0 +1,327 @@
    >   > +// SPDX-License-Identifier: GPL-2.0-or-later
    >   > +/*
    >   > + * Copyright (C) 2021 Aspeed Technology Inc.
    >   > + *
    >   > + * PWM controller driver for Aspeed ast2600 SoCs.
    >   > + * This drivers doesn't support earlier version of the IP.
    >   > + *
    >   > + * The formula of pwm period duration:
    >   > + * period duration = ((DIV_L + 1) * (PERIOD + 1) << DIV_H) / input-clk
    >   > + *
    >   > + * The formula of pwm duty cycle duration:
    >   > + * duty cycle duration = period duration * DUTY_CYCLE_FALLING_POINT / (PERIOD + 1)
    >   > + * = ((DIV_L + 1) * DUTY_CYCLE_FALLING_POINT << DIV_H) / input-clk
    >   > + *
    >   > + * The software driver fixes the period to 255, which causes the high-frequency
    >   > + * precision of the PWM to be coarse, in exchange for the fineness of the duty cycle.
    >   > + *

    >   From reading this it's not clear (to me that is) what's the difference
    >   between "period duration" and "PERIOD". Maybe rewrite the comment to
    >   something like:

    >   	The hardware operates in time quantities of length

    >   		Q := (DIV_L + 1) << DIV_H / input-clk

    >   	The length of a PWM period is (DUTY_CYCLE_PERIOD + 1) * Q.
    >   	The maximal value for DUTY_CYCLE_PERIOD is used here to provide
    >   	a fine grained selection for the duty cycle.

    >   	This driver uses DUTY_CYCLE_RISING_POINT = 0, so from the start of a
    >   	period the output is active until DUTY_CYCLE_FALLING_POINT * Q. Note
    >   	that if DUTY_CYCLE_RISING_POINT = DUTY_CYCLE_FALLING_POINT the output is
    >   	always active.

    >   This is a bit more high-level and still gives all the details.

Thanks for your explain, it is a clearer for the behavior of our hardware. 
I will rewrite the comment in next patch.

    >   Maybe the special case with DUTY_CYCLE_RISING_POINT =
    >   DUTY_CYCLE_FALLING_POINT would be a bit more natural if the driver used
    >   inverse logic: Assume the output to be inverted with CTRL_INVERSE = 0,
    >   fix DUTY_CYCLE_FALLING_POINT to 0 and adapt DUTY_CYCLE_RISING_POINT
    >   dependant on duty cycle? At least then DUTY_CYCLE_RISING_POINT = 0
    >   corresponds to duty_cycle = 0. Just an idea ... which might or might not
    >   work depending on the hardware.

This is a trade-off between
CTRL_INVERSE = 1 : Support duty_cycle from 0% to 99%
and
CTRL_INVERSE = 0: Support duty_cycle from 1% to 100%
The driver select the CTRL_INVERSE = 0 as the default state.

    >   > + * Register usage:
    >   > + * PIN_ENABLE: When it is unset the pwm controller will emit inactive level to the extern.
    >   > + * Use to determine whether the PWM channel is enabled or disabled
    >   > + * CLK_ENABLE: When it is unset the pwm controller will assert the duty counter reset and
    >   > + * emit inactive level to the PIN_ENABLE mux after that the driver can still change the pwm period
    >   > + * and duty and the value will apply when CLK_ENABLE be set again.
    >   > + * Use to determine whether duty_cycle bigger than 0.
    >   > + * PWM_ASPEED_CTRL_INVERSE: When it is toggled the output value will inverse immediately.
    >   > + * PWM_ASPEED_DUTY_CYCLE_FALLING_POINT/PWM_ASPEED_DUTY_CYCLE_RISING_POINT: When these two
    >   > + * values are equal it means the duty cycle = 100%.
    >   > + *
    >   > + * The glitch may generate at:
    >   > + * - Enabled changing when the duty_cycle bigger than 0% and less than 100%.
    >   > + * - Polarity changing when the duty_cycle bigger than 0% and less than 100%.
    >   > + * - Set duty cycle to 0% from other values.
    >   > + *
    >   > + * Limitations:
    >   > + * - When changing both duty cycle and period, we cannot prevent in
    >   > + *   software that the output might produce a period with mixed
    >   > + *   settings.
    >   > + * - Disabling the PWM doesn't complete the current period.
    >   > + *
    >   > + * Improvements:
    >   > + * - When only changing one of duty cycle or period, our pwm controller will not
    >   > + *   generate the glitch, the configure will change at next cycle of pwm.
    >   > + *   This improvement can disable/enable through PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE.
    >   > + */
    >   > +
    >   > [...]
    >   > +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
    >   > +			    const struct pwm_state *state)
    >   > +{
    >   > +	struct device *dev = chip->dev;
    >   > +	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
    >   > +	u32 hwpwm = pwm->hwpwm, duty_pt;
    >   > +	unsigned long rate;
    >   > +	u64 div_h, div_l, divisor;
    >   > +	bool clk_en;
    >   > +
    >   > +	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", state->period,
    >   > +		state->duty_cycle);
    >   > +
    >   > +	rate = clk_get_rate(priv->clk);
    >   > +	if (state->period > div64_u64(ULLONG_MAX, (u64)rate))
    >   > +		return -ERANGE;

    >   Given that the biggest possible period <= requested period should be
    >   configured, this check + return is wrong.

    >   > +	/*
    >   > +	 * Pick the smallest value for div_h so that div_l can be the biggest
    >   > +	 * which results in a finer resolution near the target period value.
    >   > +	 */
    >   > +	divisor = (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
    >   > +		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
    >   > +	div_h = order_base_2(DIV64_U64_ROUND_UP(rate * state->period, divisor));

    >   > +	if (div_h > 0xf)
    >   > +		div_h = 0xf;
    >   > +
    >   > +	divisor = ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) << div_h;
    >   > +	div_l = div64_u64(rate * state->period, divisor);
    >   > +
    >   > +	if (div_l == 0)
    >   > +		return -ERANGE;
    >   > +
    >   > +	div_l -= 1;
    >   > +
    >   > +	if (div_l > 255)
    >   > +		div_l = 255;
    >   > +
    >   > + [...]

Best Regards,
Billy Tsai


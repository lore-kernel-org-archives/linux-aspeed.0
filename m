From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 8 Jun 2021 04:26:24 +0000
Subject: [v7 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20210607072459.mzanptd6mwvalh3n@pengutronix.de>
References: <20210525043224.27998-1-billy_tsai@aspeedtech.com>
 <20210525043224.27998-3-billy_tsai@aspeedtech.com>
 <20210607072459.mzanptd6mwvalh3n@pengutronix.de>
Message-ID: <A85AB108-192E-47BB-A6CA-C2013C605466@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On 2021/6/7, 3:25 PM,Uwe Kleine-K?nigwrote:

    Hello,

    On Tue, May 25, 2021 at 12:32:24PM +0800, Billy Tsai wrote:
    >> This patch add the support of PWM controller which can be found at aspeed
    >> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
    >> of multi-function device "pwm-tach controller".
    >> 
    >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    >> ---
    >>  drivers/pwm/Kconfig         |   9 +
    >>  drivers/pwm/Makefile        |   1 +
    >>  drivers/pwm/pwm-aspeed-g6.c | 334 ++++++++++++++++++++++++++++++++++++

    > This doesn't match the driver name which is only "aspeed_pwm". Can you
    > please use matching names and pick the function prefix accordingly? What
    > is the difference between g6 and ast2600?

They are the same. I will use ast2600 to replace g6.

    >> + * The software driver fixes the period to 255, which causes the high-frequency
    >> + * precision of the PWM to be coarse, in exchange for the fineness of the duty cycle.
    >> + *
    >> + * Register usage:
    >> + * PIN_ENABLE: When it is unset the pwm controller will always output low to the extern.
    >> + * Use to determine whether the PWM channel is enabled or disabled
    >> + * CLK_ENABLE: When it is unset the pwm controller will reset the duty counter to 0 and
    >> + * output low to the PIN_ENABLE mux after that the driver can still change the pwm period
    >> + * and duty and the value will apply when CLK_ENABLE be set again.
    >> + * Use to determin whether duty_cycle bigger than 0.

    > s/determin/determine/

    > Unsetting CLK_ENABLE has an immediate effect, right? 

Yes.

    >> + * PWM_ASPEED_CTRL_INVERSE: When it is toggled the output value will inverse immediately.
    >> + * PWM_ASPEED_DUTY_CYCLE_FALLING_POINT/PWM_ASPEED_DUTY_CYCLE_RISING_POINT: When these two
    >> + * values are equal it means the duty cycle = 100%.

    > Just for my understanding: These allow to implement a phase offset and
    > so to implement inverse polarity you can either use
    > PWM_ASPEED_CTRL_INVERSE or set these values accordingly, right?

Yes.

    >> +#include <linux/io.h>
    >> +#include <linux/kernel.h>
    >> +#include <linux/mfd/syscon.h>
    >> +#include <linux/module.h>
    >> +#include <linux/of_platform.h>
    >> +#include <linux/of_device.h>
    >> +#include <linux/platform_device.h>
    >> +#include <linux/sysfs.h>
    >> +#include <linux/reset.h>
    >> +#include <linux/regmap.h>
    >> +#include <linux/bitfield.h>
    >> +#include <linux/slab.h>
    >> +#include <linux/pwm.h>
    >> +#include <linux/math64.h>
    >> +
    >> +/* The channel number of Aspeed pwm controller */

    > Is there an officially correct spelling of "Aspeed" that your marketing
    > section would be happy if it were to be used consistently? We have
    > "Aspeed" and "ASPEED" in this patch set.

I will use "Aspeed".

    >> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
    >> +			    const struct pwm_state *state)
    >> +{
    >> +	struct device *dev = chip->dev;
    >> +	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
    >> +	u32 index = pwm->hwpwm, duty_pt;
    >> +	unsigned long rate;
    >> +	u64 apply_period, div_h, div_l, divisor;
    >> +
    >> +	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", state->period,
    >> +		state->duty_cycle);
    >> +
    >> +	rate = clk_get_rate(priv->clk);
    >> +	/*
    >> +	 * Pick the smallest value for div_h so that div_l can be the biggest
    >> +	 * which results in a finer resolution near the target period value.
    >> +	 */
    >> +	divisor = (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
    >> +		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
    >> +	div_h = order_base_2(DIV64_U64_ROUND_UP(rate * state->period, divisor));
    >> +	if (div_h > 0xf)
    >> +		div_h = 0xf;
    >> +
    >> +	divisor = ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) << div_h;
    >> +	div_l = div64_u64(rate * state->period, divisor);
    >> +
    >> +	if (div_l == 0)
    >> +		return -ERANGE;
    >> +
    >> +	div_l -= 1;
    >> +
    >> +	if (div_l > 255)
    >> +		div_l = 255;
    >> +
    >> +	dev_dbg(dev, "clk source: %ld div_h %lld, div_l : %lld\n", rate, div_h,
    >> +		div_l);
    >> +
    >> +	apply_period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * _BITULL(div_h) *
    >> +						(div_l + 1) *
    >> +						(PWM_ASPEED_FIXED_PERIOD + 1),
    >> +					rate);
    >> +	duty_pt = DIV_ROUND_DOWN_ULL(state->duty_cycle *
    >> +					     (PWM_ASPEED_FIXED_PERIOD + 1),
    >> +				     apply_period);

    > Don't divide by the result of a division. So better use:

    >	state->duty_cycle * rate
    >	----------------------------------------
    >	NSEC_PER_SEC * BITULL(div_h) * div_l + 1

    > (Is it correct that PWM_ASPEED_FIXED_PERIOD doesn't appear here?)

Yes, it is correct.


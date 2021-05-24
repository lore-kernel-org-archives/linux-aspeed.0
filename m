From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 24 May 2021 13:02:57 +0200
Subject: [v6 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <9EA46360-8F43-4D1B-9004-3965A6182FA1@aspeedtech.com>
References: <20210518005517.9036-1-billy_tsai@aspeedtech.com>
 <20210518005517.9036-3-billy_tsai@aspeedtech.com>
 <20210522160708.ryr7n7klapszu2da@pengutronix.de>
 <9EA46360-8F43-4D1B-9004-3965A6182FA1@aspeedtech.com>
Message-ID: <20210524110257.izcgx4kdmj5c7dou@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Mon, May 24, 2021 at 01:56:19AM +0000, Billy Tsai wrote:
> On 2021/5/23, 12:07 AM,Uwe Kleine-K?nigwrote:
>     On Tue, May 18, 2021 at 08:55:17AM +0800, Billy Tsai wrote:
>     >   > +static u64 aspeed_pwm_get_period(struct pwm_chip *chip, struct pwm_device *pwm)
>     >   > +{
>     >   > +	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
>     >   > +	unsigned long rate;
>     >   > +	u32 index = pwm->hwpwm;
>     >   > +	u32 val;
>     >   > +	u64 period, div_h, div_l, clk_period;
>     >   > +
>     >   > +	rate = clk_get_rate(priv->clk);
>     >   > +	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
>     >   > +	div_h = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
>     >   > +	div_l = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
>     >   > +	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index), &val);
>     >   > +	clk_period = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
>     >   > +	period = (NSEC_PER_SEC * BIT(div_h) * (div_l + 1) * (clk_period + 1));
> 
>     > The outer pair of parenthesis on the RHS isn't necessary. The maximal
>     > value that period can have here is:
> 
>     >	1000000000 * 2**15 * 256 * 256
> 
>     > This fits into an u64, but as all but the last factor are 32 bit values
>     > you might get an overflow here.
> 
> I don?t know in which case the value will overflow, when my parameter types are all u64.
> Can you tell me what is "the last factor"?

Ah, I missed that div_l is u64. NSEC_PER_SEC and BIT(div_h) are both
long quantities only and 1000000000 * 2**15 might overflow that.

>     >   > +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>     >   > +			    const struct pwm_state *state)
>     >   > +{
>     >   > +	struct device *dev = chip->dev;
>     >   > +	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
>     >   > +	u32 index = pwm->hwpwm;
>     >   > +	int ret;
>     >   > +
>     >   > +	dev_dbg(dev, "apply period: %lldns, duty_cycle: %lldns", state->period,
>     >   > +		state->duty_cycle);
>     >   > +
>     >   > +	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
>     >   > +			   PWM_ASPEED_CTRL_PIN_ENABLE,
>     >   > +			   state->enabled ? PWM_ASPEED_CTRL_PIN_ENABLE : 0);
>     >   > +	/*
>     >   > +	 * Fixed the period to the max value and rising point to 0
>     >   > +	 * for high resolution and simplify frequency calculation.
>     >   > +	 */
>     >   > +	regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
>     >   > +			   (PWM_ASPEED_DUTY_CYCLE_PERIOD |
>     >   > +			    PWM_ASPEED_DUTY_CYCLE_RISING_POINT),
>     >   > +			   FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_PERIOD,
>     >   > +				      PWM_ASPEED_FIXED_PERIOD));
>     >   > +
>     >   > +	ret = aspeed_pwm_set_period(chip, pwm, state);
>     >   > +	if (ret)
>     >   > +		return ret;
>     >   > +	aspeed_pwm_set_duty(chip, pwm, state);
> 
>     > aspeed_pwm_set_duty calls aspeed_pwm_get_period() which is a bit
>     > ineffective after just having set the period.
> 
> When I call aspeed_pwm_set_period it doesn't mean the period is equal to what I set (It may
> lose some precision Ex: When I set the period 40000ns, the actual period I set is 39680ns) and
> I didn't get this information when I call aspeed_pwm_set_period. Thus, I need to get the actual
> period first before set duty.

I'm aware it might lose precision. But calling aspeed_pwm_get_period()
determines the setting from reading registers, if you reuse all
information available in aspeed_pwm_set_period() this is cheaper. Also
it might be beneficial to first compute all necessary register values
and then write them in quick sequence to keep the window for glitches
small. Given that aspeed_pwm_set_period and aspeed_pwm_set_duty both
have only a single caller, doing both in a single function might be an
idea.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210524/b829d319/attachment.sig>

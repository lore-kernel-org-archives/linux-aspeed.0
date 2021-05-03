From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 3 May 2021 08:10:59 +0200
Subject: [v2 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <A89B45FD-FD3D-43F2-A850-8A7FBB1AF165@aspeedtech.com>
References: <20210414104939.1093-1-billy_tsai@aspeedtech.com>
 <20210414104939.1093-3-billy_tsai@aspeedtech.com>
 <20210426204333.gzqke6td33dtugnh@pengutronix.de>
 <A89B45FD-FD3D-43F2-A850-8A7FBB1AF165@aspeedtech.com>
Message-ID: <20210503061059.xrcpuyouga4z5nno@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Mon, May 03, 2021 at 04:42:59AM +0000, Billy Tsai wrote:
> On 2021/4/27, 4:44 AM,Uwe Kleine-K?nigwrote:
>     >> +/* PWM fixed value */
>     >> +#define PWM_FIXED_PERIOD 0xff
>     >> +
>     >> +struct aspeed_pwm_data {
>     >> +	struct pwm_chip chip;
>     >> +	struct clk *clk;
>     >> +	struct regmap *regmap;
>     >> +	struct reset_control *reset;
>     >> +};
>     >> +
>     >> +static void aspeed_set_pwm_channel_enable(struct regmap *regmap, u8 pwm_channel,
>     >> +					  bool enable)
>     >> +{
>     >> +	regmap_update_bits(regmap, PWM_ASPEED_CTRL_CH(pwm_channel),
>     >> +			   (PWM_CLK_ENABLE | PWM_PIN_ENABLE),
>     >> +			   enable ? (PWM_CLK_ENABLE | PWM_PIN_ENABLE) : 0);
> 
>     > What is the semantic difference between CLK_ENABLE and PIN_ENABLE? Does
>     > the pin stay at it's inactive level if PIN_ENABLE is unset? Does the
>     > output just freeze at it's current level if CLK_ENABLE is unset?
> 
> Yes. 
> When PIN_ENABLE is unset the pwm controller will always output low to the extern.
> When CLK_ENABLE is unset the pwm controller will freeze at it's current level.

These two are relevant to mention at the top of the driver.

>     > The intended goal is to provide the biggest possible period not bigger
>     > than the requested value.
>     
> So, did you mean that if the request period is 100ns and our divide can reach 100.1ns or 95ns
> the user prefer 95ns to 100.1ns?

Yes. It's unclear if the user really prefers 95ns, but to get a
consistent behaviour among the different drivers, that's what I ask you
to implement.

Currently there is no way that allows a consumer to specify which
setting they prefer, I have an idea for a fix though. For that it is
also important that .apply() doesn't yield 100.1 ns.

>     >> +	dev_dbg(dev, "freq: %d, duty_pt: %d", freq, duty_pt);
>     >> +	if (state->enabled) {
>     >> +		aspeed_set_pwm_freq(priv, pwm, freq);
>     >> +		aspeed_set_pwm_duty(priv, pwm, duty_pt);
>     >> +		aspeed_set_pwm_polarity(priv, pwm, state->polarity);
> 
>     > How does the hardware behave in between these calls? If for example the
>     > polarity is changed, does this affect the output immediately? Does this
>     > start a new period?
> 
> The pwm output will inverse immediately. The period will not change.

Please mention that at the top of the driver.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210503/02869e06/attachment.sig>

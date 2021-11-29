From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 29 Nov 2021 21:51:54 +0100
Subject: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20211129064329.27006-3-billy_tsai@aspeedtech.com>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
 <20211129064329.27006-3-billy_tsai@aspeedtech.com>
Message-ID: <20211129205154.jtm4ehvvfo52toth@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Billy,

just two minor thing left to criticise:

On Mon, Nov 29, 2021 at 02:43:29PM +0800, Billy Tsai wrote:
> +	if (clk_en && duty_pt) {
> +		dividend = (u64)NSEC_PER_SEC * (div_l + 1) * duty_pt
> +				 << div_h;
> +		state->duty_cycle = DIV_ROUND_UP_ULL(dividend, rate);
> +	} else
> +		state->duty_cycle = clk_en ? state->period : 0;

I wonder about checkpatch not criticising this construct. See
Documentation/process/coding-style.rst:

	Do not unnecessarily use braces where a single statement will
	do. [...] This does not apply if only one branch of a
	conditional statement is a single statement; in the latter case
	use braces in both branches

> [...]
> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct device *dev = chip->dev;
> +	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
> +	u32 hwpwm = pwm->hwpwm, duty_pt;
> +	unsigned long rate;
> +	u64 div_h, div_l, divisor, expect_period;
> +	bool clk_en;
> +
> +	expect_period = state->period;
> +	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", expect_period,
> +		state->duty_cycle);
> +
> +	rate = clk_get_rate(priv->clk);
> +	if (expect_period > div64_u64(ULLONG_MAX, (u64)rate))
> +		expect_period = div64_u64(ULLONG_MAX, (u64)rate);

If you write that as

	expect_period = min(div64_u64(ULLONG_MAX, (u64)rate), expect_period);

you make sure that the division is only calculated once.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211129/4c8503dc/attachment.sig>

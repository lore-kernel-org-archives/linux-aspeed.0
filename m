From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 13 Apr 2021 09:24:45 +0000
Subject: [PATCH 3/4] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20210412123502.v77fvmi3awvbmduu@pengutronix.de>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-4-billy_tsai@aspeedtech.com>
 <20210412123502.v77fvmi3awvbmduu@pengutronix.de>
Message-ID: <EF35BD1B-0FD8-487C-9FE7-EFB9E481F434@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for your review

Best Regards,
Billy Tsai

On 2021/4/12, 8:35 PM,Uwe Kleine-K?nigwrote:

    Hello Billy,

    On Mon, Apr 12, 2021 at 05:54:56PM +0800, Billy Tsai wrote:
    >> This patch add the support of PWM controller which can find at aspeed
    >> ast2600 soc chip. This controller supoorts up to 16 channels.
    >> 
    >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    >> ---
    >>  drivers/pwm/pwm-aspeed-g6.c | 291 ++++++++++++++++++++++++++++++++++++
    >>  1 file changed, 291 insertions(+)
    >>  create mode 100644 drivers/pwm/pwm-aspeed-g6.c
    >> 
    >> diff --git a/drivers/pwm/pwm-aspeed-g6.c b/drivers/pwm/pwm-aspeed-g6.c
    >> new file mode 100644
    >> index 000000000000..4bb4f97453c6
    >> --- /dev/null
    >> +++ b/drivers/pwm/pwm-aspeed-g6.c
    >> @@ -0,0 +1,291 @@
    >> +// SPDX-License-Identifier: GPL-2.0-only
    >> +/*
    >> + * Copyright (C) ASPEED Technology Inc.

    > Don't you need to add a year here?

Got it.

    >> + * This program is free software; you can redistribute it and/or modify
    >> + * it under the terms of the GNU General Public License version 2 or later as
    >> + * published by the Free Software Foundation.

    > Hmm, the comment and the SPDX-License-Identifier contradict each other.
    > The idea of the latter is that the former isn't needed.

I will use "// SPDX-License-Identifier: GPL-2.0-or-later" for the license.

    >> + */

    > Is there documentation available in the internet for this hardware? If
    > yes, please mention a link here.

Sorry we don't have the hardware document in the internet.

    > Also describe the hardware here similar to how e.g.
    > drivers/pwm/pwm-sifive.c does it. Please stick to the same format for
    > easy grepping.

Got it.

    >> +
    >> +#include <linux/clk.h>
    >> +#include <linux/errno.h>
    >> +#include <linux/delay.h>
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
    >> +#include <linux/pwm.h>
    >> +/* The channel number of Aspeed pwm controller */
    >> +#define ASPEED_NR_PWMS 16
    >> +/* PWM Control Register */
    >> +#define ASPEED_PWM_CTRL_CH(ch) ((ch * 0x10) + 0x00)

    > #define ASPEED_PWM_CTRL_CH(ch) (((ch) * 0x10) + 0x00)

Got it.

    >> +#define PWM_LOAD_SEL_AS_WDT BIT(19)
    >> +#define LOAD_SEL_FALLING 0
    >> +#define LOAD_SEL_RIGING 1
    >> +#define PWM_DUTY_LOAD_AS_WDT_EN BIT(18)
    >> +#define PWM_DUTY_SYNC_DIS BIT(17)
    >> +#define PWM_CLK_ENABLE BIT(16)
    >> +#define PWM_LEVEL_OUTPUT BIT(15)
    >> +#define PWM_INVERSE BIT(14)
    >> +#define PWM_OPEN_DRAIN_EN BIT(13)
    >> +#define PWM_PIN_EN BIT(12)
    >> +#define PWM_CLK_DIV_H_SHIFT 8
    >> +#define PWM_CLK_DIV_H_MASK (0xf << PWM_CLK_DIV_H_SHIFT)
    >> +#define PWM_CLK_DIV_L_SHIFT 0
    >> +#define PWM_CLK_DIV_L_MASK (0xff << PWM_CLK_DIV_L_SHIFT)
    >> +/* PWM Duty Cycle Register */
    >> +#define ASPEED_PWM_DUTY_CYCLE_CH(ch) ((ch * 0x10) + 0x04)
    >> +#define PWM_PERIOD_SHIFT (24)
    >> +#define PWM_PERIOD_MASK (0xff << PWM_PERIOD_SHIFT)
    >> +#define PWM_POINT_AS_WDT_SHIFT (16)
    >> +#define PWM_POINT_AS_WDT_MASK (0xff << PWM_POINT_AS_WDT_SHIFT)
    >> +#define PWM_FALLING_POINT_SHIFT (8)
    >> +#define PWM_FALLING_POINT_MASK (0xffff << PWM_FALLING_POINT_SHIFT)
    >> +#define PWM_RISING_POINT_SHIFT (0)
    >> +#define PWM_RISING_POINT_MASK (0xffff << PWM_RISING_POINT_SHIFT)
    >> +/* PWM default value */
    >> +#define DEFAULT_PWM_PERIOD 0xff
    >> +#define DEFAULT_TARGET_PWM_FREQ 25000
    >> +#define DEFAULT_DUTY_PT 10
    >> +#define DEFAULT_WDT_RELOAD_DUTY_PT 16

    > You could spend a few empty lines to make this better readable. Also
    > please use a consistent driver-specific prefix for your defines and
    > consider using the macros from <linux/bitfield.h>. Also defines
    > for bitfields should contain the register name.

Got it. I will use the bitfield method to write the hardware register.

    >> +struct aspeed_pwm_data {
    >> +	struct pwm_chip chip;
    >> +	struct regmap *regmap;
    >> +	unsigned long clk_freq;
    >> +	struct reset_control *reset;
    >> +};
    >> +/**
    >> + * struct aspeed_pwm - per-PWM driver data
    >> + * @freq: cached pwm freq
    >> + */
    >> +struct aspeed_pwm {
    >> +	u32 freq;
    >> +};

    > This is actually unused, please drop it. (You save a value in it, but
    > make never use of it.)

Got it.

    >> +static void aspeed_set_pwm_channel_enable(struct regmap *regmap, u8 pwm_channel,
    >> +					  bool enable)
    >> +{
    >> +	regmap_update_bits(regmap, ASPEED_PWM_CTRL_CH(pwm_channel),
    >> +			   (PWM_CLK_ENABLE | PWM_PIN_EN),
    >> +			   enable ? (PWM_CLK_ENABLE | PWM_PIN_EN) : 0);

    > What is the semantic of PIN_EN?

It means PIN_ENABLE. I will complete the defined name with PWM_PIN_ENABLE.

    >> +}
    >> +/*
    >> + * The PWM frequency = HCLK(200Mhz) / (clock division L bit *
    >> + * clock division H bit * (period bit + 1))
    >> + */
    >> +static void aspeed_set_pwm_freq(struct aspeed_pwm_data *priv,
    >> +				struct pwm_device *pwm, u32 freq)
    >> +{
    >> +	u32 target_div, cal_freq;
    >> +	u32 tmp_div_h, tmp_div_l, diff, min_diff = INT_MAX;
    >> +	u32 div_h = BIT(5) - 1, div_l = BIT(8) - 1;
    >> +	u8 div_found;
    >> +	u32 index = pwm->hwpwm;
    >> +	struct aspeed_pwm *channel = pwm_get_chip_data(pwm);
    >> +
    >> +	cal_freq = priv->clk_freq / (DEFAULT_PWM_PERIOD + 1);
    >> +	target_div = DIV_ROUND_UP(cal_freq, freq);
    >> +	div_found = 0;
    >> +	/* calculate for target frequence */

    > s/frequence/frequency/

Got it.

    >> +	for (tmp_div_h = 0; tmp_div_h < 0x10; tmp_div_h++) {
    >> +		tmp_div_l = target_div / BIT(tmp_div_h) - 1;
    >> +
    >> +		if (tmp_div_l < 0 || tmp_div_l >> 255)
    >> +			continue;
    >> +
    >> +		diff = freq - cal_freq / (BIT(tmp_div_h) * (tmp_div_l + 1));
    >> +		if (abs(diff) < abs(min_diff)) {
    >> +			min_diff = diff;
    >> +			div_l = tmp_div_l;
    >> +			div_h = tmp_div_h;
    >> +			div_found = 1;
    >> +			if (diff == 0)
    >> +				break;
    >> +		}
    >> +	}

    > If my understanding is right (i.e. H divides by a power of two and L by
    > an integer) this can be simplified.

Yes, the formula of the frequency is: 
    HCLK / ((2 ** H divide) * L divide * PERIOD value)
I think the simplified way is using the bit shift, right?

    >> +	if (div_found == 0) {
    >> +		pr_debug("target freq: %d too slow set minimal frequency\n",
    >> +			 freq);
    >> +	}
    >> +	channel->freq = cal_freq / (BIT(div_h) * (div_l + 1));
    >> +	pr_debug("div h %x, l : %x pwm out clk %d\n", div_h, div_l,
    >> +		 channel->freq);
    >> +	pr_debug("hclk %ld, target pwm freq %d, real pwm freq %d\n",
    >> +		 priv->clk_freq, freq, channel->freq);
    >> +
    >> +	regmap_update_bits(priv->regmap, ASPEED_PWM_CTRL_CH(index),
    >> +			   (PWM_CLK_DIV_H_MASK | PWM_CLK_DIV_L_MASK),
    >> +			   (div_h << PWM_CLK_DIV_H_SHIFT) |
    >> +				   (div_l << PWM_CLK_DIV_L_SHIFT));
    >> +}
    >> +
    >> +static void aspeed_set_pwm_duty(struct aspeed_pwm_data *priv,
    >> +				struct pwm_device *pwm, u32 duty_pt)
    >> +{
    >> +	u32 index = pwm->hwpwm;
    >> +
    >> +	if (duty_pt == 0) {
    >> +		aspeed_set_pwm_channel_enable(priv->regmap, index, false);
    >> +	} else {
    >> +		regmap_update_bits(priv->regmap,
    >> +				   ASPEED_PWM_DUTY_CYCLE_CH(index),
    >> +				   PWM_FALLING_POINT_MASK,
    >> +				   duty_pt << PWM_FALLING_POINT_SHIFT);
    >> +		aspeed_set_pwm_channel_enable(priv->regmap, index, true);
    >> +	}
    >> +}
    >> +
    >> +static void aspeed_set_pwm_polarity(struct aspeed_pwm_data *priv,
    >> +				    struct pwm_device *pwm, u8 polarity)
    >> +{
    >> +	u32 index = pwm->hwpwm;
    >> +
    >> +	regmap_update_bits(priv->regmap, ASPEED_PWM_CTRL_CH(index), PWM_INVERSE,
    >> +			   (polarity) ? PWM_INVERSE : 0);
    >> +}
    >> +
    >> +static int aspeed_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
    >> +{
    >> +	struct device *dev = chip->dev;
    >> +	struct aspeed_pwm_data *priv = dev_get_drvdata(dev);
    >> +	struct aspeed_pwm *channel;
    >> +	u32 index = pwm->hwpwm;
    >> +	/*
    >> +	 * Fixed the period to the max value and rising point to 0
    >> +	 * for high resolution and  simplified frequency calculation.

    > s/^H//

Sorry, I don't understand this mean.

    >> +	 */
    >> +	regmap_update_bits(priv->regmap, ASPEED_PWM_DUTY_CYCLE_CH(index),
    >> +			   PWM_PERIOD_MASK,
    >> +			   DEFAULT_PWM_PERIOD << PWM_PERIOD_SHIFT);
    >> +
    >> +	regmap_update_bits(priv->regmap, ASPEED_PWM_DUTY_CYCLE_CH(index),
    >> +			   PWM_RISING_POINT_MASK, 0);

    > Only .apply is supposed to modify the PWM's configuration.

This is the initial value and the fixed(const) value for our pwm driver usage.
The value won't be modified, so I think I can initial it when pwm channel be requested.

    >> +	channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
    >> +	if (!channel)
    >> +		return -ENOMEM;

    > Don't use devm_kzalloc if freeing isn't done at device cleanup time.

This doesn't depend on device, so I can use "kzalloc" to replace it?

    >> +	pwm_set_chip_data(pwm, channel);
    >> +
    >> +	return 0;

    >> +}
    >> +
    >> +static void aspeed_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
    >> +{
    >> +	struct device *dev = chip->dev;
    >> +	struct aspeed_pwm *channel = pwm_get_chip_data(pwm);
    >> +
    >> +	devm_kfree(dev, channel);
    >> +}

When pwm free I need to use kfree to release the resources, right?

    >> +
    >> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
    >> +			    const struct pwm_state *state)
    >> +{
    >> +	struct device *dev = chip->dev;
    >> +	struct aspeed_pwm_data *priv = dev_get_drvdata(dev);

    >Please consider using
    >
    >	priv = container_of(chip, struct aspeed_pwm_data, chip);
    >
    >(preferably wrapped in a macro) which is more type safe and more
    >effective to calculate.

Got it.

    >> +	struct pwm_state *cur_state = &pwm->state;
    >> +	u32 freq = DIV_ROUND_UP_ULL(1000000000, state->period);
    >> +	u32 duty_pt = DIV_ROUND_UP_ULL(
    >> +		state->duty_cycle * (DEFAULT_PWM_PERIOD + 1), state->period);

    > You're loosing precision here.


    >> +	dev_dbg(dev, "freq: %d, duty_pt: %d", freq, duty_pt);
    >> +	if (state->enabled) {
    >> +		aspeed_set_pwm_freq(priv, pwm, freq);
    >> +		aspeed_set_pwm_duty(priv, pwm, duty_pt);
    >> +		aspeed_set_pwm_polarity(priv, pwm, state->polarity);

    > How does the hardware behave between these calls? E.g. can it happen
    > that it already emits a normal period when inversed polarity is
    > requested just before aspeed_set_pwm_polarity is called? Or there is a
    > period with the previous duty cycle and the new period?

It will emits a normal period first and inversed the pwm duty instantly or wait one period 
after aspeed_set_pwm_polarity is called depends on the bit PWM_DUTY_SYNC_DIS.
Does the pwm driver have expected behavior when apply polarity changed?

    >> +	} else {
    >> +		aspeed_set_pwm_duty(priv, pwm, 0);
    >> +	}
    >> +	cur_state->period = state->period;
    >> +	cur_state->duty_cycle = state->duty_cycle;
    >> +	cur_state->polarity = state->polarity;
    >> +	cur_state->enabled = state->enabled;

    > The driver is not supposed to modify pwm->state.

Ok, I will remove it and use chip data to store it for .get_status api.

    >> +	return 0;
    >> +}

    > From your code I understood: The period of the signal is
    > 
    >	(PWM_PERIOD + 1) * (2 ** DIV_H) * (DIV_L + 1) / 200 MHz

    > . The duty cycle is
    >
    >	PWM_FALLING_POINT * (2 ** DIV_H) * (DIV_L + 1) / 200 MHz

    > . So the PWM cannot provide a 100% relative duty cycle.

    > Is this right?

No, If you want to set 100% duty cycle you can set the PWM_FALLING_POINT value 
to same as PWM_RISING_POINT (we fixed it to 0).

    >> +static const struct pwm_ops aspeed_pwm_ops = {
    >> +	.request = aspeed_pwm_request,
    >> +	.free = aspeed_pwm_free,
    >> +	.apply = aspeed_pwm_apply,

    > Please test your driver with PWM_DEBUG enabled.

Got it.

    >> +	.owner = THIS_MODULE,
    >> +};
    >> +
    >> +static int aspeed_pwm_probe(struct platform_device *pdev)
    >> +{
    >> +	struct device *dev = &pdev->dev;
    >> +	struct clk *clk;
    >> +	int ret;
    >> +	struct aspeed_pwm_data *priv;
    >> +	struct device_node *np;
    >> +
    >> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
    >> +	if (!priv)
    >> +		return -ENOMEM;
    >> +
    >> +	np = pdev->dev.parent->of_node;
    >> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach")) {
    >> +		dev_err(dev, "unsupported pwm device binding\n");
    >> +		return -ENODEV;
    >> +	}

    > Is this pwm-tach an mfd?

Yes, It is an mfd.

    >> +	priv->regmap = syscon_node_to_regmap(np);
    >> +	if (IS_ERR(priv->regmap)) {
    >> +		dev_err(dev, "Couldn't get regmap\n");
    >> +		return -ENODEV;
    >> +	}
    >> +
    >> +	clk = devm_clk_get(dev, NULL);
    >> +	if (IS_ERR(clk))
    >> +		return -ENODEV;
    >> +	priv->clk_freq = clk_get_rate(clk);

    > If you intend to use this clock, you have to enable it.

Got it.

    >> +	priv->reset = reset_control_get_shared(&pdev->dev, NULL);
    >> +	if (IS_ERR(priv->reset)) {
    >> +		dev_err(&pdev->dev, "can't get aspeed_pwm_tacho reset\n");
    >> +		return PTR_ERR(priv->reset);
    >> +	}
    >> +	reset_control_deassert(priv->reset);

    > missing error checking

Got it.

    >> +	priv->chip.dev = dev;
    >> +	priv->chip.ops = &aspeed_pwm_ops;
    >> +	priv->chip.base = -1;

    > This isn't necessary since f9a8ee8c8bcd118e800d88772c6457381db45224,
    > please drop the assignment to base.

Got it.

    >> +	priv->chip.npwm = ASPEED_NR_PWMS;
    >> +	priv->chip.of_xlate = of_pwm_xlate_with_flags;
    >> +	priv->chip.of_pwm_n_cells = 3;
    >> +
    >> +	ret = pwmchip_add(&priv->chip);
    >> +	if (ret < 0) {
    >> +		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);

    > Please use %pe to make the error messages better readable.

Got it.

    >> +		return ret;
    >> +	}
    >> +	dev_set_drvdata(dev, priv);
    >> +	return ret;
    >> +}
    >> +
    >> +static const struct of_device_id of_pwm_match_table[] = {
    >> +	{
    >> +		.compatible = "aspeed,ast2600-pwm",
    >> +	},
    >> +	{},
    >> +};
    >> +MODULE_DEVICE_TABLE(of, of_pwm_match_table);
    >> +
    >> +static struct platform_driver aspeed_pwm_driver = {
    >> +	.probe		= aspeed_pwm_probe,

    > Please implement a .remove callback.

Got it.

    >> +	.driver		= {
    >> +		.name	= "aspeed_pwm",
    >> +		.of_match_table = of_pwm_match_table,
    >> +	},
    >> +};

    Best regards
    Uwe

    -- 
    Pengutronix e.K.                           | Uwe Kleine-K?nig            |
    Industrial Linux Solutions                 | https://www.pengutronix.de/ |


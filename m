From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 22 Nov 2021 18:52:35 +0100
Subject: [PATCH/RFC 13/17] pinctl: ti: iodelay: Use bitfield helpers
In-Reply-To: <60257a3c5b567fb5b14d6f9adb770899bce88f7a.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <60257a3c5b567fb5b14d6f9adb770899bce88f7a.1637592133.git.geert+renesas@glider.be>
Message-ID: <YZvY4/FCgYMBMeDJ@piout.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Geert,

There is a typo in pinctrl in the subject

On 22/11/2021 16:54:06+0100, Geert Uytterhoeven wrote:
> Use the field_{get,prep}() helpers, instead of defining a custom
> function, or open-coding the same operations.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> Marked RFC, as this depends on [PATCH 01/17], but follows a different
> path to upstream.
> ---
>  drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 35 +++++++------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
> index 4e2382778d38f557..b220dcd9215520db 100644
> --- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
> +++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
> @@ -9,6 +9,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -155,18 +156,6 @@ struct ti_iodelay_device {
>  	struct ti_iodelay_reg_values reg_init_conf_values;
>  };
>  
> -/**
> - * ti_iodelay_extract() - extract bits for a field
> - * @val: Register value
> - * @mask: Mask
> - *
> - * Return: extracted value which is appropriately shifted
> - */
> -static inline u32 ti_iodelay_extract(u32 val, u32 mask)
> -{
> -	return (val & mask) >> __ffs(mask);
> -}
> -
>  /**
>   * ti_iodelay_compute_dpe() - Compute equation for delay parameter
>   * @period: Period to use
> @@ -233,10 +222,10 @@ static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
>  	}
>  
>  	reg_mask = reg->signature_mask;
> -	reg_val = reg->signature_value << __ffs(reg->signature_mask);
> +	reg_val = field_prep(reg->signature_mask, reg->signature_value);
>  
>  	reg_mask |= reg->binary_data_coarse_mask;
> -	tmp_val = c_elements << __ffs(reg->binary_data_coarse_mask);
> +	tmp_val = field_prep(reg->binary_data_coarse_mask, c_elements);
>  	if (tmp_val & ~reg->binary_data_coarse_mask) {
>  		dev_err(dev, "Masking overflow of coarse elements %08x\n",
>  			tmp_val);
> @@ -245,7 +234,7 @@ static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
>  	reg_val |= tmp_val;
>  
>  	reg_mask |= reg->binary_data_fine_mask;
> -	tmp_val = f_elements << __ffs(reg->binary_data_fine_mask);
> +	tmp_val = field_prep(reg->binary_data_fine_mask, f_elements);
>  	if (tmp_val & ~reg->binary_data_fine_mask) {
>  		dev_err(dev, "Masking overflow of fine elements %08x\n",
>  			tmp_val);
> @@ -260,7 +249,7 @@ static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
>  	 * impacting iodelay configuration. Use with care!
>  	 */
>  	reg_mask |= reg->lock_mask;
> -	reg_val |= reg->unlock_val << __ffs(reg->lock_mask);
> +	reg_val |= field_prep(reg->lock_mask, reg->unlock_val);
>  	r = regmap_update_bits(iod->regmap, cfg->offset, reg_mask, reg_val);
>  
>  	dev_dbg(dev, "Set reg 0x%x Delay(a: %d g: %d), Elements(C=%d F=%d)0x%x\n",
> @@ -296,16 +285,14 @@ static int ti_iodelay_pinconf_init_dev(struct ti_iodelay_device *iod)
>  	r = regmap_read(iod->regmap, reg->reg_refclk_offset, &val);
>  	if (r)
>  		return r;
> -	ival->ref_clk_period = ti_iodelay_extract(val, reg->refclk_period_mask);
> +	ival->ref_clk_period = field_get(reg->refclk_period_mask, val);
>  	dev_dbg(dev, "refclk_period=0x%04x\n", ival->ref_clk_period);
>  
>  	r = regmap_read(iod->regmap, reg->reg_coarse_offset, &val);
>  	if (r)
>  		return r;
> -	ival->coarse_ref_count =
> -	    ti_iodelay_extract(val, reg->coarse_ref_count_mask);
> -	ival->coarse_delay_count =
> -	    ti_iodelay_extract(val, reg->coarse_delay_count_mask);
> +	ival->coarse_ref_count = field_get(reg->coarse_ref_count_mask, val);
> +	ival->coarse_delay_count = field_get(reg->coarse_delay_count_mask, val);
>  	if (!ival->coarse_delay_count) {
>  		dev_err(dev, "Invalid Coarse delay count (0) (reg=0x%08x)\n",
>  			val);
> @@ -326,10 +313,8 @@ static int ti_iodelay_pinconf_init_dev(struct ti_iodelay_device *iod)
>  	r = regmap_read(iod->regmap, reg->reg_fine_offset, &val);
>  	if (r)
>  		return r;
> -	ival->fine_ref_count =
> -	    ti_iodelay_extract(val, reg->fine_ref_count_mask);
> -	ival->fine_delay_count =
> -	    ti_iodelay_extract(val, reg->fine_delay_count_mask);
> +	ival->fine_ref_count = field_get(reg->fine_ref_count_mask, val);
> +	ival->fine_delay_count = field_get(reg->fine_delay_count_mask, val);
>  	if (!ival->fine_delay_count) {
>  		dev_err(dev, "Invalid Fine delay count (0) (reg=0x%08x)\n",
>  			val);
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

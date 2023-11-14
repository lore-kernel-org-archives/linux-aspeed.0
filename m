From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 14 Nov 2023 06:52:39 -0800
Subject: [PATCH][next] hwmon: (aspeed-pwm-tacho) Fix -Wstringop-overflow
 warning in aspeed_create_fan_tach_channel()
In-Reply-To: <ZVJ7JBFoULzY3VGx@work>
References: <ZVJ7JBFoULzY3VGx@work>
Message-ID: <6a28c219-b047-411b-ab43-02fc8f1824db@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 13, 2023 at 01:38:12PM -0600, Gustavo A. R. Silva wrote:
> Based on the documentation below, the maximum number of Fan tach
> channels is 16:
> 
> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>  45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>  46                 integer value in the range 0 through 15, with 0 indicating
>  47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>  48                 At least one Fan tach input channel is required.
> 
> However, the compiler doesn't know that, and legitimaly warns about a potential
> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
> in case `index` takes a value outside the boundaries of the array:
> 

All that doesn't warrant introducing checkpatch warnings.

> drivers/hwmon/aspeed-pwm-tacho.c:
> 179 struct aspeed_pwm_tacho_data {
> ...
> 184         bool fan_tach_present[16];
> ...
> 193         u8 fan_tach_ch_source[16];
> ...
> 196 };
> 
> In function ?aspeed_create_fan_tach_channel?,
>     inlined from ?aspeed_create_fan? at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
>     inlined from ?aspeed_pwm_tacho_probe? at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
> drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>   751 |                 priv->fan_tach_ch_source[index] = pwm_source;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> drivers/hwmon/aspeed-pwm-tacho.c: In function ?aspeed_pwm_tacho_probe?:
> drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object ?fan_tach_ch_source? of size 16
>   193 |         u8 fan_tach_ch_source[16];
>       |            ^~~~~~~~~~~~~~~~~~
> 
> Fix this by sanity checking `index` before using it to index arrays of
> size 16 elements in `struct aspeed_pwm_tacho_data`. Also, and just for
> completeness, add a `pr_err()` message to display in the unlikely case
> `0 > index >= 16`.
> 
> This is probably the last remaining -Wstringop-overflow issue in the
> kernel, and this patch helps with the ongoing efforts to enable such
> compiler option globally.
> 

I am sorry, but this description almost completely misses the point.
The real issue is that the values in aspeed,fan-tach-ch are not range
checked, which can cause real problems if is elements are set to values
larger than 15. This is a real problem and has nothing to do with string
overflows.

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 997df4b40509..092a81916325 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -166,6 +166,8 @@
>  
>  #define MAX_CDEV_NAME_LEN 16
>  
> +#define MAX_ASPEED_FAN_TACH_CHANNELS 16
> +
>  struct aspeed_cooling_device {
>  	char name[16];
>  	struct aspeed_pwm_tacho_data *priv;
> @@ -181,7 +183,7 @@ struct aspeed_pwm_tacho_data {
>  	struct reset_control *rst;
>  	unsigned long clk_freq;
>  	bool pwm_present[8];
> -	bool fan_tach_present[16];
> +	bool fan_tach_present[MAX_ASPEED_FAN_TACH_CHANNELS];
>  	u8 type_pwm_clock_unit[3];
>  	u8 type_pwm_clock_division_h[3];
>  	u8 type_pwm_clock_division_l[3];
> @@ -190,7 +192,7 @@ struct aspeed_pwm_tacho_data {
>  	u16 type_fan_tach_unit[3];
>  	u8 pwm_port_type[8];
>  	u8 pwm_port_fan_ctrl[8];
> -	u8 fan_tach_ch_source[16];
> +	u8 fan_tach_ch_source[MAX_ASPEED_FAN_TACH_CHANNELS];
>  	struct aspeed_cooling_device *cdev[8];
>  	const struct attribute_group *groups[3];
>  };
> @@ -746,10 +748,14 @@ static void aspeed_create_fan_tach_channel(struct aspeed_pwm_tacho_data *priv,
>  
>  	for (val = 0; val < count; val++) {
>  		index = fan_tach_ch[val];
> -		aspeed_set_fan_tach_ch_enable(priv->regmap, index, true);
> -		priv->fan_tach_present[index] = true;
> -		priv->fan_tach_ch_source[index] = pwm_source;
> -		aspeed_set_fan_tach_ch_source(priv->regmap, index, pwm_source);
> +		if (index < MAX_ASPEED_FAN_TACH_CHANNELS) {
> +			aspeed_set_fan_tach_ch_enable(priv->regmap, index, true);
> +			priv->fan_tach_present[index] = true;
> +			priv->fan_tach_ch_source[index] = pwm_source;
> +			aspeed_set_fan_tach_ch_source(priv->regmap, index, pwm_source);
> +		} else {
> +			pr_err("Invalid Fan Tach input channel %u\n.", index);

This should use dev_err() (and, yes, that means dev needs to be passed
as argument), and the function should return -EINVAL if this is
encountered. Also, error handling should come first.

		if (index >= MAX_ASPEED_FAN_TACH_CHANNELS) {
			dev_err(dev, "Invalid Fan Tach input channel %u\n.", index);
			return -EINVAL;
		}

Thanks,
Guenter

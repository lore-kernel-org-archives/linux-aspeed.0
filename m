From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 3 Jul 2020 15:17:44 -0700
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Avoid possible buffer overflow
In-Reply-To: <20200703111518.9644-1-novikov@ispras.ru>
References: <20200703111518.9644-1-novikov@ispras.ru>
Message-ID: <20200703221744.GA34644@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 03, 2020 at 02:15:18PM +0300, Evgeny Novikov wrote:
> aspeed_create_fan() reads a pwm_port value using of_property_read_u32().
> If pwm_port will be more than ARRAY_SIZE(pwm_port_params), there will be
> a buffer overflow in
> aspeed_create_pwm_port()->aspeed_set_pwm_port_enable(). The patch fixes
> the potential buffer overflow.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 33fb54845bf6..3d8239fd66ed 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -851,6 +851,8 @@ static int aspeed_create_fan(struct device *dev,
>  	ret = of_property_read_u32(child, "reg", &pwm_port);
>  	if (ret)
>  		return ret;
> +	if (pwm_port >= ARRAY_SIZE(pwm_port_params))
> +		return -EINVAL;
>  	aspeed_create_pwm_port(priv, (u8)pwm_port);
>  
>  	ret = of_property_count_u8_elems(child, "cooling-levels");

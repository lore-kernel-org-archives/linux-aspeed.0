From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 05 Oct 2023 11:42:12 +1030
Subject: [PATCH] gpio: aspeed: fix the GPIO number passed to
 pinctrl_gpio_set_config()
In-Reply-To: <20231003073926.10771-1-brgl@bgdev.pl>
References: <20231003073926.10771-1-brgl@bgdev.pl>
Message-ID: <b5b813d156c31d73baf1e153f495e69d3367718b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2023-10-03 at 09:39 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> pinctrl_gpio_set_config() expects the GPIO number from the global GPIO
> numberspace, not the controller-relative offset, which needs to be added
> to the chip base.
> 
> Fixes: 5ae4cb94b313 ("gpio: aspeed: Add debounce support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks!

> ---
>  drivers/gpio/gpio-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index da33bbbdacb9..58f107194fda 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
>  	else if (param == PIN_CONFIG_BIAS_DISABLE ||
>  			param == PIN_CONFIG_BIAS_PULL_DOWN ||
>  			param == PIN_CONFIG_DRIVE_STRENGTH)
> -		return pinctrl_gpio_set_config(offset, config);
> +		return pinctrl_gpio_set_config(chip->base + offset, config);
>  	else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
>  			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
>  		/* Return -ENOTSUPP to trigger emulation, as per datasheet */


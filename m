From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 25 Oct 2017 09:32:01 +0100
Subject: [PATCH 1/2] gpio: gpiolib: Expand sleep tolerance to include
 controller reset
In-Reply-To: <20171025050417.27992-2-andrew@aj.id.au>
References: <20171025050417.27992-1-andrew@aj.id.au>
 <20171025050417.27992-2-andrew@aj.id.au>
Message-ID: <20171025083201.wdudlzgphypyhmwc@localhost.localdomain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 25, 2017 at 03:34:16PM +1030, Andrew Jeffery wrote:
> Reset tolerance is added to gpiolib with the introduction of a new
> pinconf parameter propagating the request to hardware. The existing
> persistence support for sleep is augmented to include reset tolerance
> if the GPIO driver provides it. Persistence continues to be enabled by
> default; in-kernel consumers can opt out, but userspace (currently) does
> not have a choice.
> 
> The *_SLEEP_MAY_LOSE_VALUE and *_SLEEP_MAINTAIN_VALUE symbols are
> renamed, dropping the SLEEP prefix to reflect that the concept is no
> longer sleep-specific.  I feel that renaming to just *_MAY_LOSE_VALUE
> could initially be misinterpreted, so I've further changed the symbols
> to *_TRANSITORY and *_PERSISTENT to address this.
> 
> The sysfs interface is modified only to keep consistency with the
> chardev interface in enforcing persistence for userspace exports.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> I'm not wedded to the names 'transitory' and 'persistent', so feel free to
> paint the bikeshed some other colour.
> 

I am happy enough with the names.

>  drivers/gpio/gpiolib-of.c               |  6 ++--
>  drivers/gpio/gpiolib-sysfs.c            | 14 +++++---
>  drivers/gpio/gpiolib.c                  | 58 ++++++++++++++++++++++++++++++---
>  drivers/gpio/gpiolib.h                  |  2 +-
>  include/dt-bindings/gpio/gpio.h         |  6 ++--
>  include/linux/gpio/consumer.h           |  8 +++++
>  include/linux/gpio/machine.h            |  4 +--
>  include/linux/of_gpio.h                 |  2 +-
>  include/linux/pinctrl/pinconf-generic.h |  2 ++
>  9 files changed, 84 insertions(+), 18 deletions(-)

> @@ -2424,6 +2428,46 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
>  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
>  
>  /**
> + * gpiod_set_transitory - Lose or retain GPIO state on suspend or reset
> + * @desc: descriptor of the GPIO for which to configure persistence
> + * @transitory: True to lose state on suspend or reset, false for persistence
> + *
> + * Returns:
> + * 0 on success, otherwise a negative error code.
> + */
> +int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
> +{
> +	struct gpio_chip *chip;
> +	unsigned long packed;
> +	int gpio;
> +	int rc;
> +
> +	/* Handle FLAG_TRANSITORY first for suspend case */
> +	if (transitory)
> +		set_bit(FLAG_TRANSITORY, &desc->flags);
> +	else
> +		clear_bit(FLAG_TRANSITORY, &desc->flags);
> +
> +	/* Configure reset persistence if the controller supports it */
> +	chip = desc->gdev->chip;
> +	if (!chip->set_config)
> +		return 0;
> +
> +	packed = pinconf_to_config_packed(PIN_CONFIG_RESET_TOLERANT,
> +					  !transitory);
> +	gpio = gpio_chip_hwgpio(desc);
> +	rc = chip->set_config(chip, gpio, packed);
> +	if (rc == -ENOTSUPP) {
> +		dev_dbg(&desc->gdev->dev, "Reset tolerance not supported for GPIO %d\n",
> +				gpio);
> +		return 0;
> +	}
> +
> +	return rc;

This means that if we have a set_config we are directly
equating PERSISTENT to RESET_TOLERANT, which seems wrong to
me. I might have a GPIO on a controller with pinconf that
doesn't have anything to do with RESET_TOLERANT. Should the
PIN_CONFIG_RESET_TOLERANT, really just be PIN_CONFIG_PERSISTENT?
And then its upto the driver what persistence means for that
chip?

Thanks,
Charles

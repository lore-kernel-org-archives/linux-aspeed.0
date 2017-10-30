From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 30 Oct 2017 09:57:26 +0000
Subject: [PATCH v2 1/2] gpio: gpiolib: Generalise state persistence
 beyond sleep
In-Reply-To: <20171030062218.27005-2-andrew@aj.id.au>
References: <20171030062218.27005-1-andrew@aj.id.au>
 <20171030062218.27005-2-andrew@aj.id.au>
Message-ID: <20171030095726.a43lpshlyfta4vrq@localhost.localdomain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 30, 2017 at 04:52:17PM +1030, Andrew Jeffery wrote:
> General support for state persistence is added to gpiolib with the
> introduction of a new pinconf parameter to propagate the request to
> hardware. The existing persistence support for sleep is adapted to
> include hardware support if the GPIO driver provides it. Persistence
> continues to be enabled by default; in-kernel consumers can opt out, but
> userspace (currently) does not have a choice.
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

This comment could use an update.

> +	chip = desc->gdev->chip;
> +	if (!chip->set_config)
> +		return 0;
> +
> +	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
> +					  !transitory);
> +	gpio = gpio_chip_hwgpio(desc);
> +	rc = chip->set_config(chip, gpio, packed);
> +	if (rc == -ENOTSUPP) {
> +		dev_dbg(&desc->gdev->dev, "Reset tolerance not supported for GPIO %d\n",
> +				gpio);

And this debug message.

> +		return 0;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(gpiod_set_transitory);
> +

Otherwise think this all looks good to me.

Thanks,
Charles

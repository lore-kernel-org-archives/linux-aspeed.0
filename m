From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 26 Oct 2017 11:10:53 +1030
Subject: [PATCH 1/2] gpio: gpiolib: Expand sleep tolerance to include
 controller reset
In-Reply-To: <20171025083201.wdudlzgphypyhmwc@localhost.localdomain>
References: <20171025050417.27992-1-andrew@aj.id.au>
 <20171025050417.27992-2-andrew@aj.id.au>
 <20171025083201.wdudlzgphypyhmwc@localhost.localdomain>
Message-ID: <1508978453.13477.7.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 2017-10-25 at 09:32 +0100, Charles Keepax wrote:
> On Wed, Oct 25, 2017 at 03:34:16PM +1030, Andrew Jeffery wrote:
> Reset tolerance is added to gpiolib with the introduction of a new
> pinconf parameter propagating the request to hardware. The existing
> persistence support for sleep is augmented to include reset tolerance
> if the GPIO driver provides it. Persistence continues to be enabled by
> default; in-kernel consumers can opt out, but userspace (currently) does
> not have a choice.
> 
> The *_SLEEP_MAY_LOSE_VALUE and *_SLEEP_MAINTAIN_VALUE symbols are
> renamed, dropping the SLEEP prefix to reflect that the concept is no
> longer sleep-specific.  I feel that renaming to just *_MAY_LOSE_VALUE
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
> 
> I am happy enough with the names.
> 
>  drivers/gpio/gpiolib-of.c               |  6 ++--
>  drivers/gpio/gpiolib-sysfs.c            | 14 +++++---
>  drivers/gpio/gpiolib.c                  | 58 ++++++++++++++++++++++++++++++---
>  drivers/gpio/gpiolib.h                  |  2 +-
>  include/dt-bindings/gpio/gpio.h         |  6 ++--
>  include/linux/gpio/consumer.h           |  8 +++++
>  include/linux/gpio/machine.h            |  4 +--
>  include/linux/of_gpio.h                 |  2 +-
>  include/linux/pinctrl/pinconf-generic.h |  2 ++
>  9 files changed, 84 insertions(+), 18 deletions(-)
> @@ -2424,6 +2428,46 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
>  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
>  
>  /**
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
> +					  !transitory);
> +	gpio = gpio_chip_hwgpio(desc);
> +	rc = chip->set_config(chip, gpio, packed);
> +	if (rc == -ENOTSUPP) {
> +		dev_dbg(&desc->gdev->dev, "Reset tolerance not supported for GPIO %d\n",
> +				gpio);
> +		return 0;
> +	}
> +
> +	return rc;
> 
> This means that if we have a set_config we are directly
> equating PERSISTENT to RESET_TOLERANT, which seems wrong to
> me. I might have a GPIO on a controller with pinconf that
> doesn't have anything to do with RESET_TOLERANT. Should the
> PIN_CONFIG_RESET_TOLERANT, really just be PIN_CONFIG_PERSISTENT?
> And then its upto the driver what persistence means for that
> chip?

Right, maybe I'm tying the design in a bit too closely with the Aspeed hardware
again. I'm coming out in favour of changing it based on my thoughts below.

However, I want to understand whether there are alternatives to reset tolerance
as a property. The obvious one is sleep persistence as implemented in the
Arizona driver, but it didn't take the set_config() route with its initial
implementation.

The set_config() approach was largely driven by the sysfs patch in
the RFC series, because I wanted a way to propagate the desired property
to hardware without affecting (or again calling through the handlers for) the
export state or direction. It seemed to come out neat enough in general so I
kept it.

Were you thinking of using set_config() to control the Arizona's behaviour and
do something other than the calls to gpiochip_line_is_persistent() in
arizona_gpio_direction_{in,out}() (as in, keep the state inside the device
driver rather than querying gpiolib where the state is currently stored)? That
would seem neat in that it gives us one method of setting both persistence
types (and in this case I should rename the pinconf parameter). With that we
could probably get rid of gpiochip_line_is_persistent(). A small downside is
some duplicated state (we probably still want to keep FLAG_TRANSITORY in
gpiolib).

Would it be reasonable for other drivers to implement sleep persistence in the
same manner as the Arizona driver currently does? If that's the case, I don't
think there is a third tolerance option in addition to sleep and reset, and so
we might not need to rename the pinconf parameter.

Finally, we could implement reset persistence in the same manner as the
Arizona's sleep persistence (with gpiochip_line_is_persistent()) given the
sysfs patch has been thrown away.

So to summarise, having rambled a bit, I see the situation as:

1. Rename the pinconf parameter, and patch the Arizona driver to use
   set_config() and hold sleep persistence state internally.
2. Drop the pinconf parameter and do something similar to the Arizona's sleep
   persistence for reset persistence in the Aspeed driver.
3. Keep things as proposed are and live with two approaches to persistence

Point 3 seems like the least desirable. I'm leaning towards 1. I could probably
live with 2. after experimenting with it and confirming it's workable for me.

If you think 1. is the way to go are you happy for me to send a patch to the
Arizona driver implementing the change?

Thanks for the feedback!

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20171026/930fc845/attachment.sig>

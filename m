From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Jul 2021 11:15:16 +0300
Subject: [RFC PATCH 0/6] leds: Fix pca955x GPIO pin mappings
In-Reply-To: <20210723075858.376378-1-andrew@aj.id.au>
References: <20210723075858.376378-1-andrew@aj.id.au>
Message-ID: <CAHp75VeQML7njMZ6x8kC-ZJVexC1xJ6n1cB3JneVMAVfuOJgWw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Friday, July 23, 2021, Andrew Jeffery <andrew@aj.id.au> wrote:

> Hello,
>
> This series does a bunch of crimes, so it's an RFC. I'm cross-posting to
> the
> pinctrl/GPIO and LEDs lists because the PCA955x devices impact all of
> them. What
> needs fixing is the leds-pca955x driver's failure to map the GPIO
> numberspace to
> the pin numberspace of the PCA955x devices. The series solves that by
> implementing pinctrl and pinmux in the leds-pca955x driver.
>
> Things I'm unsure about:
>
> 1. Patch 1: The pinctrl_gpio_as_pin() API feels a bit dirty, not sure what
>    others thoughts are on that (Linus?).
>
> 2. Patch 2: I've added a new callback to hook the entirety of the pinctrl
> map
>    parsing rather than supplying a subnode-specific callback. This was
> necessary
>    to handle the PCA955x devicetree binding in a backwards compatible way.
>
> 3. Patch 4: The PCA955x devices don't actually have any pinmux hardware,
> but the
>    properties of the pinctrl/pinmux subsystems in the kernel map nicely
> onto the
>    problem we have. But it's quite a bit of code...
>
> 4. Patch 6: I also lost a bunch of time to overlooking the get_group_pins()
>    callback for pinctrl, and it seems odd to me that it isn't required.
>
> Please review!



Sounds like a hack. I was briefly looking into patches 1-4 and suddenly
realized that the fix can be similar as in PCA9685 (PWM), I.e. we always
have chips for the entire pin space and one may map them accordingly,
requested in one realm (LED) in the other (GPIO) automatically is BUSY. Or
I missed the point?


>
> Andrew
>
> Andrew Jeffery (6):
>   pinctrl: Add pinctrl_gpio_as_pin()
>   pinctrl: Add hook for device-specific map parsing
>   leds: pca955x: Relocate chipdef-related descriptors
>   leds: pca955x: Use pinctrl to map GPIOs to pins
>   ARM: dts: rainier: Add presence-detect and fault indictor GPIO
>     expander
>   pinctrl: Check get_group_pins callback on init
>
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |  76 +++
>  drivers/leds/leds-pca955x.c                  | 554 +++++++++++++++----
>  drivers/pinctrl/core.c                       |  28 +-
>  include/linux/pinctrl/pinctrl.h              |   4 +
>  4 files changed, 566 insertions(+), 96 deletions(-)
>
> --
> 2.30.2
>
>

-- 
With Best Regards,
Andy Shevchenko
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210723/b6c4d398/attachment.htm>

From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Oct 2017 09:27:39 +0200
Subject: [RFC PATCH 3/5] gpio: gpiolib: Add chardev support for
 maintaining GPIO values on reset
In-Reply-To: <20171020033727.21557-4-andrew@aj.id.au>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-4-andrew@aj.id.au>
Message-ID: <CACRpkdY4F-ocFxomLEsVyGA0odGooWysQq5MHi9qwUt6E_VDzA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I paged Bartosz and Michael on this, they are experts on the use cases for
the character device and their opinions are likely more valuable than mine.

On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> Similar to devicetree support, add flags and mappings to expose reset
> tolerance configuration through the chardev interface.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
(...)

> +                * Unconditionally configure reset tolerance, as it's possible
> +                * that the tolerance flag itself becomes tolerant to resets.
> +                * Thus it could remain set from a previous environment, but
> +                * the current environment may not expect it so.
> +                */
> +               ret = gpiod_set_reset_tolerant(desc,
> +                               !!(lflags & GPIOHANDLE_REQUEST_RESET_TOLERANT));
> +               if (ret < 0)
> +                       goto out_free_descs;

First, as noted in the first patch, IMO we should just go for persistance,
i.e. you want to flag to the system to keep the line persistent in any case,
no matter if the system goes to sleep or resets.

So the usecase is going to be a control system or similar, a makerspace
project, an industrial product of some kind, driving GPIO from userspace.

I don't see it as helpful to give userspace control over whether the line
is persistent or not. It is more reasonable to assume persistance for
userspace use cases, don't you think? Whether the system goes to sleep
or the gpiochip resets should not make a door suddenly close or the
lights in the christmas tree go out, right? I think if the gpiochip supports
persistance of any kind, we should try to use it and not have userspace
provide flags for that.

Yours,
Linus Walleij

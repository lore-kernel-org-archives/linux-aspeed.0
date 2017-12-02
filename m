From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 2 Dec 2017 16:20:37 +0100
Subject: [PATCH v4 1/2] gpio: gpiolib: Generalise state persistence beyond
 sleep
In-Reply-To: <20171130035525.29653-2-andrew@aj.id.au>
References: <20171130035525.29653-1-andrew@aj.id.au>
 <20171130035525.29653-2-andrew@aj.id.au>
Message-ID: <CACRpkda2ix77k3noL3Ze6L3=g8cH_+DK1-HUh6fMkWnSJ1SfUw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 30, 2017 at 4:55 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

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
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Rob Herring <robh@kernel.org>

Nice work, patch applied!

> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 3f454eaf2101..0bd472ffb072 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -474,11 +474,15 @@ static ssize_t export_store(struct class *class,
>                         status = -ENODEV;
>                 goto done;
>         }
> -       status = gpiod_export(desc, true);
> -       if (status < 0)
> -               gpiod_free(desc);
> -       else
> -               set_bit(FLAG_SYSFS, &desc->flags);
> +
> +       status = gpiod_set_transitory(desc, false);
> +       if (!status) {
> +               status = gpiod_export(desc, true);
> +               if (status < 0)
> +                       gpiod_free(desc);
> +               else
> +                       set_bit(FLAG_SYSFS, &desc->flags);
> +       }

Part of me just wanna drop this hunk of the patch and let
the old sysfs ABI rot.

But I guess that is especially malevolent so I will abstain.


Yours,
Linus Walleij

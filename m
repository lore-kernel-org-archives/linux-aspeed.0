From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 4 Oct 2023 09:13:49 +0200
Subject: [PATCH 08/36] gpio: aspeed: use new pinctrl GPIO helpers
In-Reply-To: <6608b6ea673454672fb5930b57e9e7a5570d96d5.camel@codeconstruct.com.au>
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-9-brgl@bgdev.pl>
 <6608b6ea673454672fb5930b57e9e7a5570d96d5.camel@codeconstruct.com.au>
Message-ID: <CAMRc=MfrJHWppvWv=Gh0cQRjFG69UoqLyguu-zE2NB6Yga-3xA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 4, 2023 at 1:30?AM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Tue, 2023-10-03 at 16:50 +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Replace the pinctrl helpers taking the global GPIO number as argument
> > with the improved variants that instead take a pointer to the GPIO chip
> > and the controller-relative offset.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpio-aspeed.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> > index da33bbbdacb9..d3aa1cfd4ace 100644
> > --- a/drivers/gpio/gpio-aspeed.c
> > +++ b/drivers/gpio/gpio-aspeed.c
> > @@ -750,12 +750,12 @@ static int aspeed_gpio_request(struct gpio_chip *chip, unsigned int offset)
> >       if (!have_gpio(gpiochip_get_data(chip), offset))
> >               return -ENODEV;
> >
> > -     return pinctrl_gpio_request(chip->base + offset);
> > +     return pinctrl_gpio_request_new(chip, offset);
> >  }
> >
> >  static void aspeed_gpio_free(struct gpio_chip *chip, unsigned int offset)
> >  {
> > -     pinctrl_gpio_free(chip->base + offset);
> > +     pinctrl_gpio_free_new(chip, offset);
> >  }
> >
> >  static int usecs_to_cycles(struct aspeed_gpio *gpio, unsigned long usecs,
> > @@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> >       else if (param == PIN_CONFIG_BIAS_DISABLE ||
> >                       param == PIN_CONFIG_BIAS_PULL_DOWN ||
> >                       param == PIN_CONFIG_DRIVE_STRENGTH)
> > -             return pinctrl_gpio_set_config(offset, config);
> > +             return pinctrl_gpio_set_config_new(chip, offset, config);
>
> Ah, this looks like it removes a bug too. Nice.
>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>
> >       else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
> >                       param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
> >               /* Return -ENOTSUPP to trigger emulation, as per datasheet */
>

I sent a separate patch that fixes this issue for backporting, once
the other one is in next, we can update this series.

Bart

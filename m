From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 25 Mar 2019 09:28:43 +0100
Subject: [PATCH] gpio: fix a potential NULL pointer dereference
In-Reply-To: <f4d27985-376a-42bb-b781-bdc96c0cef21@www.fastmail.com>
References: <20190324231002.2106-1-kjlu@umn.edu>
 <f4d27985-376a-42bb-b781-bdc96c0cef21@www.fastmail.com>
Message-ID: <CAMpxmJU+Uh_oBqmCWmdpVQv52Duu6A3c+RGiL=tOYkqFUoX0ag@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

pon., 25 mar 2019 o 00:12 Andrew Jeffery <andrew@aj.id.au> napisa?(a):
>
>
>
> On Mon, 25 Mar 2019, at 09:40, Kangjie Lu wrote:
> > In case devm_kzalloc, the patch returns ENOMEM to avoid potential
> > NULL pointer dereference.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>
> > ---
> >  drivers/gpio/gpio-aspeed.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> > index 854bce4fb9e7..217507002dbc 100644
> > --- a/drivers/gpio/gpio-aspeed.c
> > +++ b/drivers/gpio/gpio-aspeed.c
> > @@ -1224,6 +1224,8 @@ static int __init aspeed_gpio_probe(struct
> > platform_device *pdev)
> >
> >       gpio->offset_timer =
> >               devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
> > +     if (!gpio->offset_timer)
> > +             return -ENOMEM;
> >
> >       return aspeed_gpio_setup_irqs(gpio, pdev);
> >  }
> > --
> > 2.17.1
> >
> >

Applied to fixes.

Bart

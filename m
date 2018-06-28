From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Jun 2018 15:42:38 +0200
Subject: [PATCH 4/4] gpio: aspeed: Add interfaces for co-processor to grab
 GPIOs
In-Reply-To: <480dd5a586acfaaeddcd099e3f1854f27fa44522.camel@kernel.crashing.org>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <20180612001043.9327-5-benh@kernel.crashing.org>
 <CACRpkdbup=bx3rnZbWBMD_p2+8EHkY9Mxc2UEOwHzZE10=VeQA@mail.gmail.com>
 <480dd5a586acfaaeddcd099e3f1854f27fa44522.camel@kernel.crashing.org>
Message-ID: <CACRpkdYjUX4JtEW0+0Gxjfp5gSNKp8PM7CPY_nf=nQb=rfHRBQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 15, 2018 at 1:41 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2018-06-14 at 10:59 +0200, Linus Walleij wrote:
> >
> > Overall looks fine!
> >
> > You definately need something like this for handling this special case.
> >
> > > +#include <linux/gpio/consumer.h>
> >
> > Why do you need this?
> >
> > I don't see that you use any functions from it.
> >
> > > +#include "gpiolib.h"
> >
> > I'm not so happy about this either, what is this needed for?
> >
> > It seems to me you can remove both includes, but admittedly I miss
> > fine details all the time.
>
> I wish I could :-) This is the main wart in there to be honest.
>
> consumer.h is needed to build gpiolib.h
>
> gpiolib.h is needed for gpio_chip_hwgpio() which needs the definition
> of gpio_desc, etc...

Aha I see, you need that because while normally the gpiolib
does the conversion of desc -> offset this is needed here
in a driver.

Maybe we should just name it gpiod_to_offset() or something
and make it a public API.

But this is actually OK, you definately need it here, toss in some
comment or so about what is going on and why this is included
so we know in the future.

Yours,
Linus Walleij

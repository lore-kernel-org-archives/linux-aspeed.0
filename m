From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 15 Jun 2018 09:40:53 +1000
Subject: [PATCH 4/4] gpio: aspeed: Add interfaces for co-processor to
 grab GPIOs
In-Reply-To: <CACRpkdbup=bx3rnZbWBMD_p2+8EHkY9Mxc2UEOwHzZE10=VeQA@mail.gmail.com>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <20180612001043.9327-5-benh@kernel.crashing.org>
 <CACRpkdbup=bx3rnZbWBMD_p2+8EHkY9Mxc2UEOwHzZE10=VeQA@mail.gmail.com>
Message-ID: <480dd5a586acfaaeddcd099e3f1854f27fa44522.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2018-06-14 at 10:59 +0200, Linus Walleij wrote:
> 
> Overall looks fine!
> 
> You definately need something like this for handling this special case.
> 
> > +#include <linux/gpio/consumer.h>
> 
> Why do you need this?
> 
> I don't see that you use any functions from it.
> 
> > +#include "gpiolib.h"
> 
> I'm not so happy about this either, what is this needed for?
> 
> It seems to me you can remove both includes, but admittedly I miss
> fine details all the time.

I wish I could :-) This is the main wart in there to be honest.

consumer.h is needed to build gpiolib.h

gpiolib.h is needed for gpio_chip_hwgpio() which needs the definition
of gpio_desc, etc...

I didn't find a simple way out if it... the "API" I expose to the copro
driver takes a gpio_desc which is the clean thing to do but I can't get
to the underlying GPIO number without gpiolib.

Cheers,
Ben.


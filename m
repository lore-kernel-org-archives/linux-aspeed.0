From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Jun 2018 10:59:25 +0200
Subject: [PATCH 4/4] gpio: aspeed: Add interfaces for co-processor to grab
 GPIOs
In-Reply-To: <20180612001043.9327-5-benh@kernel.crashing.org>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <20180612001043.9327-5-benh@kernel.crashing.org>
Message-ID: <CACRpkdbup=bx3rnZbWBMD_p2+8EHkY9Mxc2UEOwHzZE10=VeQA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 12, 2018 at 2:10 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> On the Aspeed chip, the GPIOs can be under control of the ARM
> chip or of the ColdFire coprocessor. (There's a third command
> source, the LPC bus, which we don't use or support yet).
>
> The control of which master is allowed to modify a given
> GPIO is per-bank (8 GPIOs).
>
> Unfortunately, systems already exist for which we want to
> use GPIOs of both sources in the same bank.
>
> This provides an API exported by the gpio-aspeed driver
> that an aspeed coprocessor driver can use to "grab" some
> GPIOs for use by the coprocessor, and allow the coprocessor
> driver to provide callbacks for arbitrating access.
>
> Once at least one GPIO of a given bank has been "grabbed"
> by the coprocessor, the entire bank is marked as being
> under coprocessor control. It's command source is switched
> to the coprocessor.
>
> If the ARM then tries to write to a GPIO in such a marked bank,
> the provided callbacks are used to request access from the
> coprocessor driver, which is responsible to doing whatever
> is necessary to "pause" the coprocessor or prevent it from
> trying to use the GPIOs while the ARM is doing its accesses.
>
> During that time, the command source for the bank is temporarily
> switched back to the ARM.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Overall looks fine!

You definately need something like this for handling this special case.

> +#include <linux/gpio/consumer.h>

Why do you need this?

I don't see that you use any functions from it.

> +#include "gpiolib.h"

I'm not so happy about this either, what is this needed for?

It seems to me you can remove both includes, but admittedly I miss
fine details all the time.

Yours,
Linus Walleij

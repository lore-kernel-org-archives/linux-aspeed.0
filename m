From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Jan 2021 15:40:57 +0100
Subject: [PATCH, v1 1/1] gpio: aspeed: Add gpio base address reading
In-Reply-To: <20210113223808.31626-2-hongweiz@ami.com>
References: <20210113223808.31626-1-hongweiz@ami.com>
 <20210113223808.31626-2-hongweiz@ami.com>
Message-ID: <CACRpkdYpPkCvoEHH6Nu1LPv24JwRWANRTiwVa9cvjZaJeaa02Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 13, 2021 at 11:38 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add gpio base address reading in the driver; in old code, it just
> returns -1 to gpio->chip.base.
>
> Fixes: 7ee2d5b4d4340353 ("ARM: dts: nuvoton: Add Fii Kudo system")
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

NAK, sorry.

We never allow the device tree to specify this.

First, it is a Linux-only base so it would have to be a
"linux,..." property.

Even if it is a Linux-only property, it is a bad idea.

Only people using sysfs should have any need to specify global
GPIO numbers. Don't use sysfs. Use the GPIO character device
instead. See further:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/TODO

Yours,
Linus Walleij

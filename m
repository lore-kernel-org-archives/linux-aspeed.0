From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Jul 2019 01:37:33 +0200
Subject: [v5 2/2] gpio: aspeed: Add SGPIO driver
In-Reply-To: <1563827815-15092-1-git-send-email-hongweiz@ami.com>
References: <1563564291-9692-3-git-send-email-hongweiz@ami.com>
 <1563827815-15092-1-git-send-email-hongweiz@ami.com>
Message-ID: <CACRpkdbkLj7WDMp7vtNDR81yezw-zPq3MWvVRLKvpkvAueo0uw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 22, 2019 at 10:37 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> As you suspected it correctly, AST2500 utilizes all the 32 bits of the registers
> (data value, interrupt, etc...), such that using 8-bit bands
> [7:0]/[15:8]/23:16]/[31:24] of GPIO_200H for SGPIO_A/B/C/D .
> so registering 10 gpiochip drivers separately will make code more
> complicated, for example gpio_200 register (data_value reg) has to be
> shared by 4 gpiochip instances, and the same is true for gpio204 (interrupt reg),
> and other more registers.
> So we would prefer to keeping current implementation.

OK this is a pretty good argument. My review assumed one
32-bit register was not shared between banks but it is,
I see.

The above situation can be managed by regmap, but that will
just a different complexity so go with this approach then.

Yours,
Linus Walleij

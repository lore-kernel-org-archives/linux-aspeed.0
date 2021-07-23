From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Jul 2021 12:00:28 +0200
Subject: [PATCH v6 9/9] gpio: gpio-aspeed-sgpio: Return error if ngpios is
 not multiple of 8.
In-Reply-To: <20210712100317.23298-10-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
 <20210712100317.23298-10-steven_lee@aspeedtech.com>
Message-ID: <CACRpkdZkcQyN-JuNF24gHkNOx3uk9PEWD18-0k49fV-UO=ZB2A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 12, 2021 at 12:04 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> Add an else-if condition in the probe function to check whether ngpios is
> multiple of 8.
> Per AST datasheet, numbers of available serial GPIO pins in Serial GPIO
> Configuration Register must be n bytes. For instance, if n = 1, it means
> AST SoC supports 8 GPIO pins.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

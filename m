From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Jul 2021 11:59:18 +0200
Subject: [PATCH v6 7/9] gpio: gpio-aspeed-sgpio: Move irq_chip to
 aspeed-sgpio struct
In-Reply-To: <20210712100317.23298-8-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
 <20210712100317.23298-8-steven_lee@aspeedtech.com>
Message-ID: <CACRpkdZh1TW32bqb91+g8OWkXBVDt0vsoObJ6GCX3LL+86_daQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 12, 2021 at 12:04 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> The current design initializes irq->chip from a global irqchip struct,
> which causes multiple sgpio devices use the same irq_chip.
> The patch moves irq_chip to aspeed_sgpio struct for initializing
> irq_chip from their private gpio struct.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

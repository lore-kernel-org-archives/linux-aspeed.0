From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Mar 2023 08:38:11 +0100
Subject: [PATCH] gpio: aspeed: Always register the irqchip
In-Reply-To: <20230309050855.3311834-1-joel@jms.id.au>
References: <20230309050855.3311834-1-joel@jms.id.au>
Message-ID: <CACRpkdba--WpCGEF7jF=oWowps1JpieoTo6UswcCZyvs2s5z6g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 9, 2023 at 6:09?AM Joel Stanley <joel@jms.id.au> wrote:

> The driver was implemented in a way that made the irqchip optional, if a
> irq was not present in the device tree. However, all of the device trees
> have always had an irq, so the optional-ness has never been used.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Linus, feel free to put this in your immutable gpiochip series

Perfect, I will merge it into my v3 set to help Bartosz avoid merge
conflicts.

Yours,
Linus Walleij

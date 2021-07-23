From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Jul 2021 11:58:34 +0200
Subject: [PATCH v6 6/9] gpio: gpio-aspeed-sgpio: Add set_config function
In-Reply-To: <20210712100317.23298-7-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
 <20210712100317.23298-7-steven_lee@aspeedtech.com>
Message-ID: <CACRpkdbKyV_Crw8MS63SZGf=nKztDkKnJgRprLdvXe0u7BmVNg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 12, 2021 at 12:04 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> AST SoC supports *retain pin state* function when wdt reset.
> The patch adds set_config function for handling sgpio reset tolerance
> register.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Excellent reuse of existing pin config property.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

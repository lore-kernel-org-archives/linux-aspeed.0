From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Jul 2021 11:59:55 +0200
Subject: [PATCH v6 8/9] gpio: gpio-aspeed-sgpio: Use generic device
 property APIs
In-Reply-To: <20210712100317.23298-9-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
 <20210712100317.23298-9-steven_lee@aspeedtech.com>
Message-ID: <CACRpkdZa696HyQvOssrUK=KiiJGVfvCZZ_7zyOWGoEaB-R_BkA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 12, 2021 at 12:04 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> Replace all of_property_read_u32() with device_property_read_u32().
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

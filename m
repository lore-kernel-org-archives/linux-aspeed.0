From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Jul 2018 09:05:48 +0200
Subject: [PATCH] gpio: aspeed: fix compile testing warning
In-Reply-To: <20180709145612.4166409-1-arnd@arndb.de>
References: <20180709145612.4166409-1-arnd@arndb.de>
Message-ID: <CACRpkdaMdcAnA9GWx2vJtfGtDEUzpE64g6v+tJM8NVtY=Bc_Mg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 9, 2018 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Gcc cannot always see that BUG_ON(1) is guaranteed to not
> return, so we get a warning message in some configurations:
>
> drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
> drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void function [-Werror=return-type]
>
> Using a plain BUG() is easier here and avoids the problem.
>
> Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Benjamin's ACK.

Yours,
Linus Walleij

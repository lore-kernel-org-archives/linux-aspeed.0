From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2020 10:32:28 +0200
Subject: [PATCH] pinctrl: aspeed: Describe the heartbeat function on ball
 Y23
In-Reply-To: <20200701030756.2834657-1-joel@jms.id.au>
References: <20200701030756.2834657-1-joel@jms.id.au>
Message-ID: <CACRpkdbeFP_8R6Q1n7S7g+BS58P7bKx8EhLu73g6PsqfKCjcew@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 1, 2020 at 5:08 AM Joel Stanley <joel@jms.id.au> wrote:

> From: Andrew Jeffery <andrew@aj.id.au>
>
> The default pinmux configuration for Y23 is to route a heartbeat to
> drive a LED. Previous revisions of the AST2600 datasheet did not include
> a description of this function.
>
> Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Patch applied, thanks!

Yours,
Linus Walleij

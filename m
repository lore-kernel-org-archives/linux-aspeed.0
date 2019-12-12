From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2019 16:27:52 +0100
Subject: [PATCH] pinctrl: aspeed-g6: Fix LPC/eSPI mux configuration
In-Reply-To: <20191202050110.15340-1-andrew@aj.id.au>
References: <20191202050110.15340-1-andrew@aj.id.au>
Message-ID: <CACRpkdaHXYdHOtCE=_e549rP5DpzP0ayOR4nJmq055Ftiorr-A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 2, 2019 at 5:59 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> Early revisions of the AST2600 datasheet are conflicted about the state
> of the LPC/eSPI strapping bit (SCU510[6]). Conversations with ASPEED
> determined that the reference pinmux configuration tables were in error
> and the SCU documentation contained the correct configuration. Update
> the driver to reflect the state described in the SCU documentation.
>
> Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied for fixes.

Yours,
Linus Walleij

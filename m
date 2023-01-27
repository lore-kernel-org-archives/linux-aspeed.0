From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Jan 2023 13:33:06 +0100
Subject: [PATCH] pinctrl: aspeed: Fix confusing types in return value
In-Reply-To: <20230119231856.52014-1-joel@jms.id.au>
References: <20230119231856.52014-1-joel@jms.id.au>
Message-ID: <CACRpkdbR1O66L0UHG2cAq-d7smuqFQoAMtSEO2L=3za6ELN7mg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 20, 2023 at 12:19 AM Joel Stanley <joel@jms.id.au> wrote:

> The function signature is int, but we return a bool. Instead return a
> negative errno as the kerneldoc suggests.
>
> Fixes: 4d3d0e4272d8 ("pinctrl: Add core support for Aspeed SoCs")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Patch applied for fixes!

Yours,
Linus Walleij

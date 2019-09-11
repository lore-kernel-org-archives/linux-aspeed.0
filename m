From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2019 11:04:47 +0100
Subject: [PATCH v3 2/5] gpio/aspeed: Fix incorrect number of banks
In-Reply-To: <20190906062623.13354-1-rashmica.g@gmail.com>
References: <20190906062623.13354-1-rashmica.g@gmail.com>
Message-ID: <CACRpkdZvBHk65Vs93YbrTR92-8o0SgtUUWMBXeABQH0PZwpRxQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 6, 2019 at 7:26 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:

> The current calculation for the number of GPIO banks is only correct if
> the number of GPIOs is a multiple of 32 (if there were 31 GPIOs we would
> currently say there are 0 banks, which is incorrect).
>
> Fixes: 361b79119a4b7 ('gpio: Add Aspeed driver')
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied.

Yours,
Linus Walleij

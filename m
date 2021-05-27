From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 May 2021 01:47:36 +0200
Subject: [PATCH v3 2/3] ARM: dts: aspeed-g6: Add pinctrl settings
In-Reply-To: <20210525055308.31069-3-steven_lee@aspeedtech.com>
References: <20210525055308.31069-1-steven_lee@aspeedtech.com>
 <20210525055308.31069-3-steven_lee@aspeedtech.com>
Message-ID: <CACRpkdZy0UwaJcYTiM9asVwNh4wuEYdMSrmqAPAiikbrvjtKpw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 25, 2021 at 7:53 AM Steven Lee <steven_lee@aspeedtech.com> wrote:

> AST2600 supports 2 SGPIO master interfaces and 2 SGPIO slave interfaces.
> Currently, only SGPIO master 1 and SGPIO slve 1 in the pinctrl dtsi.
> SGPIO master 2 and slave 2 should be added in pinctrl dtsi as well.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this patch through the Aspeed/ARM SoC tree.

Yours,
Linus Walleij

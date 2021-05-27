From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 May 2021 01:46:21 +0200
Subject: [PATCH v3 3/3] pinctrl: pinctrl-aspeed-g6: Add sgpio pinctrl
 settings
In-Reply-To: <20210525055308.31069-4-steven_lee@aspeedtech.com>
References: <20210525055308.31069-1-steven_lee@aspeedtech.com>
 <20210525055308.31069-4-steven_lee@aspeedtech.com>
Message-ID: <CACRpkdb90ruzyyz9xmKQRSB+cxZAn6t+bfjGahQio_kyk-5_Ug@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 25, 2021 at 7:53 AM Steven Lee <steven_lee@aspeedtech.com> wrote:

> AST2600 supports 2 SGPIO master interfaces and 2 SGPIO slave interfaces.
> Current pinctrl driver only define the first sgpio master and slave
> interfaces.
> The second SGPIO master and slave interfaces should be added in
> pinctrl driver as well.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij

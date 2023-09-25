From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 Sep 2023 15:15:22 +0200
Subject: [PATCH] pinctrl: pinctrl-aspeed-g6: Add more settings for USB2AHP function
In-Reply-To: <20230920103332.274151-1-joe_wang@aspeedtech.com>
References: <20230920103332.274151-1-joe_wang@aspeedtech.com>
Message-ID: <CACRpkdaZb+V-Zx_Uw9MCqRqE+N-0gd__xEFV3BTpkG7icU9W+A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 20, 2023 at 12:33?PM Joe Wang <joe_wang@aspeedtech.com> wrote:

> AST2600 USB2AHP (USB PortA: PCIe EHCI to PHY) function needs to set the
> register SCUC20[16]. Set it to enable the PCIe EHCI device on PCIe bus.
> Besides, also add USB2AHP signal expressions into pin declarations.
>
> Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>

Patch applied!

Yours,
Linus Walleij

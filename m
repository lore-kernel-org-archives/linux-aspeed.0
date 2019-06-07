From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 8 Jun 2019 00:25:16 +0200
Subject: [PATCH 1/3 linux dev-5.1 arm/soc v2] ARM: dts: aspeed: Add SGPM
 pinmux
In-Reply-To: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
References: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
Message-ID: <CACRpkdYW3rezzJ3XAuuSNNsRiDh9nYNL8NNFjaZ=_NeXrmZbqA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 4, 2019 at 11:42 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for
> supporting SGPIO in AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this part of the patch through the ARM SoC
tree. I guess Joel will queue this?

Yours,
Linus Walleij

From: Hongwei Zhang <Hongweiz@ami.com>
Date: Tue, 4 Jun 2019 22:03:37 +0000
Subject: [PATCH linux dev-5.1 v1] ARM: dts: aspeed: Add SGPM pinmux
In-Reply-To: <CACRpkdYPHw994Ov0xCfK6tCg60tiuWrRwTcYpMSfOr4G0VKu_Q@mail.gmail.com>
References: <1559601789-27121-1-git-send-email-hongweiz@ami.com>
 <CACRpkdYPHw994Ov0xCfK6tCg60tiuWrRwTcYpMSfOr4G0VKu_Q@mail.gmail.com>
Message-ID: <14D3C8298A3B0F42A1EB31EE961CFF8231E4AA@atlms1.us.megatrends.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-----Original Message-----
From: Linus Walleij <linus.walleij@linaro.org> 
Sent: Monday, June 3, 2019 7:08 PM
To: Hongwei Zhang <Hongweiz@ami.com>
Cc: Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; open list:GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
Subject: Re: [PATCH linux dev-5.1 v1] ARM: dts: aspeed: Add SGPM pinmux

Hi Hongwei,

On Tue, Jun 4, 2019 at 12:44 AM Hongwei Zhang <hongweiz@ami.com> wrote:
>
> Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for 
> supporting SGPIO in AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 2 +-
>  arch/arm/boot/dts/aspeed-g5.dtsi                             | 5 +++++
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c                   | 4 ++++

Please try to separate out the change to arch/arm/boot/dts/aspeed-g5.dtsi into a separate patch that goes through ARM SoC.

Just committed the DT patch to _https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git , please help to review. Thanks!


Other than that it looks fine to me.

Yours,
Linus Walleij

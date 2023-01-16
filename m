From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 16 Jan 2023 03:33:16 +0000
Subject: [PATCH 0/2] Add ASPEED AST2600 miss pinctrl
In-Reply-To: <20230103093702.2613574-1-ryan_chen@aspeedtech.com>
References: <20230103093702.2613574-1-ryan_chen@aspeedtech.com>
Message-ID: <SEZPR06MB5269DA226076831F4B36135DF2C19@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andrew,
	Could you help review this series patch?

Ryan Chen

> -----Original Message-----
> From: Ryan Chen <ryan_chen@aspeedtech.com>
> Sent: Tuesday, January 3, 2023 5:37 PM
> To: openbmc at lists.ozlabs.org; Ryan Chen <ryan_chen@aspeedtech.com>; Rob
> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Linus Walleij <linus.walleij@linaro.org>;
> linux-aspeed at lists.ozlabs.org
> Subject: [PATCH 0/2] Add ASPEED AST2600 miss pinctrl
> 
> This series add AST2600 pinctrl miss parts.
> And also update AST2600 pinctrl dtsi.
> 
> ryan_chen (2):
>   pinctrl:aspeed: add miss pin and function
>   dtsi:aspeed: add miss pinctrl in pinctrl dtsi
> 
>  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   | 216 +++++++++++++
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 341 +++++++++++++++------
>  2 files changed, 455 insertions(+), 102 deletions(-)
> 
> --
> 2.34.1


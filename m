From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 30 Jan 2023 08:31:19 +0000
Subject: [PATCH 2/2] dtsi:aspeed: add miss pinctrl in pinctrl dtsi
In-Reply-To: <3b11d987-180d-4b99-949a-b854b1d6d39b@app.fastmail.com>
References: <20230103093702.2613574-1-ryan_chen@aspeedtech.com>
 <20230103093702.2613574-3-ryan_chen@aspeedtech.com>
 <3b11d987-180d-4b99-949a-b854b1d6d39b@app.fastmail.com>
Message-ID: <SEZPR06MB5269F48124B49BE5D4599391F2D39@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andrew,
	Thanks your review. I will separate the patch to submit.

Ryan Chen

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Monday, January 23, 2023 9:33 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; openbmc at lists.ozlabs.org; Rob
> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Linus
> Walleij <linus.walleij@linaro.org>; linux-aspeed at lists.ozlabs.org
> Subject: Re: [PATCH 2/2] dtsi:aspeed: add miss pinctrl in pinctrl dtsi
> 
> Hi Ryan,
> 
> On Tue, 3 Jan 2023, at 20:07, ryan_chen wrote:
> > add miss pcie rc, secure i2c, i3c, 8bit emmc, uart ncts..
> 
> Please make sure that any new functions and groups are documented in the
> devicetree bindings. Also, updates to the binding documentation should be in
> their own patch, separate to the changes to the devicetree itself.
> 
> Cheers,
> 
> Andrew

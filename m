From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 7 Oct 2020 05:45:36 +0000
Subject: [PATCH 0/3] Enable USB host for AST2600
In-Reply-To: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
Message-ID: <HK0PR06MB338033E8D9EA016D50615D2AF20A0@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Joel,
	Have you take time review this patches ? 

Ryan Chen

Tel : 886-3-5751185 ext:8857

> -----Original Message-----
> From: Ryan Chen <ryan_chen@aspeedtech.com>
> Sent: Wednesday, September 30, 2020 12:08 PM
> To: Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org; linux-usb at vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Subject: [PATCH 0/3] Enable USB host for AST2600
> 
> The patches enable UHCI driver in AST2600 and also enable USB host in
> aspeed-ast2600-evb.dts.
> 
> Ryan Chen (3):
>   configs: aspeed: enable UHCI driver in defconfig
>   usb: host: add uhci compatible support for ast2600-uhci
>   ARM: dts: add ehci uhci enable in evb dts
> 
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 8 ++++++++
>  arch/arm/configs/aspeed_g5_defconfig     | 1 +
>  drivers/usb/host/uhci-platform.c         | 3 ++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> --
> 2.17.1


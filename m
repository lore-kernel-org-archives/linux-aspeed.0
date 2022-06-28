From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 28 Jun 2022 07:17:41 +0000
Subject: [PATCH] usb: gadget: aspeed_udc: fix handling of tx_len == 0
In-Reply-To: <c960c2e02ddeacd527442e0b3b0db532c9017e1b.camel@kernel.crashing.org>
References: <YrMsU9HvdBm5YrRH@kili>
	 <HK0PR06MB32023259EBD6B4C649C62E8280B59@HK0PR06MB3202.apcprd06.prod.outlook.com>
	 <20220623064320.GN16517@kadam>
	 <e0b1c201bec2ccb68d1779ea8e9cfdf27563dd73.camel@amazon.com>
	 <20220624063457.GG11460@kadam>
	 <46f88070d8f6f47f55310e964a4576cadbc810f4.camel@kernel.crashing.org>
	 <HK0PR06MB32024B6C49E2C958185E005280B49@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <c960c2e02ddeacd527442e0b3b0db532c9017e1b.camel@kernel.crashing.org>
Message-ID: <HK0PR06MB3202F5E3C643A4943BB521A480B89@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On Fri, 2022-06-24 at 07:46 +0000, Neal Liu wrote:
> > >
> > Hi Ben, This UDC is the independent IP. The ast2600 board can run
> > aspeed-vhub & aspeed_udc simultaneously with different USB port.
> > I think it's no need to restruct the code in vhub.
> 
> But is it a copy of the same base IP block ? IE, is the fundamental HW interface
> of the independent UDC operating the same way with the same register layout
> as one of the ports of the vHUB ?
> 
> I don't like having multiple drivers for the same hardware... if it's different
> enough, then let's keep it separate, but if not, we should definitely split the udc
> from the existing vhub code so that the same driver can operate standalone or
> beneath a vhub.
> 

Based on ast2600 hardware design, it's similar, but not exactly the same.
I need more time to extract the differences and evaluate it if it could utilize vhub.

> Cheers,
> Ben.


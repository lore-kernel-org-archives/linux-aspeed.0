From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 26 Sep 2023 10:46:54 +0930
Subject: [PATCH] pinctrl: pinctrl-aspeed-g6: Add more settings for
 USB2AHP function
In-Reply-To: <CACRpkdaZb+V-Zx_Uw9MCqRqE+N-0gd__xEFV3BTpkG7icU9W+A@mail.gmail.com>
References: <20230920103332.274151-1-joe_wang@aspeedtech.com>
	 <CACRpkdaZb+V-Zx_Uw9MCqRqE+N-0gd__xEFV3BTpkG7icU9W+A@mail.gmail.com>
Message-ID: <e3c4013eca1b7cb6edd6724be37e2ec86fc408dd.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2023-09-25 at 15:15 +0200, Linus Walleij wrote:
> On Wed, Sep 20, 2023 at 12:33?PM Joe Wang <joe_wang@aspeedtech.com> wrote:
> 
> > AST2600 USB2AHP (USB PortA: PCIe EHCI to PHY) function needs to set the
> > register SCUC20[16]. Set it to enable the PCIe EHCI device on PCIe bus.
> > Besides, also add USB2AHP signal expressions into pin declarations.
> > 
> > Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>
> 
> Patch applied!

Thanks. I hope to improve my review responsiveness for Aspeed patches
over recent times.

Andrew

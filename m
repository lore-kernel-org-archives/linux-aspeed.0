From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 30 Jun 2017 10:44:56 +0930
Subject: [PATCH 2/4] ARM: aspeed: g5: Add USB functions to pinctrl bindings
In-Reply-To: <20170629203222.xwxzlawckxlpw6u5@rob-hp-laptop>
References: <20170627021214.23323-1-andrew@aj.id.au>
 <20170627021214.23323-3-andrew@aj.id.au>
 <20170629201324.c4t7bcrhsdoftkd3@rob-hp-laptop>
 <20170629203222.xwxzlawckxlpw6u5@rob-hp-laptop>
Message-ID: <1498785296.5203.10.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-06-29 at 15:32 -0500, Rob Herring wrote:
> On Thu, Jun 29, 2017 at 03:13:24PM -0500, Rob Herring wrote:
> > On Tue, Jun 27, 2017 at 11:42:12AM +0930, Andrew Jeffery wrote:
> > > The Aspeed AST2500 SoC contains a number of USB controllers:
> > > 
> > > * USB 1.1 Host Controller
> > > * USB 2.0 Host Controller (x2)
> > > * Combined USB 2.0 Virtual Hub and USB 1.1 HID Controller
> > > 
> > > The controllers are exposed via two USB ports with functionality muxed
> > > as required. The following table illustrates the relationships between
> > > the ports and the controllers via the mux function names:
> > > 
> > > Port  | USB Version  | USB Mode     | Mux Function
> > > ------|--------------|--------------|-------------
> > > A     | 2.0          | Virtual Hub  | USB2AD
> > > A     | 2.0          | Host         | USB2AH
> > > B     | 1.1          | HID          | USB11BHID
> > > B     | 2.0          | Device       | USB2BD
> > > B     | 2.0          | Host         | USB2BH
> > > 
> > > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Also, when you resend, use "dt-bindings: pinctrl: ..." for the subjects 
> of binding patches in this series.

Will do.

Cheers,

Andrew

> 
> Rob
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170630/cbec65ef/attachment-0001.sig>

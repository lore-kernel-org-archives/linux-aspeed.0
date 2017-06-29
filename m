From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Jun 2017 15:13:24 -0500
Subject: [PATCH 2/4] ARM: aspeed: g5: Add USB functions to pinctrl bindings
In-Reply-To: <20170627021214.23323-3-andrew@aj.id.au>
References: <20170627021214.23323-1-andrew@aj.id.au>
 <20170627021214.23323-3-andrew@aj.id.au>
Message-ID: <20170629201324.c4t7bcrhsdoftkd3@rob-hp-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 27, 2017 at 11:42:12AM +0930, Andrew Jeffery wrote:
> The Aspeed AST2500 SoC contains a number of USB controllers:
> 
> * USB 1.1 Host Controller
> * USB 2.0 Host Controller (x2)
> * Combined USB 2.0 Virtual Hub and USB 1.1 HID Controller
> 
> The controllers are exposed via two USB ports with functionality muxed
> as required. The following table illustrates the relationships between
> the ports and the controllers via the mux function names:
> 
> Port  | USB Version  | USB Mode     | Mux Function
> ------|--------------|--------------|-------------
> A     | 2.0          | Virtual Hub  | USB2AD
> A     | 2.0          | Host         | USB2AH
> B     | 1.1          | HID          | USB11BHID
> B     | 2.0          | Device       | USB2BD
> B     | 2.0          | Host         | USB2BH
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

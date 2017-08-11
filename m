From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Aug 2017 21:56:57 -0500
Subject: [RESEND PATCH 1/2] dt-bindings: gpio: aspeed: Remove reference
 to clock name
In-Reply-To: <20170808061634.11857-2-andrew@aj.id.au>
References: <20170808061634.11857-1-andrew@aj.id.au>
 <20170808061634.11857-2-andrew@aj.id.au>
Message-ID: <20170811025657.bw7kngklmnz7vpf3@rob-hp-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 08, 2017 at 03:46:33PM +0930, Andrew Jeffery wrote:
> HPLL was in fact not the clock we need. Remove prescription of which
> clock to avoid further error. Please refer to your datasheet and double
> check like I should have.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-aspeed.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 31 Jul 2019 12:00:59 -0600
Subject: [PATCH net-next v2 1/4] dt-bindings: net: Add aspeed,
 ast2600-mdio binding
In-Reply-To: <20190731053959.16293-2-andrew@aj.id.au>
References: <20190731053959.16293-1-andrew@aj.id.au>
 <20190731053959.16293-2-andrew@aj.id.au>
Message-ID: <CAL_JsqLu2M7qnO08kHbgheNCN1+Lis0shrjfnphMbkSJKRs7=A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2019 at 11:39 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The AST2600 splits out the MDIO bus controller from the MAC into its own
> IP block and rearranges the register layout. Add a new binding to
> describe the new hardware.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>
> ---
> v2:
> * aspeed: Utilise mdio.yaml
> * aspeed: Drop status from example
> ---
>  .../bindings/net/aspeed,ast2600-mdio.yaml     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

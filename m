From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Sun, 19 Mar 2023 02:05:46 +0000
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <20230318090936.qvqozqfskpe5lja7@intel.intel>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
 <20230318090936.qvqozqfskpe5lja7@intel.intel>
Message-ID: <SEZPR06MB5269DB6BE01C48BBFA17876DF2839@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

> -----Original Message-----
> From: Andi Shyti <andi.shyti@kernel.org>
> Sent: Saturday, March 18, 2023 5:10 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>; Brendan Higgins
> <brendan.higgins@linux.dev>; Benjamin Herrenschmidt
> <benh@kernel.crashing.org>; Joel Stanley <joel@jms.id.au>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; linux-i2c at vger.kernel.org;
> openbmc at lists.ozlabs.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
> AST2600-i2cv2
> 
> Hi Ryan,
> 
> On Sun, Feb 26, 2023 at 11:13:20AM +0800, Ryan Chen wrote:
> > Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,timeout
> > aspeed,xfer-mode description for ast2600-i2cv2.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 44
> +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > index f597f73ccd87..75de3ce41cf5 100644
> > --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > @@ -49,6 +49,25 @@ properties:
> >      description:
> >        states that there is another master active on this bus
> >
> > +  aspeed,timeout:
> > +    type: boolean
> > +    description: I2C bus timeout enable for master/slave mode
> 
> Finally you can proceed with this. Please remove "aspeed,timeout"
> and use "i2c-scl-has-clk-low-timeout" instead.

Thanks a lot, I will start progress this. 

Best Regards
Ryan

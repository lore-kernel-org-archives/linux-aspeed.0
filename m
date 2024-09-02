From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 2 Sep 2024 02:32:22 +0000
Subject: [PATCH v2 1/4] dt-bindings: gpio: aspeed,ast2400-gpio: Support
 ast2700
In-Reply-To: <20240830-untangled-charting-48503e510ea7@spud>
References: <20240830034047.2251482-1-billy_tsai@aspeedtech.com>
 <20240830034047.2251482-2-billy_tsai@aspeedtech.com>
 <20240830-untangled-charting-48503e510ea7@spud>
Message-ID: <OSQPR06MB7252A649AC8CECB3E114C8BD8B922@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > The AST2700 is the 7th generation SoC from Aspeed, featuring two GPIO
> > controllers: one with 12 GPIO pins and another with 216 GPIO pins.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >? .../bindings/gpio/aspeed,ast2400-gpio.yaml??? | 46 ++++++++++++++++++-
> >? 1 file changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > index cf11aa7ec8c7..4d439972c14b 100644
> > --- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > @@ -15,6 +15,7 @@ properties:
> >??????? - aspeed,ast2400-gpio
> >??????? - aspeed,ast2500-gpio
> >??????? - aspeed,ast2600-gpio
> > +????? - aspeed,ast2700-gpio
> >? 
> >??? reg:
> >????? maxItems: 1
> > @@ -42,7 +43,7 @@ properties:
> >????? const: 2
> >? 
> >??? ngpios:
> > -??? minimum: 36
> > +??? minimum: 12
> >????? maximum: 232

> Aren't you missing a corresponding update to gpio-line-names, which has
> a minimum of 36?

Yes, I missed updating the minimum of the gpio-line-names to 12.
Thanks, I?ll fix it in the next version of the patch.

Best regards,
Billy Tsai

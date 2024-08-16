From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 16 Aug 2024 02:31:43 +0000
Subject: [PATCH v4 2/2] media: aspeed: Allow to capture from SoC display
 (GFX)
In-Reply-To: <003090ab-4ce2-4624-b5c5-33ceef521e9d@kernel.org>
References: <20240814005421.3362441-1-jammy_huang@aspeedtech.com>
 <20240814005421.3362441-3-jammy_huang@aspeedtech.com>
 <003090ab-4ce2-4624-b5c5-33ceef521e9d@kernel.org>
Message-ID: <TYZPR06MB6568197D19B5855A014A0ECBF1812@TYZPR06MB6568.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024/8/14 ?? 02:09, Krzysztof Kozlowski wrote:
>
> On 14/08/2024 02:54, Jammy Huang wrote:
> > +/*
> > + * Get regmap without checking res, such as clk/reset, that could
> > +lead to
> > + * conflict.
> > + */
> > +static struct regmap *aspeed_regmap_lookup(struct device_node *np,
> > +const char *property) {
> > +   struct device_node *syscon_np __free(device_node) =
> of_parse_phandle(np, property, 0);
> > +   struct regmap *regmap;
>
> Drop. The point of using __free was to make this very simple.
To be simpler, it will looks like this, right.

+       struct device_node *syscon_np __free(device_node) = of_parse_phandle(np, property, 0);
+
+       if (!syscon_np)
+               return ERR_PTR(-ENODEV);
+       return device_node_to_regmap(syscon_np);
>
> > +
> > +   if (!syscon_np)
> > +           return ERR_PTR(-ENODEV);
> > +
> > +   regmap = device_node_to_regmap(syscon_np);
> > +
> > +   return regmap;
> > +}
> > +
> >  static int aspeed_video_init(struct aspeed_video *video)  {
> >     int irq;
> >     int rc;
> >     struct device *dev = video->dev;
> >
> > +   video->scu = aspeed_regmap_lookup(dev->of_node, "aspeed,scu");
> > +   video->gfx = aspeed_regmap_lookup(dev->of_node, "aspeed,gfx");
>
> Still undocumented. Respond to previous comment and confirm that you
> understood it.
Sorry for misunderstanding. I will add document,
Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml, later.

>
>
> Best regards,
> Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.

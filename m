From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 23 Aug 2024 01:11:26 +0000
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: Add aspeed,video binding
In-Reply-To: <nnjcjt2kuplsy5bbxujuubkn2xdtpifjeiqt5qfvktdmaorzuz@x444p5ezcoch>
References: <20240819080859.1304671-1-jammy_huang@aspeedtech.com>
 <20240819080859.1304671-2-jammy_huang@aspeedtech.com>
 <nnjcjt2kuplsy5bbxujuubkn2xdtpifjeiqt5qfvktdmaorzuz@x444p5ezcoch>
Message-ID: <TYZPR06MB6568AB9E260263DBB1ED474DF1882@TYZPR06MB6568.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

Thanks for your help.

On 2024/8/19 ?? 04:24, Krzysztof Kozlowski wrote:
>
> On Mon, Aug 19, 2024 at 04:08:58PM +0800, Jammy Huang wrote:
> > The Video Engine block in ASPEED Silicon SoCs is responsible for video
> > compressions with a wide range of video quality and compression ratio
> > options. It can capture and compress video data from digital or analog
> > sources.
> >
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> >  .../bindings/arm/aspeed/aspeed,video.yaml     | 81
> +++++++++++++++++++
>
> Why are you adding duplicated binding? Please read the first comments - you
> need to first convert TXT to DT schema. Then you add new properties in a new
> patch.
Sorry, I didn't notice there is already a TXT in Documentation/devicetree/bindings/media.

>
> >  1 file changed, 81 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml
> > b/Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml
> > new file mode 100644
> > index 000000000000..bef7bd2f310a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml
>
> Filename matching compatible.
OK, rename to 'aspeed, video-engine.yaml' in next patch.

>
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/aspeed/aspeed,video.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED Video Engine
>
> ASPEED or Aspeed?
I prefer ASPEED.

>
> > +
> > +maintainers:
> > +  - Eddie James <eajames@linux.ibm.com>
> > +  - Jammy Huang <jammy_huang@aspeedtech.com>
> > +
> > +description: |
>
> Drop |
OK

>
> > +  The ASPEED video engine can be configured to capture and compress
> > + video  data from digital or analog sources.
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      pattern: "^aspeed,ast[0-9]+-video-engine$"
> > +  required:
> > +    - compatible
>
> Drop entire select. No clue what is this.
OK

>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: Preferred naming style for compatibles of video
> components
> > +        pattern: "^aspeed,ast[0-9]+-video-engine$"
>
> ???
>
> No, drop.
OK

>
> > +
> > +      - enum:
> > +          - aspeed,ast2400-video-engine
> > +          - aspeed,ast2500-video-engine
> > +          - aspeed,ast2600-video-engine
> > +
> > +  reg:
> > +    minItems: 1
>
> No, maxItems.
OK

>
> > +
> > +  clocks:
> > +    minItems: 2
>
> No. maxItems.
OK

>
> > +
> > +  clock-names:
> > +    items:
> > +      - const: vclk
> > +      - const: eclk
> > +
> > +  interrupts:
> > +    minItems: 1
>
> maxItems
OK

>
> > +
> > +  aspeed,scu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      Specifies the scu node that is needed if video wants to capture
> > +      from sources other than Host VGA.
> > +
> > +  aspeed,gfx:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      Specifies the Soc Display(gfx) node that needs to be queried to get
> > +      related information if video wants to use gfx as capture source.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +
> > +additionalProperties: true
>
> NAK, this cannot be true. Where do you see any device binding having it true?
OK

>
>
> > +
> > +examples:
> > +  - |
> > +    video: video at 1e700000 {
>
> Drop unused label
OK

>
> > +           compatible = "aspeed,ast2600-video-engine";
>
> Fix indentation, this is supposed 4 spaces.
OK
************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.

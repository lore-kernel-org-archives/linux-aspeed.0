From: Rob Herring <robh@kernel.org>
Date: Wed, 22 Nov 2023 13:47:04 -0700
Subject: [PATCH RESEND v10 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM
 TACH Control
In-Reply-To: <SG2PR06MB33655734700697E8F6FD0D1B8BB2A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <20231107105025.1480561-3-billy_tsai@aspeedtech.com> <20231108182135.GA2698015-robh@kernel.org>
 <SG2PR06MB33655734700697E8F6FD0D1B8BB2A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Message-ID: <CAL_JsqL=2-dD5yFWWDDHu1svcCF-EMZqcYz92Pr7L5ntppNQVA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 13, 2023 at 8:11?PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> > > Document the compatible for aspeed,ast2600-pwm-tach device, which can
> > > support up to 16 PWM outputs and 16 fan tach input.
> > >
> > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > > ---
> > >  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++++++
> > >  1 file changed, 69 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> > > new file mode 100644
> > > index 000000000000..c615fb10705c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> > > @@ -0,0 +1,69 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2023 Aspeed, Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ASPEED G6 PWM and Fan Tach controller
> > > +
> > > +maintainers:
> > > +  - Billy Tsai <billy_tsai@aspeedtech.com>
> > > +
> > > +description: |
> > > +  The ASPEED PWM controller can support up to 16 PWM outputs.
> > > +  The ASPEED Fan Tacho controller can support up to 16 fan tach input.
> > > +  They are independent hardware blocks, which are different from the
> > > +  previous version of the ASPEED chip.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - aspeed,ast2600-pwm-tach
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  "#pwm-cells":
> > > +    const: 3
> > > +
> > > +patternProperties:
> > > +  "^fan-[0-9]+$":
> > > +    $ref: fan-common.yaml#
> > > +    unevaluatedProperties: false
> > > +    required:
> > > +      - tach-ch
> > > +
> > > +required:
> > > +  - reg
> > > +  - clocks
> > > +  - resets
> > > +  - "#pwm-cells"
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > +    pwm_tach: pwm-tach-controller at 1e610000 {
> > > +      compatible = "aspeed,ast2600-pwm-tach";
> > > +      reg = <0x1e610000 0x100>;
> > > +      clocks = <&syscon ASPEED_CLK_AHB>;
> > > +      resets = <&syscon ASPEED_RESET_PWM>;
> > > +      #pwm-cells = <3>;
> > > +
> > > +      fan-0 {
>
> > I assume there's a PWM connection here? How do you know which PWM? You
> > said the tach channel is independent, so it is not that.
>
> > It should not be 0 from 'fan-0' because that's just a meaningless index.
>
> > You either need 'pwms' here or you can use 'reg' and the reg value is
> > the PWM channel.
>
> Hi Rob, this binding is used to export the PWM provider and the Fan monitor (i.e., Tach).
> If the user wants to add the PWM connection for the fan, it can be done as follows:
>
> fan0: pwm-fan0 {
>         compatible = "pwm-fan";
>         pwms = <&pwm_tach 0 40000 0>;
>         cooling-min-state = <0>;
>         cooling-max-state = <3>;
>         #cooling-cells = <2>;
>         cooling-levels = <0 15 128 255>;
> };
>
> This will reuse the existing PWM fan driver (e.g., pwm-fan.c).

I'm confused now. So what are the child nodes you have? You are
defining the fan in 2 places? The "pwm-fan" driver supports a tach via
an interrupt, so how would this work in your case?

Rob

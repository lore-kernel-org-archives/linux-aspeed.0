From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 1 Jun 2022 08:01:05 +0000
Subject: [PATCH 4/5] dt-bindings: crypto: add documentation for aspeed
 hace
In-Reply-To: <dca283db-0b2e-1fc1-bc76-811c4c918fb5@linaro.org>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-5-neal_liu@aspeedtech.com>
 <dca283db-0b2e-1fc1-bc76-811c4c918fb5@linaro.org>
Message-ID: <HK0PR06MB3202D6A6C66480BF60ED829080DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On 01/06/2022 07:42, Neal Liu wrote:
> > Add device tree binding documentation for the Aspeed Hash and Crypto
> > Engines (HACE) Controller.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > ---
> >  .../bindings/crypto/aspeed,hace.yaml          | 58
> +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/crypto/aspeed,hace.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/aspeed,hace.yaml
> > b/Documentation/devicetree/bindings/crypto/aspeed,hace.yaml
> > new file mode 100644
> > index 000000000000..36b4ad0dc7fa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/aspeed,hace.yaml
> 
> Filename should be rather from the first compatible, so
> "aspeed,ast2500-hace.yaml"
> 
Got it, I'll revise it as you suggested.

> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/crypto/aspeed,hace.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED HACE hash and crypto Hardware Accelerator Device Tree
> > +Bindings
> 
> s/Device Tree Bindings//
> 
Got it, I'll revise it as you suggested.

> > +
> > +maintainers:
> > +  - Neal Liu <neal_liu@aspeedtech.com>
> > +
> > +description: |
> > +  The Hash and Crypto Engine (HACE) is designed to accelerate the
> > +throughput
> > +  of hash data digest, encryption, and decryption. Basically, HACE
> > +can be
> > +  divided into two independently engines - Hash Engine and Crypto Engine.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2500-hace
> > +      - aspeed,ast2600-hace
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    maxItems: 1
> 
> You need to list clock names, however usually it does not make sense to have
> names for just one main device clock.
> 
I think list clock-names is optional, I'll remove it from required list.

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/ast2600-clock.h>
> > +    hace: hace at 1e6d0000 {
> 
> Generic node names so "crypto".
> 
Got it, I'll revise it as you suggested.

> > +        compatible = "aspeed,ast2600-hace";
> > +        reg = <0x1e6d0000 0x200>;
> > +        interrupts = <4>;
> > +        clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
> > +        clock-names = "yclk";
> > +        resets = <&syscon ASPEED_RESET_HACE>;
> > +    };
> 
> 
> Best regards,
> Krzysztof

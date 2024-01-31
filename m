From: Conor Dooley <conor@kernel.org>
Date: Wed, 31 Jan 2024 00:32:42 +0000
Subject: [PATCH 30 2/7] Add binding for Aspeed SOC
In-Reply-To: <LV8PR11MB8463D0017B82135324127DB98B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB8463D0017B82135324127DB98B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Message-ID: <20240131-felt-tip-mountain-e29606b63acf@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey,

On Tue, Jan 30, 2024 at 11:30:10PM +0000, Corona, Ernesto wrote:
> Aspeed AST2400, AST2500 and AST2600 JTAG controller driver.
> 
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
> Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
> Acked-by: Rob Herring <robh@kernel.org>

Where did this ack come from? The conversion to a yaml binding was in
v29 (according to your changelog) but I don't see the ack from Rob
there.
I think a conversion from (text?) to yaml would be sufficient of a
change to drop his tag.

> v28->v29
> - Change documentation to the new dt-bindings yaml format.

>  .../devicetree/bindings/jtag/aspeed-jtag.yaml | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
> 
> diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
> new file mode 100644
> index 000000000000..1a412e83b81b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml

Filename matching a compatible please.

> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/jtag/aspeed-jtag.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed JTAG driver for ast2400, ast2500 and ast2600 SoC
> +
> +description:
> +  Driver adds support of Aspeed 24/25/2600 series SOC JTAG controller.
> +  Driver implements the following jtag ops
> +    freq_get
> +    freq_set
> +    status_get
> +    status_set
> +    xfer
> +    mode_set
> +    bitbang
> +    enable
> +    disable

None of the driver stuff, nor where you tested this, is relevant to the
description in the binding nor the title of the binding. Just describe
the hardware.

> +
> +  It has been tested on Mellanox system with BMC equipped with
> +  Aspeed 2520 SoC for programming CPLD devices.
> +
> +  It has also been tested on Intel system using Aspeed 25xx SoC
> +  for JTAG communication.
> +
> +  Tested on Intel system using Aspeed 26xx SoC for JTAG communication.
> +
> +maintainers:
> +  - Oleksandr Shamray <oleksandrs@mellanox.com>
> +  - Jiri Pirko <jiri@nvidia.com>
> +  - Ernesto Corona<ernesto.corona@intel.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - aspeed,ast2400-jtag
> +              - aspeed,ast2500-jtag
> +              - aspeed,ast2600-jtag

You don't need the "oneOf" or "items" here, it's enough to do:
  compatible:
    enum:
      - allwinner,sun5i-a13-mbus
      - allwinner,sun8i-a33-mbus

> +
> +
> +  reg:
> +    items:
> +      - description: JTAG Master controller register range
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +      jtag: jtag at 1e6e4000 {

The labels for both of these examples are also not needed
as they're not used anywhere.

Thanks,
Conor.

> +          compatible = "aspeed,ast2500-jtag";
> +          reg = <0x1e6e4000 0x1c>;
> +          clocks = <&syscon ASPEED_CLK_APB>;
> +          resets = <&syscon ASPEED_RESET_JTAG_MASTER>;
> +          interrupts = <43>;
> +      };
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +      jtag1: jtag at 1e6e4100 {
> +          compatible = "aspeed,ast2600-jtag";
> +          reg = <0x1e6e4100 0x40>;
> +          clocks = <&syscon ASPEED_CLK_APB1>;
> +          resets = <&syscon ASPEED_RESET_JTAG_MASTER2>;
> +          interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +
> +...
> -- 
> 2.25.1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240131/cbc87905/attachment.sig>

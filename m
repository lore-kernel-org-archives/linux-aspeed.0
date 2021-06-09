From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 09 Jun 2021 10:12:33 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v5_01/10]_dt-bindings:_aspeed-sgpio:_Convert_txt_bi?=
 =?UTF-8?Q?ndings_to_yaml.?=
In-Reply-To: <20210608102547.4880-2-steven_lee@aspeedtech.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
 <20210608102547.4880-2-steven_lee@aspeedtech.com>
Message-ID: <1f34af33-0905-480e-8a55-e5e34d66216f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 8 Jun 2021, at 19:55, Steven Lee wrote:
> sgpio-aspeed bindings should be converted to yaml format.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  .../bindings/gpio/aspeed,sgpio.yaml           | 75 +++++++++++++++++++
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt | 46 ------------
>  2 files changed, 75 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml 
> b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> new file mode 100644
> index 000000000000..b2ae211411ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/aspeed,sgpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed SGPIO controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@aj.id.au>
> +
> +description:
> +  This SGPIO controller is for ASPEED AST2500 SoC, it supports up to 
> 80 full
> +  featured Serial GPIOs. Each of the Serial GPIO pins can be 
> programmed to
> +  support the following options
> +  - Support interrupt option for each input port and various interrupt
> +    sensitivity option (level-high, level-low, edge-high, edge-low)
> +  - Support reset tolerance option for each output port
> +  - Directly connected to APB bus and its shift clock is from APB bus 
> clock
> +    divided by a programmable value.
> +  - Co-work with external signal-chained TTL components 
> (74LV165/74LV595)
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-sgpio
> +      - aspeed,ast2500-sgpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  ngpios: true
> +
> +  bus-frequency: true

I'm not familiar enough with dt-schema to know that this does what we need, so deferring to Rob.

Looks good otherwise.

Andrew

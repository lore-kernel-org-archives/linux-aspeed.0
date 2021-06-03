From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 04 Jun 2021 08:55:17 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_1/5]_dt-bindings:_aspeed-sgpio:_Convert_txt_bind?=
 =?UTF-8?Q?ings_to_yaml.?=
In-Reply-To: <20210603101822.9645-2-steven_lee@aspeedtech.com>
References: <20210603101822.9645-1-steven_lee@aspeedtech.com>
 <20210603101822.9645-2-steven_lee@aspeedtech.com>
Message-ID: <516bb11a-b75f-49e1-ba79-e5a4c344a7ab@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Steven,

On Thu, 3 Jun 2021, at 19:48, Steven Lee wrote:
> sgpio-aspeed bindings should be converted to yaml format.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  .../bindings/gpio/aspeed,sgpio.yaml           | 78 +++++++++++++++++++
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt | 46 -----------
>  2 files changed, 78 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml 
> b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> new file mode 100644
> index 000000000000..e7c2113cc096
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
> @@ -0,0 +1,78 @@
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
> +  This SGPIO controller is for ASPEED AST2400, AST2500 and AST2600 SoC,
> +  AST2600 have two sgpio master one with 128 pins another one with 80 
> pins,
> +  AST2500/AST2400 have one sgpio master with 80 pins. Each of the 
> Serial
> +  GPIO pins can be programmed to support the following options
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
> +      - aspeed,ast2600-sgpiom1
> +      - aspeed,ast2600-sgpiom2

You should have followed Rob's request here and made two patches for 
the binding document:

1. A 1-to-1 conversion of the text file to dt-schema
2. Add your new compatibles for the 2600.

From a cursory glance it looks okay except for the new compatibles.

Regarding the compatibles, I'd prefer we use something a bit more 
meaningful. What do you think of these?

- aspeed,ast2600-sgpiom-80
- aspeed,ast2600-sgpiom-128

Cheers,

Andrew

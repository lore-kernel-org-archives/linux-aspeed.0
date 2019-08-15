From: Joel Stanley <joel@jms.id.au>
Date: Thu, 15 Aug 2019 05:36:11 +0000
Subject: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
In-Reply-To: <20190807003629.2974-2-andrew@aj.id.au>
References: <20190807003629.2974-1-andrew@aj.id.au>
 <20190807003629.2974-2-andrew@aj.id.au>
Message-ID: <CACPK8Xe6Zp1uOqEffEc0b6oGa7portEAifGPRqb876HmA+oZeg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2019 at 00:38, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Two minor comments below.

> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later

No "Copyright IBM" ?

> +%YAML 1.2
> +---

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    sdc at 1e740000 {
> +            compatible = "aspeed,ast2500-sd-controller";
> +            reg = <0x1e740000 0x100>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0 0x1e740000 0x10000>;

According to the datasheet this could be 0x20000. It does not matter
though, as there's nothing in it past 0x300.

Cheers,

Joel

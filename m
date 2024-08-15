From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Thu, 15 Aug 2024 05:50:20 +0000
Subject: =?big5?B?pl7C0DogW1BBVENIIHYxIDAyLzEwXSBkdC1iaW5kaW5nOiBjbGs6IGFzdDI3MDA6?=
 =?big5?Q?_Add_binding_for_Aspeed_AST27xx_Clock?=
In-Reply-To: <e13c16db-e1a7-4ee0-867b-b184d421de7f@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-3-kevin_chen@aspeedtech.com>
 <e13c16db-e1a7-4ee0-867b-b184d421de7f@kernel.org>
Message-ID: <PSAPR06MB49495961B7AEDE4AE26F8ED389802@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

>Missing commit msg.
>
>A nit, subject: drop second/last, redundant "bindings". The
>"dt-bindings" prefix is already stating that these are bindings.
>See also:
>https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
>Please use subject prefixes matching the subsystem. You can get them for
>example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>your patch is touching. For bindings, the preferred subjects are
>explained here:
>https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
Agree, already fixed in another commit in Ryan's series.
[3/4] dt-bindings: clock: Add AST2700 clock bindings - Patchwork (kernel.org)<https://patchwork.kernel.org/project/linux-clk/patch/20240808075937.2756733-4-ryan_chen@aspeedtech.com/>

--
Best Regards,
Kevin. Chen



________________________________
???: Krzysztof Kozlowski <krzk@kernel.org>
????: 2024?7?26? ?? 07:11
???: Kevin Chen <kevin_chen@aspeedtech.com>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; lee at kernel.org <lee@kernel.org>; catalin.marinas at arm.com <catalin.marinas@arm.com>; will at kernel.org <will@kernel.org>; arnd at arndb.de <arnd@arndb.de>; olof at lixom.net <olof@lixom.net>; soc at kernel.org <soc@kernel.org>; mturquette at baylibre.com <mturquette@baylibre.com>; sboyd at kernel.org <sboyd@kernel.org>; p.zabel at pengutronix.de <p.zabel@pengutronix.de>; quic_bjorande at quicinc.com <quic_bjorande@quicinc.com>; geert+renesas at glider.be <geert+renesas@glider.be>; dmitry.baryshkov at linaro.org <dmitry.baryshkov@linaro.org>; shawnguo at kernel.org <shawnguo@kernel.org>; neil.armstrong at linaro.org <neil.armstrong@linaro.org>; m.szyprowski at samsung.com <m.szyprowski@samsung.com>; nfraprado at collabora.com <nfraprado@collabora.com>; u-kumar1 at ti.com <u-kumar1@ti.com>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; linux-clk at vger.kernel.org <linux-clk@vger.kernel.org>
??: Re: [PATCH v1 02/10] dt-binding: clk: ast2700: Add binding for Aspeed AST27xx Clock

On 26/07/2024 13:03, Kevin Chen wrote:
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

Missing commit msg.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> ---
>  .../dt-bindings/clock/aspeed,ast2700-clk.h    | 180 ++++++++++++++++++

This is supposed to be part of bindings adding the clock controller.

>  1 file changed, 180 insertions(+)
>  create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
>
> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> new file mode 100644
> index 000000000000..5ca85503736d
> --- /dev/null
> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> @@ -0,0 +1,180 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Device Tree binding constants for AST2700 clock controller.
> + *
> + * Copyright (c) 2023 Aspeed Technology Inc.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_AST2700_H
> +#define __DT_BINDINGS_CLOCK_AST2700_H
> +
> +/* SOC0 clk-gate */
> +#define SCU0_CLK_GATE_MCLK   (0)
> +#define SCU0_CLK_GATE_ECLK   (1)

Drop all (). Not needed, not useful.

> +#define SCU0_CLK_GATE_GCLK   (2)
> +#define SCU0_CLK_GATE_VCLK   (3)
> +#define SCU0_CLK_GATE_BCLK   (4)
> +#define SCU0_CLK_GATE_D1CLK  (5)
> +#define SCU0_CLK_GATE_REFCLK (6)
> +#define SCU0_CLK_GATE_USB0CLK        (7)
> +#define SCU0_CLK_GATE_RSV8   (8)
> +#define SCU0_CLK_GATE_USB1CLK        (9)
> +#define SCU0_CLK_GATE_D2CLK  (10)
> +#define SCU0_CLK_GATE_RSV11  (11)
> +#define SCU0_CLK_GATE_RSV12  (12)
> +#define SCU0_CLK_GATE_YCLK   (13)
> +#define SCU0_CLK_GATE_USB2CLK        (14)
> +#define SCU0_CLK_GATE_UART4CLK       (15)
> +#define SCU0_CLK_GATE_SLICLK (16)
> +#define SCU0_CLK_GATE_DACCLK (17)
> +#define SCU0_CLK_GATE_DP     (18)
> +#define SCU0_CLK_GATE_RSV19  (19)
> +#define SCU0_CLK_GATE_CRT1CLK        (20)
> +#define SCU0_CLK_GATE_CRT2CLK        (21)
> +#define SCU0_CLK_GATE_VLCLK  (22)
> +#define SCU0_CLK_GATE_ECCCLK (23)
> +#define SCU0_CLK_GATE_RSACLK (24)
> +#define SCU0_CLK_GATE_RVAS0CLK       (25)
> +#define SCU0_CLK_GATE_UFSCLK (26)
> +#define SCU0_CLK_GATE_EMMCCLK        (27)
> +#define SCU0_CLK_GATE_RVAS1CLK       (28)
> +/* reserved 29 ~ 31*/

IDs cannot be reserved. It is a binding, not a hardware number.

> +#define SOC0_CLK_GATE_NUM    (SCU0_CLK_GATE_RVAS1CLK + 1)

No drop. Others as well.

Best regards,
Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240815/c9988c0f/attachment-0001.htm>

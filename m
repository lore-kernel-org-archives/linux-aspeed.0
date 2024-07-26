From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Jul 2024 13:11:28 +0200
Subject: [PATCH v1 02/10] dt-binding: clk: ast2700: Add binding for Aspeed
 AST27xx Clock
In-Reply-To: <20240726110355.2181563-3-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-3-kevin_chen@aspeedtech.com>
Message-ID: <e13c16db-e1a7-4ee0-867b-b184d421de7f@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
> +#define SCU0_CLK_GATE_MCLK	(0)
> +#define SCU0_CLK_GATE_ECLK	(1)

Drop all (). Not needed, not useful.

> +#define SCU0_CLK_GATE_GCLK	(2)
> +#define SCU0_CLK_GATE_VCLK	(3)
> +#define SCU0_CLK_GATE_BCLK	(4)
> +#define SCU0_CLK_GATE_D1CLK	(5)
> +#define SCU0_CLK_GATE_REFCLK	(6)
> +#define SCU0_CLK_GATE_USB0CLK	(7)
> +#define SCU0_CLK_GATE_RSV8	(8)
> +#define SCU0_CLK_GATE_USB1CLK	(9)
> +#define SCU0_CLK_GATE_D2CLK	(10)
> +#define SCU0_CLK_GATE_RSV11	(11)
> +#define SCU0_CLK_GATE_RSV12	(12)
> +#define SCU0_CLK_GATE_YCLK	(13)
> +#define SCU0_CLK_GATE_USB2CLK	(14)
> +#define SCU0_CLK_GATE_UART4CLK	(15)
> +#define SCU0_CLK_GATE_SLICLK	(16)
> +#define SCU0_CLK_GATE_DACCLK	(17)
> +#define SCU0_CLK_GATE_DP	(18)
> +#define SCU0_CLK_GATE_RSV19	(19)
> +#define SCU0_CLK_GATE_CRT1CLK	(20)
> +#define SCU0_CLK_GATE_CRT2CLK	(21)
> +#define SCU0_CLK_GATE_VLCLK	(22)
> +#define SCU0_CLK_GATE_ECCCLK	(23)
> +#define SCU0_CLK_GATE_RSACLK	(24)
> +#define SCU0_CLK_GATE_RVAS0CLK	(25)
> +#define SCU0_CLK_GATE_UFSCLK	(26)
> +#define SCU0_CLK_GATE_EMMCCLK	(27)
> +#define SCU0_CLK_GATE_RVAS1CLK	(28)
> +/* reserved 29 ~ 31*/

IDs cannot be reserved. It is a binding, not a hardware number.

> +#define SOC0_CLK_GATE_NUM	(SCU0_CLK_GATE_RVAS1CLK + 1)

No drop. Others as well.

Best regards,
Krzysztof


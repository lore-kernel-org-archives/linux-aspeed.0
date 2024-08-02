From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 2 Aug 2024 11:17:35 +0200
Subject: [PATCH v2 9/9] arm64: dts: aspeed: Add initial AST2700 EVB device
 tree
In-Reply-To: <20240802090544.2741206-11-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-11-kevin_chen@aspeedtech.com>
Message-ID: <00cd1d9e-24ec-47c2-b88b-d585b10da7e5@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/08/2024 11:05, Kevin Chen wrote:
> Add EVB board of AST2700 in ASPEED G7 Architecture.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  arch/arm64/boot/dts/aspeed/Makefile        |  4 ++
>  arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 58 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
>  create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> 
> diff --git a/arch/arm64/boot/dts/aspeed/Makefile b/arch/arm64/boot/dts/aspeed/Makefile
> new file mode 100644
> index 000000000000..ffe7e15017cc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/aspeed/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +dtb-$(CONFIG_ARCH_ASPEED) += \
> +	ast2700-evb.dtb
> diff --git a/arch/arm64/boot/dts/aspeed/ast2700-evb.dts b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> new file mode 100644
> index 000000000000..09c9569c0f7b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +
> +#include "aspeed-g7.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "AST2700A1-EVB";
> +	compatible = "aspeed,ast2700-evb", "aspeed,ast2700";
> +
> +	aliases {
> +		serial4 = &uart4;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,115200n8";
> +		stdout-path = &uart4;

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Best regards,
Krzysztof


From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 27 Mar 2022 20:55:01 +0200
Subject: [PATCH v3] ARM: dts: aspeed: add Nuvia DC-SCM BMC
In-Reply-To: <20220325190247.468079-1-quic_jaehyoo@quicinc.com>
References: <20220325190247.468079-1-quic_jaehyoo@quicinc.com>
Message-ID: <d0044322-72d8-1348-9898-dc91e3192e94@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/03/2022 20:02, Jae Hyun Yoo wrote:
> From: Graeme Gregory <quic_ggregory@quicinc.com>
> 
> Add initial version of device tree for Nuvia DC-SCM BMC which is
> equipped with Aspeed AST2600 BMC SoC.
> 
> Signed-off-by: Graeme Gregory <quic_ggregory@quicinc.com>
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> ---
> Changes in v3:
> * Added 'stdout-path'. (Krzysztof)
> 
> Changes in v2:
> * Added a comment to explain 'rgmii' phy mode setting. (Andrew)
> 
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts | 190 ++++++++++++++++++
>  2 files changed, 191 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7c16f8a2b738..e63cd6ed0faa 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1546,6 +1546,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-lenovo-hr630.dtb \
>  	aspeed-bmc-lenovo-hr855xg2.dtb \
>  	aspeed-bmc-microsoft-olympus.dtb \
> +	aspeed-bmc-nuvia-dc-scm.dtb \
>  	aspeed-bmc-opp-lanyang.dtb \
>  	aspeed-bmc-opp-mihawk.dtb \
>  	aspeed-bmc-opp-mowgli.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts b/arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts
> new file mode 100644
> index 000000000000..f4a97cfb0f23
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +
> +/ {
> +	model = "Nuvia DC-SCM BMC";
> +	compatible = "nuvia,dc-scm-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8";

After adding stdout-path, please remove bootargs.

Best regards,
Krzysztof

From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 01 Mar 2024 10:31:47 +1030
Subject: [PATCH v5 2/2] ARM: dts: aspeed: x4tf: Add dts for asus x4tf
 project
In-Reply-To: <20240229111123.1932504-2-Kelly_Hung@asus.com>
References: <20240229111123.1932504-1-Kelly_Hung@asus.com>
	 <20240229111123.1932504-2-Kelly_Hung@asus.com>
Message-ID: <cc13d3f4fc7f117d0f29cf18a085066fd4b560cc.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-02-29 at 19:11 +0800, Kelly Hung wrote:
> Base on aspeed-g6.dtsi and can boot into BMC console.
> 
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> 
> ---
> V4 -> V5: None
> V3 -> V4: None
> V2 -> V3:
> - fmc lable change to bmc.
> - use 64M partition layout.
> - rename spi1 label to bios.
> - remove bios partition section.
> V1 -> V2:
> - do schema check and remove all warings.
> - remove all unnecessary sections.
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 581 ++++++++++++++++++
>  2 files changed, 582 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index d3ac20e31..32c41f3d9 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
>  	aspeed-bmc-asrock-romed8hm3.dtb \
> +	aspeed-bmc-asus-x4tf.dtb \
>  	aspeed-bmc-bytedance-g220a.dtb \
>  	aspeed-bmc-delta-ahe50dc.dtb \
>  	aspeed-bmc-facebook-bletchley.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> new file mode 100644
> index 000000000..64f4ed07c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> @@ -0,0 +1,581 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2024 ASUS Corp.
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include "aspeed-g6-pinctrl.dtsi"

aspeed-g6.dtsi already includes aspeed-g6-pinctrl.dtsi, so the include
here is unnecessary.

Other than that the patch looks okay to me. There are bunch of issues
exposed by `make CHECK_DTBS=y aspeed/aspeed-bmc-asus-x4tf.dtb`, however
they're almost all generic issues with aspeed-g6.dtsi or deficient
binding definitions for the Aspeed controllers. I've put together a
patch stack to clean them up and am working to upstream them.

So for now:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

I'll put v5 in a tree for Joel to pick up if he doesn't have any
concerns. I'll drop the redundant include when applying the patch
there.

Andrew

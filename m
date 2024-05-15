From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 15 May 2024 16:11:21 +0200
Subject: [PATCH v5 2/4] ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
In-Reply-To: <20240514213510.159144-3-eajames@linux.ibm.com>
References: <20240514213510.159144-1-eajames@linux.ibm.com>
 <20240514213510.159144-3-eajames@linux.ibm.com>
Message-ID: <52bf83a5-f62a-4758-999b-9245d4a0ceab@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/05/2024 23:35, Eddie James wrote:
> Add the device tree for the new BMC system. The Blueridge is a
> P11 system with four processors.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1691 +++++++++++++++++
>  2 files changed, 1692 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index e51c6d2037255..f3db9ee156429 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-facebook-yosemitev2.dtb \
>  	aspeed-bmc-facebook-yosemite4.dtb \
> +	aspeed-bmc-ibm-blueridge.dtb \
>  	aspeed-bmc-ibm-bonnell.dtb \
>  	aspeed-bmc-ibm-everest.dtb \
>  	aspeed-bmc-ibm-rainier.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
> new file mode 100644
> index 0000000000000..418eaf0a46146
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
> @@ -0,0 +1,1691 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2024 IBM Corp.
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include "aspeed-g6.dtsi"
> +#include "ibm-power11-quad.dtsi"
> +
> +/ {
> +	model = "Blueridge";
> +	compatible = "ibm,blueridge-bmc", "aspeed,ast2600";

Undocumented binding.


Best regards,
Krzysztof


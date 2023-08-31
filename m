From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 31 Aug 2023 08:20:55 +0200
Subject: [PATCH v5 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
In-Reply-To: <20230831055030.3958798-2-peteryin.openbmc@gmail.com>
References: <20230831055030.3958798-1-peteryin.openbmc@gmail.com>
 <20230831055030.3958798-2-peteryin.openbmc@gmail.com>
Message-ID: <4cbe662d-cd20-ceef-e3e4-6608029f94b7@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 31/08/2023 07:50, Peter Yin wrote:
> Add linux device tree entry related to
> Minerva specific devices connected to BMC SoC.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 377 ++++++++++++++++++
>  2 files changed, 378 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9e1d7bf3cff6..edb0b2105333 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1604,6 +1604,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-wedge400.dtb \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-facebook-yosemitev2.dtb \
> +	aspeed-bmc-facebook-minerva.dtb \

Third or fourth time: that's not a correct order. This is a nit, but
since you keep ignoring it, I don't believe any other feedback was
applied. Why you did not respond to my comments but just ignored them?


Best regards,
Krzysztof


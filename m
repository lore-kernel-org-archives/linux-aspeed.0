From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 5 Oct 2023 09:31:23 +0200
Subject: [PATCH 4/7] ARM: dts: aspeed: mtmitchell: Add LEDs
In-Reply-To: <20231005035525.19036-5-chanh@os.amperecomputing.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com>
 <20231005035525.19036-5-chanh@os.amperecomputing.com>
Message-ID: <65a610df-5030-4dd0-9f04-2089dfe09a3d@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/10/2023 05:55, Chanh Nguyen wrote:
> Use gpio-leds to configure GPIOW5 to GPIO_ACTIVE_HIGH and
> GPIO_TRANSITORY flags as a bmc ready led. The GPIOW5 pin
> is reset when watchdog timeout occurs.
> 
> Configure the GPIOS3 to GPIO_ACTIVE_HIGH as an identify led.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index b7c4f7cfad07..88693c2b2dbe 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -51,6 +51,19 @@
>  		};
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		bmc-ready {

Missing led name.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


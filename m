From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Mon, 21 Sep 2020 11:46:00 +0200
Subject: [PATCH v2 03/15] arm64: dts: mediatek: fix tca6416 reset GPIOs in
 pumpkin
In-Reply-To: <20200910175733.11046-4-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-4-krzk@kernel.org>
Message-ID: <911e34dc-3516-d15d-89d6-1e234e9309f6@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/09/2020 19:57, Krzysztof Kozlowski wrote:
> Correct the property for reset GPIOs of tca6416 GPIO expander.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to v5.9-next/dts64

Thanks!

> ---
>   arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index dfceffe6950a..29d8cf6df46b 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -56,7 +56,7 @@
>   	tca6416: gpio at 20 {
>   		compatible = "ti,tca6416";
>   		reg = <0x20>;
> -		rst-gpio = <&pio 65 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&pio 65 GPIO_ACTIVE_HIGH>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&tca6416_pins>;
>   
> 

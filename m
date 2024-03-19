From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Mar 2024 10:50:02 +0100
Subject: [PATCH v2 3/4] ARM: dts: aspeed: Add eSPI node
In-Reply-To: <20240319093405.39833-4-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-4-manojkiran.eda@gmail.com>
Message-ID: <b238d70e-0361-4f3c-ae6a-4e6497b95d75@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19/03/2024 10:34, Manojkiran Eda wrote:
> This commit adds eSPI to the device tree for aspeed 5/6th
> generation SoCs.
> 
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 19 +++++++++++++++++++
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 20 ++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> index 04f98d1dbb97..eaf7d82b6f46 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> @@ -343,6 +343,25 @@ sdhci1: sdhci at 200 {
>  					status = "disabled";
>  				};
>  			};
> +			espi: espi at 1e6ee000 {

spi or syscon

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "aspeed,ast2500-espi", "simple-mfd", "syscon";
> +				reg = <0x1e6ee000 0x1000>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0x0 0x1e6ee000 0x1000>;
> +
> +				espi_ctrl: espi-ctrl at 0 {

What is this device? If parent is espi, then what is this?

Where is the binding?


Best regards,
Krzysztof


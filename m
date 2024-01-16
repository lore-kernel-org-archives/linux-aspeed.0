From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 16 Jan 2024 08:27:27 +0100
Subject: [PATCH v1] ARM: dts: aspeed-g6: Add I3C controller nodes
In-Reply-To: <20240116065050.3657049-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240116065050.3657049-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <e2310177-0b18-4615-978b-83a4fcd05f6c@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/01/2024 07:50, Delphine CC Chiu wrote:
> Add default device tree settings for the 6 I3C controllers embedded in
> the aspeed-g6 family SOCs.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 148 ++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index c4d1faade8be..ed5021001e7f 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -13,6 +13,12 @@ / {
>  	interrupt-parent = <&gic>;
>  
>  	aliases {
> +		i3c0 = &i3c0;
> +		i3c1 = &i3c1;
> +		i3c2 = &i3c2;
> +		i3c3 = &i3c3;
> +		i3c4 = &i3c4;
> +		i3c5 = &i3c5;
>  		i2c0 = &i2c0;
>  		i2c1 = &i2c1;
>  		i2c2 = &i2c2;
> @@ -577,6 +583,13 @@ wdt4: watchdog at 1e7850c0 {
>  				status = "disabled";
>  			};
>  
> +			i3c: bus at 1e7a0000 {
> +				compatible = "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x1e7a0000 0x8000>;
> +			};
> +
>  			peci0: peci-controller at 1e78b000 {
>  				compatible = "aspeed,ast2600-peci";
>  				reg = <0x1e78b000 0x100>;
> @@ -1139,3 +1152,138 @@ i2c15: i2c-bus at 800 {
>  		status = "disabled";
>  	};
>  };
> +
> +&i3c {
> +	i3c_global: i3cg at 0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		reg = <0x0 0x1000>;
> +		compatible = "aspeed,ast2600-i3c-global", "syscon";

There is no such compatible.

> +	};
> +
> +	i3c0: i3c0 at 2000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Anyway, please respect DTS coding style for order of properties.
Compatible is always first.

> +		compatible = "aspeed,ast2600-i3c", "syscon";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


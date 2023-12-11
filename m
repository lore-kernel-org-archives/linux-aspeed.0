From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 11 Dec 2023 09:05:43 +0100
Subject: [PATCH v2 12/14] ARM: dts: aspeed: yosemite4: add mctp config for
 NIC
In-Reply-To: <20231211024947.3990898-13-Delphine_CC_Chiu@wiwynn.com>
References: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
 <20231211024947.3990898-13-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <415438f8-04fe-4e30-a643-ca13278987a0@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/12/2023 03:49, Delphine CC Chiu wrote:
> add mctp config for NIC
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 073f27f1e35f..c8e3a85b7a11 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1273,40 +1273,64 @@ imux24: i2c at 0 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0>;
> +			mctp-controller;
>  			temperature-sensor at 1f {
>  				compatible = "ti,tmp421";
>  				reg = <0x1f>;
>  			};
> +
> +			emc1403 at 3c {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "smsc,emc1403";
> +				reg = <0x3c>;
> +			};
>  		};
>  
>  		imux25: i2c at 1 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <1>;
> +			mctp-controller;
>  			temperature-sensor at 1f {
>  				compatible = "ti,tmp421";
>  				reg = <0x1f>;
>  			};
> +
> +			emc1403 at 3c {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



In other places as well.

Best regards,
Krzysztof


From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 21 Feb 2024 10:54:54 +0100
Subject: [PATCH v3 6/9] ARM: dts: aspeed: Harma: Add PDB temperature
In-Reply-To: <20240221093925.2393604-7-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
 <20240221093925.2393604-7-peteryin.openbmc@gmail.com>
Message-ID: <c532285c-6104-473f-be12-a5e833484bd3@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/02/2024 10:39, Peter Yin wrote:
> Add PDB temperature sensor.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index ca3052cce0e0..4d5d1c822fa3 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -260,6 +260,11 @@ delta_brick at 69 {
>  		compatible = "pmbus";
>  		reg = <0x69>;
>  	};
> +
> +	tmp75 at 49 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof


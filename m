From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 1 May 2024 12:24:37 +0200
Subject: [PATCH] ARM: dts: aspeed-g6: Add nodes for i3c controllers
In-Reply-To: <20240501033832.1529340-1-jk@codeconstruct.com.au>
References: <20240501033832.1529340-1-jk@codeconstruct.com.au>
Message-ID: <65af46c3-e48f-4eae-8390-2bc01332ccbf@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/05/2024 05:38, Jeremy Kerr wrote:
> Add the i3c controller devices to the ast2600 g6 common dts. We add all
> 6 busses to the common g6 definition, but leave disabled through the
> status property, to be enabled per-platform.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 93 +++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 29f94696d8b1..f9d01599a965 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -866,6 +866,13 @@ i2c: bus at 1e78a000 {
>  				ranges = <0 0x1e78a000 0x1000>;
>  			};
>  
> +			i3c: bus at 1e7a0000 {
> +				compatible = "simple-bus";

What bus is it? Why is it even needed? If it is i3c, then for sure
compatible is wrong.

> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x1e7a0000 0x8000>;
> +			};
> +
>  			fsim0: fsi at 1e79b000 {
>  				compatible = "aspeed,ast2600-fsi-master", "fsi-master";
>  				reg = <0x1e79b000 0x94>;
> @@ -1125,3 +1132,89 @@ i2c15: i2c-bus at 800 {
>  		status = "disabled";
>  	};
>  };
> +
> +&i3c {

????

That's not how we construct DTS.  Overrides/extends of nodes are for
boards, not within DTSI.

Please provide full correct definition IN ONE place. See DTS coding style.

Best regards,
Krzysztof


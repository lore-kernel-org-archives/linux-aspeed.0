From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 01 Feb 2024 16:23:31 +1030
Subject: [PATCH v5 18/21] ARM: dts: aspeed: yosemite4: add mctp config
 for NIC
In-Reply-To: <20240131084134.328307-19-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-19-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <6f39a2cc2a853b45624553d5fdc66c3b65830721.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> add mctp config for NIC

How does this integrate into the MCTP network(s)? It would be good to
have more of a description.

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> Changelog:
>   - v4
>     - Revise device node name
>   - v2
>     - Add patch for NIC mctp config
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 7c7c9e85bb92..b9b6fe729cd6 100644
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
> +			temperature-sensor at 3c {
> +				compatible = "smsc,emc1403";
> +				reg = <0x3c>;
> +			};

This is unrelated to the MCTP configuration? Same with the other nodes
in the patch.

Andrew

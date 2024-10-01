From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 01 Oct 2024 10:07:23 +0930
Subject: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for
 four NICs
In-Reply-To: <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <fffb98e40d407c68dc3de6fd21c8a724be96e38a.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-09-30 at 15:04 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Add i2c-mux on Spider board for four NICs and add the temperature sensor
> and EEPROM for the NICs.
> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 75 ++++++++++++++++++-
>  1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index dbc992a625b7..b813140b3c5b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -26,6 +26,10 @@ aliases {
>  		i2c21 = &imux21;
>  		i2c22 = &imux22;
>  		i2c23 = &imux23;
> +		i2c24 = &imux24;
> +		i2c25 = &imux25;
> +		i2c26 = &imux26;
> +		i2c27 = &imux27;
>  		i2c34 = &imux34;
>  		i2c35 = &imux35;
>  	};
> @@ -1196,8 +1200,9 @@ adc at 35 {
>  };
>  
>  &i2c15 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>  	status = "okay";
> -	mctp-controller;

Why are you deleting this if you're not also deleting the MCTP endpoint
node?

Unless there's some reason this is related to the NICs, this should be
its own patch with its own justification.

Andrew

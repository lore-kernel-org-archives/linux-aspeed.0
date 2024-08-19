From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 19 Aug 2024 10:02:57 +0930
Subject: [PATCH v12 14/28] ARM: dts: aspeed: yosemite4: Revise ina233
 config for yosemite4 schematic change
In-Reply-To: <20240816092417.3651434-15-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240816092417.3651434-15-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <2aaf4cc4de2c3ed96400fc5d98e9873ea5ec1411.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-08-16 at 17:24 +0800, Delphine CC Chiu wrote:
> Revise ina233 config for yosemite4 schematic change
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 1765a0bb70d7..df389b506b4b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1034,28 +1034,38 @@ adc at 37 {
>  	};
>  
>  	power-sensor at 40 {
> -		compatible = "ti,ina230";
> +		compatible = "ti,ina233";

Can you please address my previous comment?

https://lore.kernel.org/all/86a3b58d00fc475065ad51458504a636e2f67e02.camel at codeconstruct.com.au/

Andrew

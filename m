From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 27 Sep 2024 15:27:25 +0930
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
 IOE on Spider Board
In-Reply-To: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-09-26 at 10:41 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Add I2C mux for CPLD IOE on Spider Board.
> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..ea1a9c765483 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -17,6 +17,9 @@ aliases {
>  		serial6 = &uart7;
>  		serial7 = &uart8;
>  		serial8 = &uart9;
> +
> +		i2c28 = &imux28;
> +		i2c29 = &imux29;
>  	};
>  

Have you tried to apply all of your individual yosemite4 patches
together in one branch? I have, and unfortunately I can't apply them
all, because they generate conflicts with each other.

If your patches have context dependencies you need to send them as a
single series and not separate patches that cannot be properly
combined.

Please assess the remaining yosemite4 devicetree patches (those you
haven't received a thank-you email for) and send an appropriately
constructed series so they can all be applied together, based on the
tree here:

https://github.com/amboar/linux/tree/for/bmc/dt

Please also indicate in the cover letter (with links to lore) which
remaining patches are truly independent that still need to be applied.

Thanks,

Andrew

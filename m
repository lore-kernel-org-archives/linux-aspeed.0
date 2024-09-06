From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:29:43 +0200
Subject: [PATCH v15 32/32] ARM: dts: aspeed: yosemite4: add ISL28022
 support on 11
In-Reply-To: <20240906062701.37088-33-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-33-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <b0f7c007-b9e8-4914-b3fe-d6d17b61661e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

You didn't run checkpatch, did you?

> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 0341b61aa1f1..e0cdda701c24 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1088,7 +1088,7 @@ power-sensor at 41 {
>  	};
>  
>  	power-sensor at 44 {
> -		compatible = "ti,ina238";
> +		compatible = "ti,ina238", "renesas,isl28022";

No. Read bindings.

Best regards,
Krzysztof


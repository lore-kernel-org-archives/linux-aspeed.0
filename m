From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:28:01 +0200
Subject: [PATCH v15 29/32] ARM: dts: aspeed: yosemitet4: add RTQ6056
 support on 11 (0x41).
In-Reply-To: <20240906062701.37088-30-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-30-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <c3f5a23e-591f-44e8-b197-6bc8e63c6e45@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> From: Ian-I-Chien <Ian_Chien@wiwynn.com>
> 

This is ridiculous... No commit msg, no explanation, subject inaccurate,
no SoB from anyone.

For obvious reasons this cannot be accepted.


> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 4090725160f9..d056f6d5ff6e 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1081,7 +1081,7 @@ power-sensor at 40 {
>  	};
>  
>  	power-sensor at 41 {
> -		compatible = "ti,ina233";
> +		compatible = "ti,ina233", "richtek,rtq6056";

NAK, not correct. Read bindings.

Best regards,
Krzysztof


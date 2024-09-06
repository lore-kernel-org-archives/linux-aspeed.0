From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:28:51 +0200
Subject: [PATCH v15 30/32] ARM: dts: aspeed: yosemite4: add SQ52205
 support
In-Reply-To: <20240906062701.37088-31-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-31-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <a8b2f7cb-17b7-457b-ac28-7e2e48e88f96@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> Add SQ52205 in yosemite4 DTS.

No, that's not what your commit is doing.

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index d056f6d5ff6e..04aa428f94b7 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1245,35 +1245,35 @@ adc at 37 {
>  	};
>  
>  	power-sensor at 40 {
> -		compatible = "ti,ina233", "richtek,rtq6056";
> +		compatible = "ti,ina233", "richtek,rtq6056", "silergy,sq52205";

Why are you changing same line multiple times? It does not make any sense.

Best regards,
Krzysztof


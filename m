From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:25:16 +0200
Subject: [PATCH v15 25/32] ARM: dts: aspeed: yosemite4: add RTQ6056
 support
In-Reply-To: <20240906062701.37088-26-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-26-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <adb49570-581b-46a1-88d6-99373ce2bc75@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index f73719b3c2f1..03a1e41312e3 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1240,35 +1240,35 @@ adc at 37 {
>  	};
>  
>  	power-sensor at 40 {
> -		compatible = "ti,ina233";
> +		compatible = "ti,ina233", "richtek,rtq6056";

NAK, this does not make sense, does not match bindings and is not
explained in commit msg.

Best regards,
Krzysztof


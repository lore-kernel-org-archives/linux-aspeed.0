From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:25:46 +0200
Subject: [PATCH v15 26/32] ARM: dts: aspeed: yosemite4: add MP5990 support
In-Reply-To: <20240906062701.37088-27-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-27-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <3d791a58-e311-4837-bc3f-f988bb5c085e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> Add MP5990 in yosemite4 DTS.

It's already there.

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 03a1e41312e3..f139f426099e 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -356,7 +356,7 @@ gpio at 24 {
>  	};
>  
>  	power-sensor at 40 {
> -		compatible = "adi,adm1281";
> +		compatible = "adi,adm1281", "mps,mp5990";

No, you keep sending same buggy patches.




Best regards,
Krzysztof


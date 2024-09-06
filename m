From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:29:02 +0200
Subject: [PATCH v15 31/32] ARM: dts: aspeed: yosemite4: add GPIO I6
In-Reply-To: <20240906062701.37088-32-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-32-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <474467d1-aa80-4ffb-a993-6f15d46bb4b7@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> Add BMC GPIO I6 for ALT_SMB_BMC_CPLD2_N.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 04aa428f94b7..0341b61aa1f1 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -2011,6 +2011,10 @@ pin_gpio_f7 {
>  		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
>  		input;
>  	};
> +	pin_gpio_i6 {

Follow DTS coding style.

Best regards,
Krzysztof


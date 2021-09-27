From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 27 Sep 2021 10:47:25 +0700
Subject: [PATCH v1] ARM: dts: aspeed: mtjade: Add some gpios
In-Reply-To: <20210917082945.19111-1-quan@os.amperecomputing.com>
References: <20210917082945.19111-1-quan@os.amperecomputing.com>
Message-ID: <96f3eda9-bb90-35c5-a6d8-870212046dff@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


+cc:openbmc email list

-Quan

On 17/09/2021 15:29, Quan Nguyen wrote:
> Add S0_SCP_AUTH_FAIL, S1_SCP_AUTH_FAIL gpios to indicates firmware
> authentication fail on each socket.
> 
> Add gpio RTC_BAT_SEN_EN to enable RTC battery adc sensor.
> 
> Add BMC_I2C4_O_EN gpio to go high at boot to enable access to I2C4 bus.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Signed-off-by: Thang Nguyen <thang@os.amperecomputing.com>
> ---
>   .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 21 ++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 57b0c45a2298..3515d55bd312 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -86,6 +86,18 @@ S0_cpu_fault {
>   			linux,code = <ASPEED_GPIO(J, 1)>;
>   		};
>   
> +		S0_scp_auth_fail {
> +			label = "S0_SCP_AUTH_FAIL";
> +			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(J, 2)>;
> +		};
> +
> +		S1_scp_auth_fail {
> +			label = "S1_SCP_AUTH_FAIL";
> +			gpios = <&gpio ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(Z, 5)>;
> +		};
> +
>   		S1_overtemp {
>   			label = "S1_OVERTEMP";
>   			gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
> @@ -590,7 +602,7 @@ &gpio {
>   	/*Q0-Q7*/	"","","","","","UID_BUTTON","","",
>   	/*R0-R7*/	"","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
>   			"OCP_MAIN_PWREN","RESET_BUTTON","","",
> -	/*S0-S7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","","RTC_BAT_SEN_EN","","","",
>   	/*T0-T7*/	"","","","","","","","",
>   	/*U0-U7*/	"","","","","","","","",
>   	/*V0-V7*/	"","","","","","","","",
> @@ -604,4 +616,11 @@ &gpio {
>   			"S1_BMC_DDR_ADR","","","","",
>   	/*AC0-AC7*/	"SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
>   			"BMC_OCP_PG";
> +
> +	i2c4_o_en {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "BMC_I2C4_O_EN";
> +	};
>   };
> 


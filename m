From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 1 Oct 2024 15:50:01 -0500
Subject: [PATCH v1 3/3] ARM: dts: aspeed: system1: Add GPIO line names
In-Reply-To: <20241001191756.234096-4-ninad@linux.ibm.com>
References: <20241001191756.234096-1-ninad@linux.ibm.com>
 <20241001191756.234096-4-ninad@linux.ibm.com>
Message-ID: <a795fef5-b2c4-4201-b481-86d97d60c81e@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 10/1/24 14:17, Ninad Palsule wrote:
> Add following GPIO line names so that userspace can control them
> - PCH related GPIOs
> - FPGA related GPIOs


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index c0219167a337a..35cb9fea308e8 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -370,17 +370,17 @@ &gpio0 {
>   	/*K0-K7*/	"","","","","","","","",
>   	/*L0-L7*/	"","","","","","","","bmc-ready",
>   	/*M0-M7*/	"","","","","","","","",
> -	/*N0-N7*/	"","","","","","","","",
> +	/*N0-N7*/	"fpga-debug-enable","","","","","","","",
>   	/*O0-O7*/	"","","","","","","","",
>   	/*P0-P7*/	"","","","","","","","bmc-hb",
> -	/*Q0-Q7*/	"","","","","","","","",
> +	/*Q0-Q7*/	"","","","","","","pch-ready","",
>   	/*R0-R7*/	"","","","","","","","",
>   	/*S0-S7*/	"","","","","","","rear-enc-fault0","rear-enc-id0",
>   	/*T0-T7*/	"","","","","","","","",
>   	/*U0-U7*/	"","","","","","","","",
>   	/*V0-V7*/	"","rtc-battery-voltage-read-enable","","power-chassis-control","","","","",
>   	/*W0-W7*/	"","","","","","","","",
> -	/*X0-X7*/	"","power-chassis-good","","","","","","",
> +	/*X0-X7*/	"fpga-pgood","power-chassis-good","pch-pgood","","","","","",
>   	/*Y0-Y7*/	"","","","","","","","",
>   	/*Z0-Z7*/	"","","","","","","","";
>   };

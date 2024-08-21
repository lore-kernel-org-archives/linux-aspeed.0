From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 21 Aug 2024 10:40:06 +0930
Subject: [PATCH v1 2/2] ARM: dts: aspeed: Harma: update sgpio line name
In-Reply-To: <20240820102904.1756785-3-peteryin.openbmc@gmail.com>
References: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
	 <20240820102904.1756785-3-peteryin.openbmc@gmail.com>
Message-ID: <4e49f0c3a0ec4f1e508cae289f82ddbd02f9c0a6.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

On Tue, 2024-08-20 at 18:29 +0800, Peter Yin wrote:
> From: Peter Yin <peter.yin@quantatw.com>
> 
> power-card-enable
> uart-switch-button
> power-fault-n
> asic0-card-type-detection0-n
> asic0-card-type-detection1-n
> asic0-card-type-detection2-n
> uart-switch-lsb
> uart-switch-msb
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>

Can you please your author email consistent with your Signed-off-by
email? Currently this generates a checkpatch warning:

   Executing: ./scripts/checkpatch.pl --strict -g HEAD
   WARNING: From:/Signed-off-by: email address mismatch: 'From: Peter Yin <peter.yin@quantatw.com>' != 'Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>'
   
Thanks,

Andrew

> ---
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts   | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index 92068c65eae4..9db95a791128 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -566,7 +566,7 @@ &gpio0 {
>  	/*B0-B7*/	"","","","",
>  			"bmc-spi-mux-select-0","led-identify","","",
>  	/*C0-C7*/	"reset-cause-platrst","","","","",
> -			"cpu0-err-alert","","",
> +			"cpu0-err-alert","power-card-enable","",
>  	/*D0-D7*/	"","","sol-uart-select","","","","","",
>  	/*E0-E7*/	"","","","","","","","",
>  	/*F0-F7*/	"","","","","","","","",
> @@ -585,7 +585,9 @@ &gpio0 {
>  	/*O0-O7*/	"","","","","","","","",
>  	/*P0-P7*/	"power-button","power-host-control",
>  			"reset-button","","led-power","","","",
> -	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
> +	/*Q0-Q7*/
> +			"","","","",
> +			"","power-chassis-control","","uart-switch-button",
>  	/*R0-R7*/	"","","","","","","","",
>  	/*S0-S7*/	"","","","","","","","",
>  	/*T0-T7*/	"","","","","","","","",
> @@ -685,7 +687,7 @@ &sgpiom0 {
>  	"FM_BOARD_REV_ID2","",
>  	"FM_BOARD_REV_ID1","",
>  	/*H0-H3 line 112-119*/
> -	"FM_BOARD_REV_ID0","",
> +	"FM_BOARD_REV_ID0","reset-control-cmos-clear",
>  	"","","","","","",
>  	/*H4-H7 line 120-127*/
>  	"","",
> @@ -716,9 +718,15 @@ &sgpiom0 {
>  	"cpu0-thermtrip-alert","",
>  	"reset-cause-pcie","",
>  	/*L4-L7 line 184-191*/
> -	"pvdd11-ocp-alert","","","","","","","",
> +	"pvdd11-ocp-alert","",
> +	"power-fault-n","",
> +	"asic0-card-type-detection0-n","",
> +	"asic0-card-type-detection1-n","",
>  	/*M0-M3 line 192-199*/
> -	"","","","","","","","",
> +	"asic0-card-type-detection2-n","",
> +	"uart-switch-lsb","",
> +	"uart-switch-msb","",
> +	"","",
>  	/*M4-M7 line 200-207*/
>  	"","","","","","","","",
>  	/*N0-N3 line 208-215*/


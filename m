From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Jul 2021 13:28:57 +0930
Subject: [PATCH 1/2] ARM: dts: rainier, everest: Add TPM reset GPIO
In-Reply-To: <20210727033319.473152-2-joel@jms.id.au>
References: <20210727033319.473152-1-joel@jms.id.au>
 <20210727033319.473152-2-joel@jms.id.au>
Message-ID: <4836fc6e-1b82-4cac-939c-a7d2052a9ea4@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 27 Jul 2021, at 13:03, Joel Stanley wrote:
> The GPIO is used to place the BMC-connected TPM in reset. This state is
> latched until the BMC is next reset, blocking access to the TPM for that
> boot.
> 
> On both machines this net is called TPM_RESET_LATCH_B.

Hmm, unless we have different schematics where this has been changed, 
it's TPM_RESET_LATCH_N for Rainier (Ingraham) but TPM_RESET_LATCH_B for 
Everest (Tola).

> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 2 +-
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts 
> b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> index aa24cac8e5be..4536cd538af9 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> @@ -253,7 +253,7 @@ &gpio0 {
>  	/*O0-O7*/	"","","","","","","","",
>  	/*P0-P7*/	"","","","","led-pcieslot-power","","","",
>  	/*Q0-Q7*/	"","","","","","","","",
> -	/*R0-R7*/	"","","","","","I2C_FLASH_MICRO_N","","",
> +	/*R0-R7*/	"bmc-tpm-reset","","","","","I2C_FLASH_MICRO_N","","",
>  	/*S0-S7*/	"","","","","","","","",
>  	/*T0-T7*/	"","","","","","","","",
>  	/*U0-U7*/	"","","","","","","","",
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts 
> b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 481d0ee1f85f..06b3d1573780 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -271,7 +271,7 @@ &gpio0 {
>  	/*O0-O7*/	"","","","usb-power","","","","",
>  	/*P0-P7*/	"","","","","pcieslot-power","","","",
>  	/*Q0-Q7*/	"cfam-reset","","","","","","","",
> -	/*R0-R7*/	"","","","","","","","",
> +	/*R0-R7*/	"bmc-tpm-reset","","","","","","","",

Andrew G (/ Joel): we should probably add a "*-reset" class of GPIOs to 
the documentation ([1]). bmc-tpm-reset seems fine to me.

We should probably resolve the net name issue, but other than that:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

[1] https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

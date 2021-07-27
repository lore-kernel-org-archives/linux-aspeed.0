From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Jul 2021 13:34:02 +0930
Subject: [PATCH 2/2] ARM: dts: aspeed: tacoma: Add TPM reset GPIO
In-Reply-To: <20210727033319.473152-3-joel@jms.id.au>
References: <20210727033319.473152-1-joel@jms.id.au>
 <20210727033319.473152-3-joel@jms.id.au>
Message-ID: <7b4c65c0-fd00-4a5e-986e-7072d20db6ea@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 27 Jul 2021, at 13:03, Joel Stanley wrote:
> The GPIO is used to place the BMC-connected TPM in reset.
> 
> The net is called BMC_TPM_RST_N on Tacoma.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index e33153dcaea8..e39f310d55eb 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -126,7 +126,7 @@ &gpio0 {
>  	/*M0-M7*/	"","","","","","","","",
>  	/*N0-N7*/	"","","","","","","","",
>  	/*O0-O7*/	"led-rear-power","led-rear-id","","usb-power","","","","",
> -	/*P0-P7*/	"","","","","","","","",
> +	/*P0-P7*/	"","","","","","bmc-tpm-reset","","",

Needs the documentation update, but otherwise:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

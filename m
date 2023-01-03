From: Patrick Williams <patrick@stwcx.xyz>
Date: Tue, 3 Jan 2023 15:02:21 -0600
Subject: [PATCH 2/2] ARM: dts: aspeed: bletchley: enable wdtrst1
In-Reply-To: <20221226054535.2836110-3-potin.lai.pt@gmail.com>
References: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
 <20221226054535.2836110-3-potin.lai.pt@gmail.com>
Message-ID: <Y7SX3XQdRKcVFwSe@heinlein.taila677.ts.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 26, 2022 at 01:45:35PM +0800, Potin Lai wrote:
> Enable WDTRST1 external signal to send a reset pluse to peripherals while
> BMC reset.

nit: s/pluse/pulse

> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index 791f83aaac50..050ed7e810fa 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -1064,3 +1064,14 @@ pinctrl_gpiov2_unbiased_default: gpiov2 {
>  		bias-disable;
>  	};
>  };
> +
> +&wdt1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdtrst1_default>;
> +	aspeed,reset-type = "soc";
> +	aspeed,external-signal;
> +	aspeed,ext-push-pull;
> +	aspeed,ext-active-high;
> +	aspeed,ext-pulse-duration = <256>;
> +};
> -- 
> 2.31.1
> 

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230103/252a9a57/attachment.sig>

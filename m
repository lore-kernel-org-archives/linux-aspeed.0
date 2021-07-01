From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 01 Jul 2021 13:36:37 +0930
Subject: [PATCH v1] ARM: dts: fp5280g2: Add KCS node for LPC MCTP
In-Reply-To: <20210625074031.32576-1-liuxiwei@inspur.com>
References: <20210625074031.32576-1-liuxiwei@inspur.com>
Message-ID: <8c808410-6444-46a3-8779-29ba1453a5ca@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi George,

On Fri, 25 Jun 2021, at 17:10, George Liu wrote:
> Signed-off-by: George Liu <liuxiwei@inspur.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts 
> b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> index 1752f3250e44..66c0542b2694 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> @@ -300,6 +300,11 @@ &lpc_ctrl {
>  	flash = <&spi1>;
>  };
>  
> +&kcs4 {
> +	compatible = "openbmc,mctp-lpc";
> +	status = "okay";
> +};

This was a gross hack that we carried for a bit, it never went or was 
intended to go upstream. Please just use the standard KCS bindings.

Cheers,

Andrew

From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 05 Jun 2019 11:01:34 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_1/3_linux_dev-5.1_arm/soc_v2]_ARM:_dts:_aspeed:_Add?=
 =?UTF-8?Q?_SGPM_pinmux?=
In-Reply-To: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
References: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
Message-ID: <b899d98e-6f13-4728-9a62-3228ae7a2021@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 5 Jun 2019, at 07:12, Hongwei Zhang wrote:
> Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for
> supporting SGPIO in AST2500 SoC.
> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 85ed9db..8d30818 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -1321,6 +1321,11 @@
>  		groups = "SDA2";
>  	};
>  
> +	pinctrl_sgpm_default: sgpm_default {
> +		function = "SGPM";
> +		groups = "SGPM";
> +	};
> +
>  	pinctrl_sgps1_default: sgps1_default {
>  		function = "SGPS1";
>  		groups = "SGPS1";
> -- 
> 2.7.4
> 
>

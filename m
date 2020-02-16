From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 17 Feb 2020 10:22:57 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v2_1/2]_ARM:_dts:_aspeed:_ast2500:_Fix_SCU_IRQ_cont?=
 =?UTF-8?Q?roller_node?=
In-Reply-To: <1581363147-19310-2-git-send-email-eajames@linux.ibm.com>
References: <1581363147-19310-1-git-send-email-eajames@linux.ibm.com>
 <1581363147-19310-2-git-send-email-eajames@linux.ibm.com>
Message-ID: <b4582178-9b9d-494e-a458-d5576b4e0266@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 11 Feb 2020, at 06:02, Eddie James wrote:
> The node was defined with a unit address but had no reg property,
> resulting in a warning. Add a reg property for consistency to fix the
> warning.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 569f9d7..9db7bde 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -225,6 +225,7 @@
>  				scu_ic: interrupt-controller at 18 {
>  					#interrupt-cells = <1>;
>  					compatible = "aspeed,ast2500-scu-ic";
> +					reg = <0x18 0x4>;
>  					interrupts = <21>;
>  					interrupt-controller;
>  				};
> -- 
> 1.8.3.1
> 
>

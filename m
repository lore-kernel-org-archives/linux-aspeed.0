From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 17 Feb 2020 10:24:03 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v2_2/2]_ARM:_dts:_aspeed:_ast2600:_Fix_SCU_IRQ_cont?=
 =?UTF-8?Q?roller_nodes?=
In-Reply-To: <1581363147-19310-3-git-send-email-eajames@linux.ibm.com>
References: <1581363147-19310-1-git-send-email-eajames@linux.ibm.com>
 <1581363147-19310-3-git-send-email-eajames@linux.ibm.com>
Message-ID: <549d68fc-22ea-43d7-80ea-52143fe79321@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 11 Feb 2020, at 06:02, Eddie James wrote:
> The nodes were defined with a unit address but had no reg property,
> resulting in a warning. Add the reg properties for consistency to fix
> the warning.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 82a3cd1..301fdb4 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -269,16 +269,18 @@
>  					reg = <0x180 0x40>;
>  				};
>  
> -				scu_ic0: interrupt-controller at 0 {
> +				scu_ic0: interrupt-controller at 560 {
>  					#interrupt-cells = <1>;
>  					compatible = "aspeed,ast2600-scu-ic0";
> +					reg = <0x560 0x4>;
>  					interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-controller;
>  				};
>  
> -				scu_ic1: interrupt-controller at 1 {
> +				scu_ic1: interrupt-controller at 570 {
>  					#interrupt-cells = <1>;
>  					compatible = "aspeed,ast2600-scu-ic1";
> +					reg = <0x570 0x4>;
>  					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-controller;
>  				};
> -- 
> 1.8.3.1
> 
>

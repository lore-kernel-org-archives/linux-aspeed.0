From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Dec 2019 11:06:42 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v2_03/12]_ARM:_dts:_aspeed:_ast2500:_Add_SCU_interr?=
 =?UTF-8?Q?upt_controller?=
In-Reply-To: <1575566112-11658-4-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-4-git-send-email-eajames@linux.ibm.com>
Message-ID: <beb61d28-7284-44bb-8da8-2fb0b8a4ab5a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> Add a node for the interrupt controller provided by the SCU.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index a259c63..df44022 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -216,8 +216,9 @@
>  			syscon: syscon at 1e6e2000 {
>  				compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
>  				reg = <0x1e6e2000 0x1a8>;
> +				ranges = <0 0x1e6e2000 0x1a8>;
>  				#address-cells = <1>;
> -				#size-cells = <0>;
> +				#size-cells = <1>;

You're no-longer adding a reg property to the interrupt controller node below so the
hunk above is unnecessary.

Andrew

>  				#clock-cells = <1>;
>  				#reset-cells = <1>;
>  
> @@ -231,6 +232,13 @@
>  					compatible = "aspeed,ast2500-p2a-ctrl";
>  					status = "disabled";
>  				};
> +
> +				scu_ic: interrupt-controller at 18 {
> +					#interrupt-cells = <1>;
> +					compatible = "aspeed,ast2500-scu-ic";
> +					interrupts = <21>;
> +					interrupt-controller;
> +				};
>  			};
>  
>  			rng: hwrng at 1e6e2078 {
> -- 
> 1.8.3.1
> 
>

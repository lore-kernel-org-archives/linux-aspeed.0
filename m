From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 27 May 2021 10:57:43 +0930
Subject: [PATCH v1 2/4] ARM: dts: aspeed-g6: Add SGPIO node.
In-Reply-To: <20210526094609.14068-3-steven_lee@aspeedtech.com>
References: <20210526094609.14068-1-steven_lee@aspeedtech.com>
 <20210526094609.14068-3-steven_lee@aspeedtech.com>
Message-ID: <69b31043-957c-40af-9ab9-6bcc63ccdc85@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Steven,

On Wed, 26 May 2021, at 19:16, Steven Lee wrote:
> AST2600 supports 2 SGPIO master interfaces one with 128 pins another one
> with 80 pins.

Is there any chance the serial GPIO controllers can be explicitly 
listed in the Memory Space Allocation Table of the datasheet? Currently 
they're covered by the entry for "GPIO Controller (Parallel GPIO)" 
which is listed as ranging from 0x1e780000-0x1e7807ff.

Admittedly the details are listed in chapter 41 for the GPIO 
Controller, but it would be handy to not have to dig.

> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index f96607b7b4e2..556ce9535c22 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -377,6 +377,38 @@
>  				#interrupt-cells = <2>;
>  			};
>  
> +			sgpiom0: sgpiom at 1e780500 {
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				compatible = "aspeed,ast2600-sgpiom";
> +				reg = <0x1e780500 0x100>;
> +				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +				max-ngpios = <128>;

I need to think more about this one.

Andrew

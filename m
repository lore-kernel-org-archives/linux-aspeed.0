From: Marc Zyngier <maz@kernel.org>
Date: Thu, 17 Mar 2022 19:54:34 +0000
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks property
In-Reply-To: <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
Message-ID: <87h77wxslh.wl-maz@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 17 Mar 2022 19:15:26 +0000,
Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> 
> Arch timer either require clock-frequency property or doesn't need to
> specify clock at all in DT. In general, frequency can be determined
> internally and in case of brokern firmwares, need to extend
> clock-frequency to pass info to driver.

A clock frequency and a clock are not the same thing.

> 
> Aspeed BMC is the platform which defines clocks property, an invalid
> entry which can be safely removed.

Safely removed? Says who? Have you tested this change?

> 
> Moreover, clocks also matches incorrectly with the regex pattern.
> Remove this entry altogether to fix it.
> 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'

NAK. That's not a reason to randomly butcher things.

	M.

> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index c32e87fad4dc..d5ef9aceb632 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -64,7 +64,6 @@ timer {
>  			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> -		clocks = <&syscon ASPEED_CLK_HPLL>;
>  		arm,cpu-registers-not-fw-configured;
>  		always-on;
>  	};
> -- 
> 2.25.1
> 
> 

-- 
Without deviation from the norm, progress is not possible.

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 2 Aug 2024 11:12:10 +0200
Subject: [PATCH v2 8/9] arm64: dts: aspeed: Add initial AST27XX device
 tree
In-Reply-To: <20240802090544.2741206-10-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-10-kevin_chen@aspeedtech.com>
Message-ID: <34d1b859-dfee-475a-8838-feb4907985c8@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/08/2024 11:05, Kevin Chen wrote:
> Add aspeed-g7.dtsi to be AST27XX device tree.

Hardware description is missing, e.g. answering why you have two "soc"
nodes.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>



> +	soc0: soc at 10000000 {
> +		compatible = "simple-bus";
> +		reg = <0x0 0x10000000 0x0 0x10000000>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller at 12200000 {
> +			compatible = "arm,gic-v3";
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x12200000 0 0x10000>, /* GICD */
> +				  <0 0x12280000 0 0x80000>, /* GICR */
> +				  <0 0x40440000 0 0x1000>;  /* GICC */

Still the same things to fix... Please go to the DTS coding style and
read what is the order of properties.

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>


> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +		};


Best regards,
Krzysztof


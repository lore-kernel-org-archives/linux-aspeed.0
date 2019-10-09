From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 9 Oct 2019 15:32:40 +0200
Subject: [PATCH 2/5] ARM: dts: aspeed: add I2C buffer mode support
In-Reply-To: <20191007231313.4700-3-jae.hyun.yoo@linux.intel.com>
References: <20191007231313.4700-1-jae.hyun.yoo@linux.intel.com>
 <20191007231313.4700-3-jae.hyun.yoo@linux.intel.com>
Message-ID: <6f015065-3a45-878d-86b2-0edf10f1f4cb@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/10/2019 01:13, Jae Hyun Yoo wrote:
> Byte mode currently this driver uses makes lots of interrupt call
> which isn't good for performance and it makes the driver very
> timing sensitive. To improve performance of the driver, this commit
> adds buffer mode transfer support which uses I2C SRAM buffer
> instead of using a single byte buffer.
> 
> AST2400:
> It has 2 KBytes (256 Bytes x 8 pages) of I2C SRAM buffer pool from
> 0x1e78a800 to 0x1e78afff that can be used for all busses with
> buffer pool manipulation. To simplify implementation for supporting
> both AST2400 and AST2500, it assigns each 128 Bytes per bus without
> using buffer pool manipulation so total 1792 Bytes of I2C SRAM
> buffer will be used.
> 
> AST2500:
> It has 16 Bytes of individual I2C SRAM buffer per each bus and its
> range is from 0x1e78a200 to 0x1e78a2df, so it doesn't have 'buffer
> page selection' bit field in the Function control register, and
> neither 'base address pointer' bit field in the Pool buffer control
> register it has. To simplify implementation for supporting both
> AST2400 and AST2500, it writes zeros on those register bit fields
> but it's okay because it does nothing in AST2500.
> 
> This commit fixes all I2C bus nodes to support buffer mode
> transfer.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>


Reviewed-by: C?dric Le Goater <clg@kaod.org>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 47 +++++++++++++++++++-------------
>  arch/arm/boot/dts/aspeed-g5.dtsi | 47 +++++++++++++++++++-------------
>  2 files changed, 56 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index dffb595d30e4..f51b016aa769 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -420,12 +420,21 @@
>  };
>  
>  &i2c {
> -	i2c_ic: interrupt-controller at 0 {
> -		#interrupt-cells = <1>;
> -		compatible = "aspeed,ast2400-i2c-ic";
> +	i2c_gr: i2c-global-regs at 0 {
> +		compatible = "aspeed,ast2400-i2c-gr", "syscon";
>  		reg = <0x0 0x40>;
> -		interrupts = <12>;
> -		interrupt-controller;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x40>;
> +
> +		i2c_ic: interrupt-controller at 0 {
> +			#interrupt-cells = <1>;
> +			compatible = "aspeed,ast2400-i2c-ic";
> +			reg = <0x0 0x4>;
> +			interrupts = <12>;
> +			interrupt-controller;
> +		};
>  	};
>  
>  	i2c0: i2c-bus at 40 {
> @@ -433,7 +442,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x40 0x40>;
> +		reg = <0x40 0x40>, <0x800 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -449,7 +458,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x80 0x40>;
> +		reg = <0x80 0x40>, <0x880 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -465,7 +474,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0xc0 0x40>;
> +		reg = <0xc0 0x40>, <0x900 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -482,7 +491,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x100 0x40>;
> +		reg = <0x100 0x40>, <0x980 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -499,7 +508,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x140 0x40>;
> +		reg = <0x140 0x40>, <0xa00 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -516,7 +525,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x180 0x40>;
> +		reg = <0x180 0x40>, <0xa80 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -533,7 +542,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x1c0 0x40>;
> +		reg = <0x1c0 0x40>, <0xb00 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -550,7 +559,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x300 0x40>;
> +		reg = <0x300 0x40>, <0xb80 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -567,7 +576,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x340 0x40>;
> +		reg = <0x340 0x40>, <0xc00 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -584,7 +593,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x380 0x40>;
> +		reg = <0x380 0x40>, <0xc80 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -601,7 +610,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x3c0 0x40>;
> +		reg = <0x3c0 0x40>, <0xd00 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -618,7 +627,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x400 0x40>;
> +		reg = <0x400 0x40>, <0xd80 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -635,7 +644,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x440 0x40>;
> +		reg = <0x440 0x40>, <0xe00 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -652,7 +661,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x480 0x40>;
> +		reg = <0x480 0x40>, <0xe80 0x80>;
>  		compatible = "aspeed,ast2400-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index e8feb8b66a2f..cbc31ce3fab2 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -513,12 +513,21 @@
>  };
>  
>  &i2c {
> -	i2c_ic: interrupt-controller at 0 {
> -		#interrupt-cells = <1>;
> -		compatible = "aspeed,ast2500-i2c-ic";
> +	i2c_gr: i2c-global-regs at 0 {
> +		compatible = "aspeed,ast2500-i2c-gr", "syscon";
>  		reg = <0x0 0x40>;
> -		interrupts = <12>;
> -		interrupt-controller;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x40>;
> +
> +		i2c_ic: interrupt-controller at 0 {
> +			#interrupt-cells = <1>;
> +			compatible = "aspeed,ast2500-i2c-ic";
> +			reg = <0x0 0x4>;
> +			interrupts = <12>;
> +			interrupt-controller;
> +		};
>  	};
>  
>  	i2c0: i2c-bus at 40 {
> @@ -526,7 +535,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x40 0x40>;
> +		reg = <0x40 0x40>, <0x200 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -542,7 +551,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x80 0x40>;
> +		reg = <0x80 0x40>, <0x210 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -558,7 +567,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0xc0 0x40>;
> +		reg = <0xc0 0x40>, <0x220 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -575,7 +584,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x100 0x40>;
> +		reg = <0x100 0x40>, <0x230 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -592,7 +601,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x140 0x40>;
> +		reg = <0x140 0x40>, <0x240 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -609,7 +618,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x180 0x40>;
> +		reg = <0x180 0x40>, <0x250 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -626,7 +635,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x1c0 0x40>;
> +		reg = <0x1c0 0x40>, <0x260 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -643,7 +652,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x300 0x40>;
> +		reg = <0x300 0x40>, <0x270 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -660,7 +669,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x340 0x40>;
> +		reg = <0x340 0x40>, <0x280 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -677,7 +686,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x380 0x40>;
> +		reg = <0x380 0x40>, <0x290 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -694,7 +703,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x3c0 0x40>;
> +		reg = <0x3c0 0x40>, <0x2a0 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -711,7 +720,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x400 0x40>;
> +		reg = <0x400 0x40>, <0x2b0 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -728,7 +737,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x440 0x40>;
> +		reg = <0x440 0x40>, <0x2c0 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> @@ -745,7 +754,7 @@
>  		#size-cells = <0>;
>  		#interrupt-cells = <1>;
>  
> -		reg = <0x480 0x40>;
> +		reg = <0x480 0x40>, <0x2d0 0x10>;
>  		compatible = "aspeed,ast2500-i2c-bus";
>  		clocks = <&syscon ASPEED_CLK_APB>;
>  		resets = <&syscon ASPEED_RESET_I2C>;
> 


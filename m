From: Dinh Nguyen <dinguyen@kernel.org>
Date: Tue, 6 Dec 2022 15:01:54 -0600
Subject: [PATCH 05/11] ARM: dts: socfpga: Fix pca9548 i2c-mux node name
In-Reply-To: <a7bcc2de6c2c0946f56b2d9f9584c55cf28545dc.1669999298.git.geert+renesas@glider.be>
References: <cover.1669999298.git.geert+renesas@glider.be>
 <a7bcc2de6c2c0946f56b2d9f9584c55cf28545dc.1669999298.git.geert+renesas@glider.be>
Message-ID: <98a97883-3303-20eb-5a18-cfa00af9443e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 12/2/22 10:49, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>      arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dtb: i2cswitch at 70: $nodename:0: 'i2cswitch at 70' does not match '^(i2c-?)?mux'
> 	    From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
>      arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dtb: i2cswitch at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2', 'i2c at 3', 'i2c at 4', 'i2c at 5', 'i2c at 6', 'i2c at 7' were unexpected)
>          From schema: Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> 
> Fix this by renaming the PCA9548 node to "i2c-mux", to match the I2C bus
> multiplexer/switch DT bindings and the Generic Names Recommendation in
> the Devicetree Specification.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> index f24f17c2f5ee6bc4..e0630b0eed036d35 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> @@ -141,7 +141,7 @@ at24 at 50 {
>   		reg = <0x50>;
>   	};
>   
> -	i2cswitch at 70 {
> +	i2c-mux at 70 {
>   		compatible = "nxp,pca9548";
>   		#address-cells = <1>;
>   		#size-cells = <0>;

Applied!

Thanks,
Dinh

From: Alexander Stein <alexander.stein@ew.tq-group.com>
Date: Fri, 09 Aug 2024 09:51:03 +0200
Subject: [PATCH] ARM: dts: Fix undocumented LM75 compatible nodes
In-Reply-To: <20240808164941.1407327-1-robh@kernel.org>
References: <20240808164941.1407327-1-robh@kernel.org>
Message-ID: <22384730.EfDdHjke4D@steina-w>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am Donnerstag, 8. August 2024, 18:49:38 CEST schrieb Rob Herring (Arm):
> "lm75" without any vendor is undocumented. It works with the Linux
> kernel since the I2C subsystem will do matches of the compatible string
> without a vendor prefix to the i2c_device_id and/or driver name.
> 
> Mostly replace "lm75" with "national,lm75" as that's the original part
> vendor and the compatible which matches what "lm75" matched with. In a
> couple of cases the node name or compatible gives a clue to the actual
> part and vendor and a more specific compatible can be used. In these
> cases, it does change the variant the kernel picks.
> 
> "nct75" is an OnSemi part which is compatible with TI TMP75C based on
> a comparison of the OnSemi NCT75 datasheet and configuration the Linux
> driver uses. Adding an OnSemi compatible would be an ABI change.
> 
> "nxp,lm75" is most likely an NXP part. NXP makes a LM75A and LM75B.
> Both are 11-bit resolution and 100ms sample time, so "national,lm75b" is
> the closest match.
> 
> While we're here, fix the node names to use the generic name
> "temperature-sensor".
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> SoC maintainers, Please take this directly.
> ---
>  .../aspeed/aspeed-bmc-facebook-greatlakes.dts |  2 +-
>  .../socfpga/socfpga_cyclone5_vining_fpga.dts  |  4 +--
>  .../dts/marvell/armada-385-clearfog-gtr.dtsi  |  8 ++---
>  .../boot/dts/nuvoton/nuvoton-npcm730-kudo.dts | 32 +++++++++----------
>  .../boot/dts/nuvoton/nuvoton-npcm750-evb.dts  |  6 ++--
>  arch/arm/boot/dts/nxp/imx/imx53-mba53.dts     |  4 +--
>  arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi   |  4 +--
>  .../dts/nxp/lpc/lpc4357-ea4357-devkit.dts     |  4 +--
>  .../boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts  |  2 +-
>  arch/arm/boot/dts/ti/omap/am335x-nano.dts     |  2 +-
>  .../boot/dts/xilinx/zynq-zturn-common.dtsi    |  4 +--
>  11 files changed, 36 insertions(+), 36 deletions(-)
> 
< [snip]
> diff --git a/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts b/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
> index 2117de872703..d155b3ec22ef 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
> @@ -175,8 +175,8 @@ expander: pca9554 at 20 {
>  		gpio-controller;
>  	};
>  
> -	sensor2: lm75 at 49 {
> -		compatible = "lm75";
> +	sensor2: temperature-sensor at 49 {
> +		compatible = "national,lm75";

I checked the old schematics. This is an NXP LM75A, so 'national,lm75a'
would be the correct compatible.

>  		reg = <0x49>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
> index b2d7271d1d24..d01c3aee0272 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
> @@ -254,8 +254,8 @@ pmic: mc34708 at 8 {
>  		interrupts = <6 4>; /* PATA_DATA6, active high */
>  	};
>  
> -	sensor1: lm75 at 48 {
> -		compatible = "lm75";
> +	sensor1: temperature-sensor at 48 {
> +		compatible = "national,lm75";

I checked the old schematics. This is an NXP LM75A, so 'national,lm75a'
would be the correct compatible.

Best regards,
Alexander

>  		reg = <0x48>;
>  	};
>  
> [snip]


-- 
TQ-Systems GmbH | M?hlstra?e 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M?nchen, HRB 105018
Gesch?ftsf?hrer: Detlef Schneider, R?diger Stahl, Stefan Schneider
http://www.tq-group.com/



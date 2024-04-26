From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 26 Apr 2024 10:29:08 +0930
Subject: [PATCH v1 2/2] Add nct7363 in yosemite4 dts
In-Reply-To: <20240425060626.2558515-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240425060626.2558515-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240425060626.2558515-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <cfa6d4071f3789ee6ddef302f685c63d4de0ba36.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-04-25 at 14:06 +0800, Delphine CC Chiu wrote:
> ARM: dts: aspeed: yosemite4:

This should be in the patch subject, not the commit message body.

> Add nct7363(0x21 and 0x23) in yosemite4.dts
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index e45293762316..06b709b0a706 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -467,6 +467,42 @@ channel at 5 {
>                                  };
>  			};
>  
> +			hwmon0: hwmon at 21 {

I feel hwmon describes a subsystem in linux more than it does hardware,
and using it for a node name feels a bit off to me. It's not listed in
the devicetree spec (v0.4) as a recommended generic name, and is only
used in a handful of devicetrees - two of which are ancient BMC
devicetrees:

((v6.9-rc5)) $ git grep -l hwmon@ -- arch/arm/boot/dts/
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts
arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts
arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateworks-gw2348.dts
arch/arm/boot/dts/intel/ixp/intel-ixp43x-gateworks-gw2358.dts
arch/arm/boot/dts/marvell/armada-370-c200-v2.dts
arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
arch/arm/boot/dts/microchip/lan966x.dtsi
arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts
arch/arm/boot/dts/xilinx/zynq-zc702.dts

> +				compatible = "nuvoton,nct7363";

This compatible seems to be undocumented as of v6.9-rc5? Should you
also send a binding patch?

Andrew

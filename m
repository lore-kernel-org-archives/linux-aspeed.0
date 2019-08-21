From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Wed, 21 Aug 2019 10:10:06 -0500
Subject: [PATCH] ARM: dts: aspeed: swift: Add eMMC device
In-Reply-To: <20190821045655.21752-1-joel@jms.id.au>
References: <20190821045655.21752-1-joel@jms.id.au>
Message-ID: <202dcd112f41044162465d8a724b66d0@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2019-08-20 23:56, Joel Stanley wrote:
> Swift contains an eMMC device attached to the second SDHCI controller.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Adriana Kobylak <anoo@us.ibm.com>

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> index f14f745b34ca..25bc0e1bbced 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> @@ -963,4 +963,15 @@
>  	status = "okay";
>  };
> 
> +&sdmmc {
> +       status = "okay";
> +};
> +
> +&sdhci1 {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_sd2_default>;
> +};
> +
>  #include "ibm-power9-dual.dtsi"


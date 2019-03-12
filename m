From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 12 Mar 2019 19:21:13 -0400
Subject: [PATCH] ARM: dts: Aspeed: Witherspoon: Update BMC partitioning
In-Reply-To: <1552409402-15881-1-git-send-email-anoo@linux.ibm.com>
References: <1552409402-15881-1-git-send-email-anoo@linux.ibm.com>
Message-ID: <34738643-a98f-480b-8a76-afdc9cb478e5@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 13 Mar 2019, at 03:21, Adriana Kobylak wrote:
> From: "Edward A. James" <eajames@us.ibm.com>
> 
> Add simplified partitions for BMC and alternate flash. Include these by
> default in Witherspoon.
> 
> Signed-off-by: Edward A. James <eajames@us.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

Yes please! Lets apply this so I can stop bashing my head against the desk when doing
kernel work on a Witherspoon.

> ---
>  .../boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi  | 18 ++++++++++++++++++
>  arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi | 18 ++++++++++++++++++
>  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts       |  3 ++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi 
> b/arch/arm/boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi
> new file mode 100644
> index 0000000..9277599
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi
> @@ -0,0 +1,18 @@
> +		label = "alt-bmc";
> +		partitions {
> +				#address-cells = < 1 >;
> +				#size-cells = < 1 >;
> +				compatible = "fixed-partitions";
> +				u-boot at 0 {
> +					reg = < 0 0x60000 >;
> +					label = "alt-u-boot";
> +				};
> +				u-boot-env at 60000 {
> +					reg = < 0x60000 0x20000 >;
> +					label = "alt-u-boot-env";
> +				};
> +				obmc-ubi at 80000 {
> +					reg = < 0x80000 0x1F80000 >;
> +					label = "alt-obmc-ubi";
> +				};
> +		};
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi 
> b/arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi
> new file mode 100644
> index 0000000..0059ad1
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi
> @@ -0,0 +1,18 @@
> +		label = "bmc";
> +		partitions {
> +				#address-cells = < 1 >;
> +				#size-cells = < 1 >;
> +				compatible = "fixed-partitions";
> +				u-boot at 0 {
> +					reg = < 0 0x60000 >;
> +					label = "u-boot";
> +				};
> +				u-boot-env at 60000 {
> +					reg = < 0x60000 0x20000 >;
> +					label = "u-boot-env";
> +				};
> +				obmc-ubi at 80000 {
> +					reg = < 0x80000 0x1F80000 >;
> +					label = "obmc-ubi";
> +				};
> +		};
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> index c51e3e8..058b9b7 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> @@ -191,7 +191,7 @@
>  		label = "bmc";
>  		m25p,fast-read;
>  		spi-max-frequency = <50000000>;
> -#include "openbmc-flash-layout.dtsi"
> +#include "aspeed-bmc-opp-flash-layout-ubi.dtsi"
>  	};
>  
>  	flash at 1 {
> @@ -199,6 +199,7 @@
>  		label = "alt";
>  		m25p,fast-read;
>  		spi-max-frequency = <50000000>;
> +#include "aspeed-bmc-alt-opp-flash-layout-ubi.dtsi"
>  	};
>  };
>  
> -- 
> 1.8.3.1
> 
>

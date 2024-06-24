From: Joel Stanley <joel@jms.id.au>
Date: Mon, 24 Jun 2024 11:25:12 +0930
Subject: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
In-Reply-To: <20240531193115.3814887-1-robh@kernel.org>
References: <20240531193115.3814887-1-robh@kernel.org>
Message-ID: <CACPK8Xes5vp+3YpQ3L5ix=LaDv7oWtqGFVc8moQf4D+o3rnLjg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 at 05:01, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The standard node name for I2C buses is 'i2c'.

Unfortunately this can't be merged, as it will break userspace. There
is a lot of code out there that looks up devices based on the device
tree node path:

https://github.com/openbmc/phosphor-state-manager/blob/3c1351cc2b63178876ef68f4107c9804d2e17dcc/meson.options#L140

Cheers,

Joel

>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 28 +++++++++++-----------
>  arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 28 +++++++++++-----------
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 32 ++++++++++++-------------
>  3 files changed, 44 insertions(+), 44 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
> index 857cb26ed6d7..c669ec202085 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
> @@ -463,7 +463,7 @@ i2c_ic: interrupt-controller at 0 {
>                 interrupt-controller;
>         };
>
> -       i2c0: i2c-bus at 40 {
> +       i2c0: i2c at 40 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -478,7 +478,7 @@ i2c0: i2c-bus at 40 {
>                 /* Does not need pinctrl properties */
>         };
>
> -       i2c1: i2c-bus at 80 {
> +       i2c1: i2c at 80 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -493,7 +493,7 @@ i2c1: i2c-bus at 80 {
>                 /* Does not need pinctrl properties */
>         };
>
> -       i2c2: i2c-bus at c0 {
> +       i2c2: i2c at c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -509,7 +509,7 @@ i2c2: i2c-bus at c0 {
>                 status = "disabled";
>         };
>
> -       i2c3: i2c-bus at 100 {
> +       i2c3: i2c at 100 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -525,7 +525,7 @@ i2c3: i2c-bus at 100 {
>                 status = "disabled";
>         };
>
> -       i2c4: i2c-bus at 140 {
> +       i2c4: i2c at 140 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -541,7 +541,7 @@ i2c4: i2c-bus at 140 {
>                 status = "disabled";
>         };
>
> -       i2c5: i2c-bus at 180 {
> +       i2c5: i2c at 180 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -557,7 +557,7 @@ i2c5: i2c-bus at 180 {
>                 status = "disabled";
>         };
>
> -       i2c6: i2c-bus at 1c0 {
> +       i2c6: i2c at 1c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -573,7 +573,7 @@ i2c6: i2c-bus at 1c0 {
>                 status = "disabled";
>         };
>
> -       i2c7: i2c-bus at 300 {
> +       i2c7: i2c at 300 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -589,7 +589,7 @@ i2c7: i2c-bus at 300 {
>                 status = "disabled";
>         };
>
> -       i2c8: i2c-bus at 340 {
> +       i2c8: i2c at 340 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -605,7 +605,7 @@ i2c8: i2c-bus at 340 {
>                 status = "disabled";
>         };
>
> -       i2c9: i2c-bus at 380 {
> +       i2c9: i2c at 380 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -621,7 +621,7 @@ i2c9: i2c-bus at 380 {
>                 status = "disabled";
>         };
>
> -       i2c10: i2c-bus at 3c0 {
> +       i2c10: i2c at 3c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -637,7 +637,7 @@ i2c10: i2c-bus at 3c0 {
>                 status = "disabled";
>         };
>
> -       i2c11: i2c-bus at 400 {
> +       i2c11: i2c at 400 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -653,7 +653,7 @@ i2c11: i2c-bus at 400 {
>                 status = "disabled";
>         };
>
> -       i2c12: i2c-bus at 440 {
> +       i2c12: i2c at 440 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -669,7 +669,7 @@ i2c12: i2c-bus at 440 {
>                 status = "disabled";
>         };
>
> -       i2c13: i2c-bus at 480 {
> +       i2c13: i2c at 480 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> index e6f3cf3c721e..6e05cbcce49c 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> @@ -592,7 +592,7 @@ i2c_ic: interrupt-controller at 0 {
>                 interrupt-controller;
>         };
>
> -       i2c0: i2c-bus at 40 {
> +       i2c0: i2c at 40 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -607,7 +607,7 @@ i2c0: i2c-bus at 40 {
>                 /* Does not need pinctrl properties */
>         };
>
> -       i2c1: i2c-bus at 80 {
> +       i2c1: i2c at 80 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -622,7 +622,7 @@ i2c1: i2c-bus at 80 {
>                 /* Does not need pinctrl properties */
>         };
>
> -       i2c2: i2c-bus at c0 {
> +       i2c2: i2c at c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -638,7 +638,7 @@ i2c2: i2c-bus at c0 {
>                 status = "disabled";
>         };
>
> -       i2c3: i2c-bus at 100 {
> +       i2c3: i2c at 100 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -654,7 +654,7 @@ i2c3: i2c-bus at 100 {
>                 status = "disabled";
>         };
>
> -       i2c4: i2c-bus at 140 {
> +       i2c4: i2c at 140 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -670,7 +670,7 @@ i2c4: i2c-bus at 140 {
>                 status = "disabled";
>         };
>
> -       i2c5: i2c-bus at 180 {
> +       i2c5: i2c at 180 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -686,7 +686,7 @@ i2c5: i2c-bus at 180 {
>                 status = "disabled";
>         };
>
> -       i2c6: i2c-bus at 1c0 {
> +       i2c6: i2c at 1c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -702,7 +702,7 @@ i2c6: i2c-bus at 1c0 {
>                 status = "disabled";
>         };
>
> -       i2c7: i2c-bus at 300 {
> +       i2c7: i2c at 300 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -718,7 +718,7 @@ i2c7: i2c-bus at 300 {
>                 status = "disabled";
>         };
>
> -       i2c8: i2c-bus at 340 {
> +       i2c8: i2c at 340 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -734,7 +734,7 @@ i2c8: i2c-bus at 340 {
>                 status = "disabled";
>         };
>
> -       i2c9: i2c-bus at 380 {
> +       i2c9: i2c at 380 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -750,7 +750,7 @@ i2c9: i2c-bus at 380 {
>                 status = "disabled";
>         };
>
> -       i2c10: i2c-bus at 3c0 {
> +       i2c10: i2c at 3c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -766,7 +766,7 @@ i2c10: i2c-bus at 3c0 {
>                 status = "disabled";
>         };
>
> -       i2c11: i2c-bus at 400 {
> +       i2c11: i2c at 400 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -782,7 +782,7 @@ i2c11: i2c-bus at 400 {
>                 status = "disabled";
>         };
>
> -       i2c12: i2c-bus at 440 {
> +       i2c12: i2c at 440 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -798,7 +798,7 @@ i2c12: i2c-bus at 440 {
>                 status = "disabled";
>         };
>
> -       i2c13: i2c-bus at 480 {
> +       i2c13: i2c at 480 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 7fb421153596..0c00882f111a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -905,7 +905,7 @@ udma: dma-controller at 1e79e000 {
>  #include "aspeed-g6-pinctrl.dtsi"
>
>  &i2c {
> -       i2c0: i2c-bus at 80 {
> +       i2c0: i2c at 80 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x80 0x80>;
> @@ -919,7 +919,7 @@ i2c0: i2c-bus at 80 {
>                 status = "disabled";
>         };
>
> -       i2c1: i2c-bus at 100 {
> +       i2c1: i2c at 100 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x100 0x80>;
> @@ -933,7 +933,7 @@ i2c1: i2c-bus at 100 {
>                 status = "disabled";
>         };
>
> -       i2c2: i2c-bus at 180 {
> +       i2c2: i2c at 180 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x180 0x80>;
> @@ -947,7 +947,7 @@ i2c2: i2c-bus at 180 {
>                 status = "disabled";
>         };
>
> -       i2c3: i2c-bus at 200 {
> +       i2c3: i2c at 200 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x200 0x80>;
> @@ -961,7 +961,7 @@ i2c3: i2c-bus at 200 {
>                 status = "disabled";
>         };
>
> -       i2c4: i2c-bus at 280 {
> +       i2c4: i2c at 280 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x280 0x80>;
> @@ -975,7 +975,7 @@ i2c4: i2c-bus at 280 {
>                 status = "disabled";
>         };
>
> -       i2c5: i2c-bus at 300 {
> +       i2c5: i2c at 300 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x300 0x80>;
> @@ -989,7 +989,7 @@ i2c5: i2c-bus at 300 {
>                 status = "disabled";
>         };
>
> -       i2c6: i2c-bus at 380 {
> +       i2c6: i2c at 380 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x380 0x80>;
> @@ -1003,7 +1003,7 @@ i2c6: i2c-bus at 380 {
>                 status = "disabled";
>         };
>
> -       i2c7: i2c-bus at 400 {
> +       i2c7: i2c at 400 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x400 0x80>;
> @@ -1017,7 +1017,7 @@ i2c7: i2c-bus at 400 {
>                 status = "disabled";
>         };
>
> -       i2c8: i2c-bus at 480 {
> +       i2c8: i2c at 480 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x480 0x80>;
> @@ -1031,7 +1031,7 @@ i2c8: i2c-bus at 480 {
>                 status = "disabled";
>         };
>
> -       i2c9: i2c-bus at 500 {
> +       i2c9: i2c at 500 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x500 0x80>;
> @@ -1045,7 +1045,7 @@ i2c9: i2c-bus at 500 {
>                 status = "disabled";
>         };
>
> -       i2c10: i2c-bus at 580 {
> +       i2c10: i2c at 580 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x580 0x80>;
> @@ -1059,7 +1059,7 @@ i2c10: i2c-bus at 580 {
>                 status = "disabled";
>         };
>
> -       i2c11: i2c-bus at 600 {
> +       i2c11: i2c at 600 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x600 0x80>;
> @@ -1073,7 +1073,7 @@ i2c11: i2c-bus at 600 {
>                 status = "disabled";
>         };
>
> -       i2c12: i2c-bus at 680 {
> +       i2c12: i2c at 680 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x680 0x80>;
> @@ -1087,7 +1087,7 @@ i2c12: i2c-bus at 680 {
>                 status = "disabled";
>         };
>
> -       i2c13: i2c-bus at 700 {
> +       i2c13: i2c at 700 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x700 0x80>;
> @@ -1101,7 +1101,7 @@ i2c13: i2c-bus at 700 {
>                 status = "disabled";
>         };
>
> -       i2c14: i2c-bus at 780 {
> +       i2c14: i2c at 780 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x780 0x80>;
> @@ -1115,7 +1115,7 @@ i2c14: i2c-bus at 780 {
>                 status = "disabled";
>         };
>
> -       i2c15: i2c-bus at 800 {
> +       i2c15: i2c at 800 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x800 0x80>;
> --
> 2.43.0
>

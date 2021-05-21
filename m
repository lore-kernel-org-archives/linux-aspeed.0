From: Joel Stanley <joel@jms.id.au>
Date: Fri, 21 May 2021 01:25:31 +0000
Subject: [PATCH v4 1/3] ARM: dts: aspeed: ast2600evb: Add sdhci node and
 gpio regulator for A2 evb.
In-Reply-To: <20210520101346.16772-2-steven_lee@aspeedtech.com>
References: <20210520101346.16772-1-steven_lee@aspeedtech.com>
 <20210520101346.16772-2-steven_lee@aspeedtech.com>
Message-ID: <CACPK8XcSYgQKRp7C5gZ9LKekL0LCHYPDwjC49EDTEr5__T2M3Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Steven,

On Thu, 20 May 2021 at 10:16, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> AST2600 A2(or newer) EVB has gpio regulators for toggling signal voltage
> between 3.3v and 1.8v, the patch adds sdhci node and gpio regulator in the
> new dts file and adds commment for describing the reference design.

spelling: comment

I need you to justify the separate dts for the A2 EVB.

What would happen if this device tree was loaded on to an A1 or A0?

Would this device tree be used for the A3 (and any future revision?)

An alternative proposal: we modify the ast2600-evb.dts to support the
A2 (which I assume would also support the A3).

If we need a separate board file for the A0 and A1 EVB, we add a new
one that supports these earlier revisions. Or we decide to only
support the latest revision in mainline.

>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb-a2.dts | 98 +++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-ast2600-evb-a2.dts
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb-a2.dts b/arch/arm/boot/dts/aspeed-ast2600-evb-a2.dts
> new file mode 100644
> index 000000000000..d581e8069a82
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb-a2.dts
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2021 IBM Corp.
> +
> +#include "aspeed-ast2600-evb.dts"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model = "AST2600 A2 EVB";
> +       compatible = "aspeed,ast2600";

Will this override the "aspeed,ast2600-evb" compatible in the dts? I
think you can drop the compatible string here and just use the one
from the DTS.

> +
> +       vcc_sdhci0: regulator-vcc-sdhci0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "SDHCI0 Vcc";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpios = <&gpio0 168

We have macros for describing the GPIOs:

ASPEED_GPIO(V, 0)

> +                        GPIO_ACTIVE_HIGH>;

This can go on one line.

> +               enable-active-high;
> +       };
> +
> +       vccq_sdhci0: regulator-vccq-sdhci0 {
> +               compatible = "regulator-gpio";
> +               regulator-name = "SDHCI0 VccQ";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpios = <&gpio0 169
> +                        GPIO_ACTIVE_HIGH>;
> +               gpios-states = <1>;
> +               states = <3300000 1>,
> +                        <1800000 0>;
> +       };
> +
> +       vcc_sdhci1: regulator-vcc-sdhci1 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "SDHCI1 Vcc";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpios = <&gpio0 170
> +                        GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       vccq_sdhci1: regulator-vccq-sdhci1 {
> +               compatible = "regulator-gpio";
> +               regulator-name = "SDHCI1 VccQ";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpios = <&gpio0 171
> +                        GPIO_ACTIVE_HIGH>;
> +               gpios-states = <1>;
> +               states = <3300000 1>,
> +                        <1800000 0>;
> +       };
> +};
> +
> +&sdc {
> +       status = "okay";
> +};
> +
> +/*
> + * The signal voltage of sdhci0 and sdhci1 on AST2600-A2 EVB is able to be
> + * toggled by GPIO pins.
> + * In the reference design, GPIOV0 of AST2600-A2 EVB is connected to the
> + * power load switch that providing 3.3v to sdhci0 vdd, GPIOV1 is connected to
> + * a 1.8v and a 3.3v power load switch that providing signal voltage to

nit: provides

> + * sdhci0 bus.
> + * If GPIOV0 is active high, sdhci0 is enabled, otherwise, sdhci0 is disabled.
> + * If GPIOV1 is active high, 3.3v power load switch is enabled, sdhci0 signal
> + * voltage is 3.3v, otherwise, 1.8v power load switch will be enabled,
> + * sdhci0 signal voltage becomes 1.8v.
> + * AST2600-A2 EVB also support toggling signal voltage for sdhci1.

nit: supports

> + * The design is the same as sdhci0, it uses GPIOV2 as power-gpio and GPIOV3
> + * as power-switch-gpio.
> + */
> +&sdhci0 {
> +       status = "okay";
> +       bus-width = <4>;
> +       max-frequency = <100000000>;
> +       sdhci-drive-type = /bits/ 8 <3>;
> +       sdhci-caps-mask = <0x7 0x0>;
> +       sdhci,wp-inverted;
> +       vmmc-supply = <&vcc_sdhci0>;
> +       vqmmc-supply = <&vccq_sdhci0>;
> +       clk-phase-sd-hs = <7>, <200>;
> +};
> +
> +&sdhci1 {
> +       status = "okay";
> +       bus-width = <4>;
> +       max-frequency = <100000000>;
> +       sdhci-drive-type = /bits/ 8 <3>;
> +       sdhci-caps-mask = <0x7 0x0>;
> +       sdhci,wp-inverted;
> +       vmmc-supply = <&vcc_sdhci1>;
> +       vqmmc-supply = <&vccq_sdhci1>;
> +       clk-phase-sd-hs = <7>, <200>;
> +};
> +
> --
> 2.17.1
>

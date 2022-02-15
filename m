From: Joel Stanley <joel@jms.id.au>
Date: Tue, 15 Feb 2022 05:48:37 +0000
Subject: [PATCH v2 05/10] arch: arm: dts: bletchley: switch to spi-gpio
 for spi2
In-Reply-To: <20220214042538.12132-6-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
 <20220214042538.12132-6-potin.lai@quantatw.com>
Message-ID: <CACPK8Xf5W4h=dcBg_Pe1zjXUK73h8YH1tfL4RvoxV3DVsCL90g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 14 Feb 2022 at 04:26, Potin Lai <potin.lai@quantatw.com> wrote:
>
> Switch to spi-gpio driver to avoid unstable signal issue with EVT HW
>
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index b01f1e7adb81..3c54e4a892c9 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -227,8 +227,16 @@
>
>  &spi2 {
>         status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_spi2_default>;
> +
> +       compatible = "spi-gpio";

This is a bit strange. You're effectively rewriting the node with a new one.

It would make more sense to leave spi2 disabled (the default), and add
a new node:

 spi {
   compatible = "spi-gpio";
   #address-cells = <1>;
   #size-cells = <0>;
   gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
   gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
   gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
   num-chipselects = <1>;
  cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;

   flash at 0 {
       status = "okay";

etc.

Your new spi node doesn't need the pinctrl or clock properties.

> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +       gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +       gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +       num-chipselects = <1>;
> +       cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
>
>         flash at 0 {
>                 status = "okay";
> --
> 2.17.1
>

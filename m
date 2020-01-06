From: Joel Stanley <joel@jms.id.au>
Date: Mon, 6 Jan 2020 06:47:39 +0000
Subject: [PATCH v1 1/1] ARM: dts: aspeed: update Hr855xg2 device tree
In-Reply-To: <1577350475-127530-1-git-send-email-pengms1@lenovo.com>
References: <1577350475-127530-1-git-send-email-pengms1@lenovo.com>
Message-ID: <CACPK8XeY5dPHtRfFD55dLVHT0SF1gJEVf1DixsbJKpciLP2s5Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 26 Dec 2019 at 08:54, Andrew Peng <pengms1@lenovo.com> wrote:
>

When you have a list of things like below, it's sometimes a good hint
that you should be sending one patch for each bullet point. This makes
it easier to review.

> Update i2c aliases.
> Change flash_memory mapping address and size.
> Add in a gpio-keys section.
> Enable vhub, vuart, spi1 and spi2.
> Add raa228006, ir38164 and sn1701022 hwmon sensors.
> Remove some unuse gpio from gpio section.

unused?

>
> Signed-off-by: Andrew Peng <pengms1@lenovo.com>
> Signed-off-by: Derek Lin <dlin23@lenovo.com>
> Signed-off-by: Yonghui Liu <liuyh21@lenovo.com>

I got two copies of this. I think they are the same.

> ---
> v1: initial version
>
>  arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts | 557 ++++++++++++++++-------
>  1 file changed, 382 insertions(+), 175 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> index 8193fad..e1386d4 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> @@ -15,14 +15,21 @@
>         compatible = "lenovo,hr855xg2-bmc", "aspeed,ast2500";
>

> -               flash_memory: region at 98000000 {
> +               flash_memory: region at 9EFF0000 {
>                         no-map;
> -                       reg = <0x98000000 0x00100000>; /* 1M */
> +                       reg = <0x9EFF0000 0x00010000>; /* 64K */

Do you really use 64K here, or was this a workaround for the lpc-ctlr
driver requiring a memory region?

If it's a workaround you can now drop the memory region phandle, as
the driver works without it.

> +&spi2 {
>         status = "okay";
>         pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_txd1_default
> -                       &pinctrl_rxd1_default>;
> +       pinctrl-0 = <&pinctrl_spi2ck_default
> +                               &pinctrl_spi2cs0_default
> +                               &pinctrl_spi2miso_default
> +                               &pinctrl_spi2mosi_default>;
> +
> +               spidev at 0 {
> +                               status = "okay";
> +                               compatible = "aspeed,spidev";
> +                               reg = < 0 >;
> +                               spi-max-frequency = <50000000>;
> +               };

This is for an out of tree driver? We discourage that, and prefer you
submit the driver upstream for review before adding it to the device
tree.

Please drop the sbidev bit from your next version.

> +
> +               flash at 0 {
> +                               compatible = "jedec,spi-nor";
> +                               m25p,fast-read;
> +                               label = "fpga";
> +                               reg = < 0 >;
> +                               spi-max-frequency = <50000000>;
> +                               status = "okay";
> +               };
>  };

> +&vuart {
>         status = "okay";
> +       auto-flow-control;
> +       espi-enabled = <&syscon 0x70 25>;

Is this the same as the upstreamed aspeed,sirq-polarity-sense?

Please review https://git.kernel.org/torvalds/c/8d310c9107a2a3f19dc7bb54dd50f70c65ef5409.
I think you will find you can drop the espi-enabled property as
aspeed-g5.dtsi now contains the same information.

> +               pcie_slot12: i2c at 4{
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <4>;
> +               };
> +
> +               switch0_i2c5:i2c at 5{

a space after the :

> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <5>;
> +                               eeprom at 54 {
> +                                               compatible = "atmel,24c04";
> +                                               pagesize = <16>;
> +                                               reg = <0x54>;
> +                               };
>                 };
>         };
>  };
> @@ -216,13 +377,43 @@
>         };
>
>         VR at 45 {
> -               compatible = "pmbus";
> +               compatible = "raa228006";

Please send this change once you've had your pmbus driver accepted by
Guneter. In the mean time I suggest dropping it from v2 so we can
merge the other changes.

>                 reg = <0x45>;
>         };
>  };
>

> +       CPU0_VCCIN at 60 {

Convention is to use lower case for node names.

> +               compatible = "raa228006";
> +               reg = <0x60>;
> +       };
> +

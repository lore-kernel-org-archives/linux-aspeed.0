From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Nov 2020 06:13:43 +0000
Subject: [PATCH 6/6] ARM: dts: aspeed: rainier: Add leds that are on
 optional PCI cable cards
In-Reply-To: <1605247168-1028-6-git-send-email-vishwa@linux.vnet.ibm.com>
References: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
 <1605247168-1028-6-git-send-email-vishwa@linux.vnet.ibm.com>
Message-ID: <CACPK8XfttMptuYFsocBaj2v4z1vzNjDUfe18FeDcAbmZjWKjfQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2020 at 05:59, Vishwanatha Subbanna
<vishwa@linux.vnet.ibm.com> wrote:
>
> These are LEDs on the cable cards that plug into PCIE slots.
> The LEDs are controlled by PCA9552 I2C expander
>
> Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 288 +++++++++++++++++++++++++++
>  1 file changed, 288 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 67c8c40..7de5f76 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -696,6 +696,70 @@
>                         gpios = <&pca4 7 GPIO_ACTIVE_LOW>;
>                 };
>         };
> +
> +       leds-optional-cablecard0 {

Is it necessary to have separate nodes for each of the different GPIO devices?

Would it make sense to combine them, or is it better to be separate?

Andrew, Eddie, Brad: please review this one before I merge it.

> +               compatible = "gpio-leds";
> +
> +               cablecard0-cxp-top {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca5 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               cablecard0-cxp-bot {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca5 1 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       leds-optional-cablecard3 {
> +               compatible = "gpio-leds";
> +
> +               cablecard3-cxp-top {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca6 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               cablecard3-cxp-bot {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca6 1 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       leds-optional-cablecard4 {
> +               compatible = "gpio-leds";
> +
> +               cablecard4-cxp-top {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca7 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               cablecard4-cxp-bot {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca7 1 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       leds-optional-cablecard10 {
> +               compatible = "gpio-leds";
> +
> +               cablecard10-cxp-top {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca8 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               cablecard10-cxp-bot {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca8 1 GPIO_ACTIVE_LOW>;
> +               };
> +       };
>  };
>
>  &ehci1 {
> @@ -1212,6 +1276,180 @@
>                 compatible = "atmel,24c64";
>                 reg = <0x52>;
>         };
> +
> +       pca5: pca9551 at 60 {
> +               compatible = "nxp,pca9551";
> +               reg = <0x60>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio at 0 {
> +                       reg = <0>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 1 {
> +                       reg = <1>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 2 {
> +                       reg = <2>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 3 {
> +                       reg = <3>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 4 {
> +                       reg = <4>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 5 {
> +                       reg = <5>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 6 {
> +                       reg = <6>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 7 {
> +                       reg = <7>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +       };
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +
> +       tmp275 at 48 {
> +               compatible = "ti,tmp275";
> +               reg = <0x48>;
> +       };
> +
> +       tmp275 at 49 {
> +               compatible = "ti,tmp275";
> +               reg = <0x49>;
> +       };
> +
> +       eeprom at 50 {
> +               compatible = "atmel,24c64";
> +               reg = <0x50>;
> +       };
> +
> +       eeprom at 51 {
> +               compatible = "atmel,24c64";
> +               reg = <0x51>;
> +       };
> +
> +       pca6: pca9551 at 60 {
> +               compatible = "nxp,pca9551";
> +               reg = <0x60>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio at 0 {
> +                       reg = <0>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 1 {
> +                       reg = <1>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 2 {
> +                       reg = <2>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 3 {
> +                       reg = <3>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 4 {
> +                       reg = <4>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 5 {
> +                       reg = <5>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 6 {
> +                       reg = <6>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 7 {
> +                       reg = <7>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +       };
> +
> +       pca7: pca9551 at 61 {
> +               compatible = "nxp,pca9551";
> +               reg = <0x61>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio at 0 {
> +                       reg = <0>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 1 {
> +                       reg = <1>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 2 {
> +                       reg = <2>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 3 {
> +                       reg = <3>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 4 {
> +                       reg = <4>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 5 {
> +                       reg = <5>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 6 {
> +                       reg = <6>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 7 {
> +                       reg = <7>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +       };
>  };
>
>  &i2c5 {
> @@ -2028,6 +2266,56 @@
>                 compatible = "atmel,24c64";
>                 reg = <0x51>;
>         };
> +
> +       pca8: pca9551 at 60 {
> +               compatible = "nxp,pca9551";
> +               reg = <0x60>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio at 0 {
> +                       reg = <0>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 1 {
> +                       reg = <1>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 2 {
> +                       reg = <2>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 3 {
> +                       reg = <3>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 4 {
> +                       reg = <4>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 5 {
> +                       reg = <5>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 6 {
> +                       reg = <6>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +
> +               gpio at 7 {
> +                       reg = <7>;
> +                       type = <PCA955X_TYPE_GPIO>;
> +               };
> +       };
>  };
>
>  &i2c12 {
> --
> 1.8.3.1
>

From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Nov 2020 06:14:08 +0000
Subject: [PATCH 1/6] ARM: dts: aspeed: rainier: Add Operator Panel LEDs
In-Reply-To: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
References: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
Message-ID: <CACPK8XchiV5OO0zLAUm9VPbOXNLQnKy-0=zj4=juLx2HS=BTZw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2020 at 05:59, Vishwanatha Subbanna
<vishwa@linux.vnet.ibm.com> wrote:
>
> These LEDs are on the operator panel and are connected via
> a PCA9551 I2C expander.
>
> Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 82 ++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 21ae880..64d8748 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -122,6 +122,38 @@
>                         reg = <3>;
>                 };
>         };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               /* System ID LED that is at front on Op Panel */
> +               front-sys-id0 {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca_oppanel 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               /* System Attention Indicator ID LED that is at front on Op Panel */
> +               front-check-log0 {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca_oppanel 1 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               /* Enclosure Fault LED that is at front on Op Panel */
> +               front-enc-fault1 {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca_oppanel 2 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               /* System PowerOn LED that is at front on Op Panel */
> +               front-sys-pwron0 {
> +                       retain-state-shutdown;
> +                       default-state = "keep";
> +                       gpios = <&pca_oppanel 3 GPIO_ACTIVE_LOW>;
> +               };
> +       };
>  };
>
>  &ehci1 {
> @@ -838,6 +870,56 @@
>                 };
>         };
>
> +       pca_oppanel: pca9551 at 60 {
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
>         ibm-panel at 62 {
>                 compatible = "ibm,op-panel";
>                 reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
> --
> 1.8.3.1
>

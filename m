From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Sep 2020 02:42:23 +0000
Subject: [PATCH v3 5/5] ARM: dts: Aspeed: Rainier: Add IBM Operation Panel
 I2C device
In-Reply-To: <20200909203059.23427-6-eajames@linux.ibm.com>
References: <20200909203059.23427-1-eajames@linux.ibm.com>
 <20200909203059.23427-6-eajames@linux.ibm.com>
Message-ID: <CACPK8XeWS23xdBKs7Ge+MWqHr4HANTVeC4LSLqEujcp8eG=auw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2020 at 20:31, Eddie James <eajames@linux.ibm.com> wrote:
>
> Set I2C bus 7 to multi-master mode and add the panel device that will
> register as a slave.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to the aspeed tree for v5.10.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index b94421f6cbd5..50d528444f5d 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -4,6 +4,7 @@
>
>  #include "aspeed-g6.dtsi"
>  #include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
>  #include <dt-bindings/leds/leds-pca955x.h>
>
>  / {
> @@ -698,6 +699,7 @@ eeprom at 53 {
>  };
>
>  &i2c7 {
> +       multi-master;
>         status = "okay";
>
>         si7021-a20 at 20 {
> @@ -831,6 +833,11 @@ gpio at 15 {
>                 };
>         };
>
> +       ibm-panel at 62 {
> +               compatible = "ibm,op-panel";
> +               reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
>         dps: dps310 at 76 {
>                 compatible = "infineon,dps310";
>                 reg = <0x76>;
> --
> 2.26.2
>

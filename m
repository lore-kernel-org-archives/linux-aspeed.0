From: Joel Stanley <joel@jms.id.au>
Date: Mon, 10 Feb 2020 22:23:34 +0000
Subject: [PATCH v2] ARM: dts: aspeed: tiogapass: Add IPMB device
In-Reply-To: <20200130214626.2863329-1-vijaykhemka@fb.com>
References: <20200130214626.2863329-1-vijaykhemka@fb.com>
Message-ID: <CACPK8Xfo1NcNmORHtpfDQzYQrLV0B=6+_nUtPftiHQoT6GrpPA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On Thu, 30 Jan 2020 at 21:46, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Adding IPMB devices for facebook tiogapass platform.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index fb7f034d5db2..1cb5b9bf468f 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -5,6 +5,7 @@
>
>  #include "aspeed-g5.dtsi"
>  #include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
>
>  / {
>         model = "Facebook TiogaPass BMC";
> @@ -428,6 +429,12 @@
>  &i2c4 {
>         status = "okay";
>         // BMC Debug Header
> +       multi-master;
> +       ipmb0 at 10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;

This causes dtc to warn:

../arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts:521.11-525.4:
Warning (i2c_bus_reg): /ahb/apb/bus at 1e78a000/i2c-bus at 380/ipmb0 at 10: I2C
bus unit address format error, expected "40000010"
../arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts:523.3-30:
Warning (i2c_bus_reg): /ahb/apb/bus at 1e78a000/i2c-bus at 380/ipmb0 at 10:reg:
I2C address must be less than 10-bits, got "0x40000010"

The bindings mention:

 Another flag is I2C_OWN_SLAVE_ADDRESS to mark addresses on which we listen to
be devices ourselves.

include/dt-bindings/i2c/i2c.h:#define I2C_OWN_SLAVE_ADDRESS     (1 << 30)

It appears dtc needs to be fixed to not warn when seeing this value in
an i2c reg node?

Cheers,

Joel



> +               i2c-protocol;
> +       };
>  };
>
>  &i2c5 {
> @@ -509,6 +516,12 @@
>  &i2c9 {
>         status = "okay";
>         //USB Debug Connector
> +       multi-master;
> +       ipmb0 at 10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
>  };
>
>  &pwm_tacho {
> --
> 2.17.1
>

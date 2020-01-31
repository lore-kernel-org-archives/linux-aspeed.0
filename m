From: Joel Stanley <joel@jms.id.au>
Date: Fri, 31 Jan 2020 03:56:20 +0000
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Add IPMB device
In-Reply-To: <20200128011728.4092945-1-vijaykhemka@fb.com>
References: <20200128011728.4092945-1-vijaykhemka@fb.com>
Message-ID: <CACPK8Xc6TbHLgWO3p7YXJf+jfzNhiGzGsdDwQsQ56ix8sUQGzg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2020 at 01:17, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Adding IPMB devices for facebook tiogapass platform.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will merge this through the aspeed tree for 5.7.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index fb7f034d5db2..719c130a198c 100644
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
> @@ -428,6 +429,11 @@
>  &i2c4 {
>         status = "okay";
>         // BMC Debug Header
> +       ipmb0 at 10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
>  };
>
>  &i2c5 {
> @@ -509,6 +515,11 @@
>  &i2c9 {
>         status = "okay";
>         //USB Debug Connector
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

From: Joel Stanley <joel@jms.id.au>
Date: Fri, 14 Dec 2018 09:26:05 +1030
Subject: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
In-Reply-To: <20181213195319.1333402-1-vijaykhemka@fb.com>
References: <20181213195319.1333402-1-vijaykhemka@fb.com>
Message-ID: <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 14 Dec 2018 at 06:23, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added ADC and other sensor devices in Facebook Tiogapass device tree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 33 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index f8e7b71af7e6..58bbe08d3ba7 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -21,6 +21,25 @@
>         memory at 80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               oemname0 = "MB_P3V3";
> +               oemname1 = "MB_P5V";
> +               oemname2 = "MB_P12V";
> +               oemname3 = "MB_P1V05";
> +               oemname4 = "MB_PVNN_PCH_STBY";
> +               oemname5 = "MB_P3V3_STBY";
> +               oemname6 = "MB_P5V_STBY";

"oemname" isn't part of the upstream bindings. Is this something you
have patches for?

The other parts of the patch lgtm.

> +               io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
> +                                       <&adc 4>, <&adc 5>, <&adc 6>;
> +       };
> +
> +       iio-hwmon-battery {
> +               oemname0 = "MB_P3V_BAT";
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 7>;
> +       };
>  };
>
>  &fmc {
> @@ -64,6 +83,10 @@
>         use-ncsi;
>  };
>
> +&adc {
> +       status = "okay";
> +};
> +
>  &i2c0 {
>         status = "okay";
>         //Airmax Conn B, CPU0 PIROM, CPU1 PIROM
> @@ -122,6 +145,10 @@
>
>  &i2c8 {
>         status = "okay";
> +       tmp421 at 1f {
> +               compatible = "ti,tmp421";
> +               reg = <0x1f>;
> +       };
>         //Mezz Sensor SMBus
>  };
>
> @@ -134,13 +161,15 @@
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +       oemname0 = "System_Fan_Connector_1";
> +       oemname1 = "System_Fan_Connector_3";
>         fan at 0 {
>                 reg = <0x00>;
>                 aspeed,fan-tach-ch = /bits/ 8 <0x00>;
>         };
>
>         fan at 1 {
> -               reg = <0x00>;
> -               aspeed,fan-tach-ch = /bits/ 8 <0x01>;
> +               reg = <0x01>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x02>;
>         };
>  };
> --
> 2.17.1
>

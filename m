From: Joel Stanley <joel@jms.id.au>
Date: Fri, 16 Apr 2021 02:55:17 +0000
Subject: [PATCH] ARM: dts: aspeed: amd-ethanolx: Enable all used I2C busses
In-Reply-To: <20210415155300.1135-1-aladyshev22@gmail.com>
References: <20210415155300.1135-1-aladyshev22@gmail.com>
Message-ID: <CACPK8XedxKUpgtXCzsmdHw7-U+ySzHmvvb8mGE8QJcxQrEMayg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 15 Apr 2021 at 15:53, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Enable all I2C busses that are used in AMD EthanolX CRB:
>  i2c0 - APML P0
>  i2c1 - APML P1
>  i2c2 - FPGA
>  i2c3 - 24LC128 EEPROM
>  i2c4 - P0 Power regulators
>  i2c5 - P1 Power regulators
>  i2c6 - P0/P1 Thermal diode
>  i2c7 - Thermal Sensors
>  i2c8 - BMC I2C
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Thanks, applied.

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index ac2d04cfaf2f..6aeb47c44eba 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -151,6 +151,31 @@ &i2c1 {
>         status = "okay";
>  };
>
> +//FPGA
> +&i2c2 {
> +       status = "okay";
> +};
> +
> +//24LC128 EEPROM
> +&i2c3 {
> +       status = "okay";
> +};
> +
> +//P0 Power regulators
> +&i2c4 {
> +       status = "okay";
> +};
> +
> +//P1 Power regulators
> +&i2c5 {
> +       status = "okay";
> +};
> +
> +//P0/P1 Thermal diode
> +&i2c6 {
> +       status = "okay";
> +};
> +
>  // Thermal Sensors
>  &i2c7 {
>         status = "okay";
> @@ -196,6 +221,11 @@ lm75a at 4f {
>         };
>  };
>
> +//BMC I2C
> +&i2c8 {
> +       status = "okay";
> +};
> +
>  &kcs1 {
>         status = "okay";
>         aspeed,lpc-io-reg = <0x60>;
> --
> 2.25.1
>

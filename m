From: Joel Stanley <joel@jms.id.au>
Date: Wed, 31 Mar 2021 07:48:23 +0000
Subject: [PATCH] ARM: dts: rainier: Update to access sensors via iio-hwmon
In-Reply-To: <20210329094255.347713-1-rashmica.g@gmail.com>
References: <20210329094255.347713-1-rashmica.g@gmail.com>
Message-ID: <CACPK8XchKxK9zbogk2rix6Hq5RW+XJuTq4YS4rBhdg+Uw_18Jg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 29 Mar 2021 at 09:43, Rashmica Gupta <rashmica.g@gmail.com> wrote:
>

Can you add a brief message about why we're adding a iio-hwmon bridge
for these sensors?

> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index fefb0b8fd6d5..2dc72de07906 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -173,6 +173,16 @@ i2c2mux3: i2c at 3 {
>                 };
>         };
>
> +       iio-hwmon-dps310 {
> +               compatible = "iio-hwmon";
> +               io-channels = <&dps 0>;
> +       };
> +
> +       iio-hwmon-si7020 {
> +               compatible = "iio-hwmon";
> +               io-channels = <&si 1>;
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>
> @@ -1972,9 +1982,10 @@ &i2c7 {
>         multi-master;
>         status = "okay";
>
> -       si7021-a20 at 20 {
> +       si:si7021-a20 at 20 {

That's a very short name. How about we call it humidity (or something else)?

Convention is to put a space after the colon.

>                 compatible = "silabs,si7020";
>                 reg = <0x20>;
> +               #io-channel-cells = <1>;
>         };
>
>         tmp275 at 48 {
> --
> 2.26.3
>

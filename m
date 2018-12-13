From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Dec 2018 11:33:44 +1030
Subject: [PATCH v4 1/2] ARM: dts: aspeed: Add KCS & lpc ctrl for Facebook
In-Reply-To: <20181212210352.1717617-1-vijaykhemka@fb.com>
References: <20181212210352.1717617-1-vijaykhemka@fb.com>
Message-ID: <CACPK8Xea5Q1c9ygvT+WtbwJN9p2Nn-bLo8Ea6U4KuFvFZXvkNg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 13 Dec 2018 at 07:34, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added kcs device and lpc ctrl device to enable LPC clock in Facebook
> Tiogapass device tree.

As we're going to re-spin, it's a good idea to have the KCS and LPC
changes in separate patches. I will take the KCS one straight away,
but the LPC one might need more work (see my comments below).

>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index d9d7f208788a..9544fa2c1822 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -21,6 +21,18 @@
>         memory at 80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               flash_memory: region at 98000000 {
> +                       no-map;
> +                       reg = <0x98000000 0x04000000>; /* 64M */
> +               };

Are you using this to expose some RAM over LPC? If not, we don't want this here.

It is a flaw in the design of the driver that the reserved memory
region is required. We should change the driver to make it optional.

As a workaround, we could add this patch to the tiogapass device tree
but make it smaller so you're not losing 64MB of RAM.

> +       };
> +
>         iio-hwmon {
>                 compatible = "iio-hwmon";
>                 oemname0 = "MB_P3V3";
> @@ -62,6 +74,12 @@
>         };
>  };
>
> +&lpc_ctrl {
> +       status = "okay";
> +       memory-region = <&flash_memory>;
> +       flash = <&spi1>;
> +};
> +
>  &uart1 {
>         // Host Console
>         status = "okay";
> @@ -75,6 +93,18 @@
>         status = "okay";
>  };
>
> +&kcs2 {
> +       // BMC KCS channel 2
> +       status = "okay";
> +       kcs_addr = <0xca8>;
> +};
> +
> +&kcs3 {
> +       // BMC KCS channel 3
> +       status = "okay";
> +       kcs_addr = <0xca2>;
> +};
> +
>  &mac0 {
>         status = "okay";
>
> --
> 2.17.1
>

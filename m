From: Joel Stanley <joel@jms.id.au>
Date: Wed, 22 Dec 2021 01:37:53 +0000
Subject: [PATCH] ARM: dts: aspeed: g220a: Enable secondary flash
In-Reply-To: <20211210093623.2140640-1-yulei.sh@bytedance.com>
References: <20211210093623.2140640-1-yulei.sh@bytedance.com>
Message-ID: <CACPK8XeK977rY33Kt3-vhEbqa68iXbG6vbRAfRGYxC94tE=t_g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Lei,

On Fri, 10 Dec 2021 at 09:36, Lei YU <yulei.sh@bytedance.com> wrote:
>
> Enable the secondary flash of the g220a's BMC and the wdt2.
>
> Signed-off-by: Lei YU <yulei.sh@bytedance.com>

I've applied this and the layout patch for v5.17, and to the openbmc tree.

> ---
>  arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
> index 01dace8f5e5f..05f392f42960 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
> @@ -260,6 +260,13 @@ flash at 0 {
>                 spi-max-frequency = <50000000>;
>  #include "openbmc-flash-layout-64.dtsi"
>         };
> +       flash at 1 {
> +               status = "okay";
> +               label = "alt-bmc";
> +               m25p,fast-read;
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64-alt.dtsi"
> +       };
>  };
>
>  &spi1 {
> @@ -278,6 +285,10 @@ &adc {
>         status = "okay";
>  };
>
> +&wdt2 {
> +       aspeed,alt-boot;
> +};
> +
>  &gpio {
>         status = "okay";
>         gpio-line-names =
> --
> 2.25.1
>

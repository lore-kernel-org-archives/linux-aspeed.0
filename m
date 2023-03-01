From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Mar 2023 01:30:05 +0000
Subject: [PATCH v2 3/3] ARM: dts: aspeed: asrock: Correct firmware flash
 SPI clocks
In-Reply-To: <20230224000400.12226-4-zev@bewilderbeest.net>
References: <20230224000400.12226-1-zev@bewilderbeest.net> <20230224000400.12226-4-zev@bewilderbeest.net>
Message-ID: <CACPK8XdFT=+VJJ=iDhcmWPh9m9of2b+2UYxkrAisp6tdmWOWKg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 24 Feb 2023 at 00:04, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> While I'm not aware of any problems that have occurred running these
> at 100 MHz, the official word from ASRock is that 50 MHz is the
> correct speed to use, so let's be safe and use that instead.

:(

Validated with which driver?

C?dric, do you have any thoughts on this?

>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Cc: stable at vger.kernel.org
> Fixes: 2b81613ce417 ("ARM: dts: aspeed: Add ASRock E3C246D4I BMC")
> Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")
> ---
>  arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 2 +-
>  arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> index 67a75aeafc2b..c4b2efbfdf56 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> @@ -63,7 +63,7 @@ flash at 0 {
>                 status = "okay";
>                 m25p,fast-read;
>                 label = "bmc";
> -               spi-max-frequency = <100000000>; /* 100 MHz */
> +               spi-max-frequency = <50000000>; /* 50 MHz */
>  #include "openbmc-flash-layout.dtsi"
>         };
>  };
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> index 00efe1a93a69..4554abf0c7cd 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> @@ -51,7 +51,7 @@ flash at 0 {
>                 status = "okay";
>                 m25p,fast-read;
>                 label = "bmc";
> -               spi-max-frequency = <100000000>; /* 100 MHz */
> +               spi-max-frequency = <50000000>; /* 50 MHz */
>  #include "openbmc-flash-layout-64.dtsi"
>         };
>  };
> --
> 2.39.1.438.gdcb075ea9396.dirty
>

From: Joel Stanley <joel@jms.id.au>
Date: Fri, 16 Apr 2021 03:03:25 +0000
Subject: [PATCH v1] ARM: dts: Fix 64MiB OpenBMC flash layout and
 aspeed-ast2600-evb.dts
In-Reply-To: <20210316085932.2601-1-troy_lee@aspeedtech.com>
References: <20210316085932.2601-1-troy_lee@aspeedtech.com>
Message-ID: <CACPK8XeYtaLLWDMR8xZhERrQ_WCUJ2RM_JZmZNQ6oZSvgSDM_w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 16 Mar 2021 at 08:59, Troy Lee <troy_lee@aspeedtech.com> wrote:
>
> Aspeed AST2600 u-boot requires 600KiB+ flash space. Sharing the same
> openbmc-flash-layout-64.dtsi requires to resize the flash partition.
>
> The updated flash layout as follows:
> - u-boot: 896 KiB
> - u-boot-env: 128 KiB
> - kernel: 9MiB
> - rofs: 32 MiB
> - rwfs: 22 MiB

Changing the 64MB layout will break the systems that are already using
this layout. I'll get the Bytedance people to chime in, as theirs is
the only system using this layout so far.

John, Lei?

>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts      | 32 +------------------
>  .../arm/boot/dts/openbmc-flash-layout-64.dtsi | 18 +++++------
>  2 files changed, 10 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index 89be13197780..2cfae9cfed3a 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -121,37 +121,7 @@ flash at 0 {
>                 m25p,fast-read;
>                 label = "bmc";
>                 spi-max-frequency = <50000000>;
> -
> -               partitions {
> -                       compatible = "fixed-partitions";
> -                       #address-cells = <1>;
> -                       #size-cells = <1>;
> -
> -                       u-boot at 0 {
> -                               reg = <0x0 0xe0000>; // 896KB
> -                               label = "u-boot";
> -                       };
> -
> -                       u-boot-env at e0000 {
> -                               reg = <0xe0000 0x20000>; // 128KB
> -                               label = "u-boot-env";
> -                       };
> -
> -                       kernel at 100000 {
> -                               reg = <0x100000 0x900000>; // 9MB
> -                               label = "kernel";
> -                       };
> -
> -                       rofs at a00000 {
> -                               reg = <0xa00000 0x2000000>; // 32MB
> -                               label = "rofs";
> -                       };
> -
> -                       rwfs at 6000000 {
> -                               reg = <0x2a00000 0x1600000>; // 22MB
> -                               label = "rwfs";
> -                       };
> -               };
> +#include "openbmc-flash-layout-64.dtsi"
>         };
>  };
>
> diff --git a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> index 91163867be34..31f59de5190b 100644
> --- a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> +++ b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> @@ -9,27 +9,27 @@ partitions {
>         #size-cells = <1>;
>
>         u-boot at 0 {
> -               reg = <0x0 0x60000>; // 384KB
> +               reg = <0x0 0xe0000>; // 896KB
>                 label = "u-boot";
>         };
>
> -       u-boot-env at 60000 {
> -               reg = <0x60000 0x20000>; // 128KB
> +       u-boot-env at e0000 {
> +               reg = <0xe0000 0x20000>; // 128KB
>                 label = "u-boot-env";
>         };
>
> -       kernel at 80000 {
> -               reg = <0x80000 0x500000>; // 5MB
> +       kernel at 100000 {
> +               reg = <0x100000 0x900000>; // 9MB
>                 label = "kernel";
>         };
>
> -       rofs at 580000 {
> -               reg = <0x580000 0x2a80000>; // 42.5MB
> +       rofs at a00000 {
> +               reg = <0xa00000 0x2000000>; // 32MB
>                 label = "rofs";
>         };
>
> -       rwfs at 3000000 {
> -               reg = <0x3000000 0x1000000>; // 16MB
> +       rwfs at 6000000 {
> +               reg = <0x2a00000 0x1600000>; // 22MB
>                 label = "rwfs";
>         };
>  };
> --
> 2.25.1
>

From: Joel Stanley <joel@jms.id.au>
Date: Tue, 19 Oct 2021 06:46:54 +0000
Subject: [PATCH v2 3/3] ARM: dts: aspeed: mtjade: Add uefi partition
In-Reply-To: <20211019060155.945-4-quan@os.amperecomputing.com>
References: <20211019060155.945-1-quan@os.amperecomputing.com>
 <20211019060155.945-4-quan@os.amperecomputing.com>
Message-ID: <CACPK8Xc_+HU3=rZtORUw+hu2SFbOm3ZYHkUnrrKpBcTUAfHeQw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 19 Oct 2021 at 06:02, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> Add SPI NOR partition for uefi.
>
> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> v2:
>   + Introdued in v2
>
>  arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 723c7063c223..4c3c3f1a12ea 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -374,6 +374,15 @@ flash at 0 {
>                 m25p,fast-read;
>                 label = "pnor";
>                 /* spi-max-frequency = <100000000>; */
> +               partitions {
> +                       compatible = "fixed-partitions";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       uefi at 400000 {
> +                               reg = <0x400000 0x1C00000>;
> +                               label = "pnor-uefi";
> +                       };
> +               };
>         };
>  };
>
> --
> 2.28.0
>

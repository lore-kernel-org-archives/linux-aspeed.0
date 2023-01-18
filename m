From: Joel Stanley <joel@jms.id.au>
Date: Wed, 18 Jan 2023 03:20:09 +0000
Subject: [PATCH v2 1/1] ARM: dts: aspeed-g6: add aliases for mdio nodes
In-Reply-To: <20221025055046.1704920-1-potin.lai.pt@gmail.com>
References: <20221025055046.1704920-1-potin.lai.pt@gmail.com>
Message-ID: <CACPK8XcgzVPkmKLim7FTbsAn7W4h+d_DMnrpwHHRdWau3qcrYg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 25 Oct 2022 at 05:52, Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Add aliases for mdio nodes so that we can use name to lookup the
> bus address of Aspeed SOC.
>
> For example:
> root at bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio0
> /ahb/mdio at 1e650000
> root at bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio1
> /ahb/mdio at 1e650008
> root at bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio2
> /ahb/mdio at 1e650010
> root at bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio3
> /ahb/mdio at 1e650018
>
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

Thanks, that's better I think.

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
> LINK: [v1] https://lore.kernel.org/all/20221025024145.1561047-1-potin.lai.pt at gmail.com/
>
> change v1 --> v2:
> * move mdio aliases to aspeed-g6.dtsi
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 0cc92874caa8..6f159ef1efbc 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -36,6 +36,10 @@ aliases {
>                 serial4 = &uart5;
>                 serial5 = &vuart1;
>                 serial6 = &vuart2;
> +               mdio0 = &mdio0;
> +               mdio1 = &mdio1;
> +               mdio2 = &mdio2;
> +               mdio3 = &mdio3;
>         };
>
>
> --
> 2.31.1
>

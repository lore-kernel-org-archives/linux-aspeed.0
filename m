From: Joel Stanley <joel@jms.id.au>
Date: Tue, 25 Oct 2022 03:05:37 +0000
Subject: [PATCH 1/1] ARM: dts: aspeed: bletchley: add aliases for mdio0
 and mdio3
In-Reply-To: <20221025024145.1561047-1-potin.lai.pt@gmail.com>
References: <20221025024145.1561047-1-potin.lai.pt@gmail.com>
Message-ID: <CACPK8XdpeKVaxFki3GRyo30bWYNF6Q5wL706j5deaqi8P=ssdA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 25 Oct 2022 at 02:43, Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Add aliases for mdio0 and mdio3 so that we can use name to lookup the
> address of Aspeed SOC.
>
> For example:
> root at bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio0
> /ahb/mdio at 1e650000
> root at bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio3
> /ahb/mdio at 1e650018
>
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index c02c15f15465..2825d5f3f78b 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -15,6 +15,8 @@ / {
>
>         aliases {
>                 serial4 = &uart5;
> +               mdio0 = &mdio0;
> +               mdio3 = &mdio3;

Should this go into the dtsi instead?

>         };
>
>         chosen {
> --
> 2.31.1
>

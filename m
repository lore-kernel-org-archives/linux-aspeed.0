From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 3 Dec 2019 08:43:52 -0600
Subject: [PATCH 05/14] ARM: dts: aspeed-g5: Fix aspeed,
 external-nodes description
In-Reply-To: <141f068d10b94413a6d0ca73fe07f8e961380e7b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
 <141f068d10b94413a6d0ca73fe07f8e961380e7b.1575369656.git-series.andrew@aj.id.au>
Message-ID: <CAL_JsqJ8p-zs2F-mXkO_egoBtZ8WymM4O-2AaDJMZYeCFS3sLg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 3, 2019 at 6:03 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The existing approach lead to an error from the dtbs_check:
>
>     pinctrl: aspeed,external-nodes: [[8, 9]] is too short

This one where we have list of phandles is fixed in dtc. I need to
update the kernel's copy.

> Cc: Adriana Kobylak <anoo@us.ibm.com>
> Cc: Brian Yang <yang.brianc.w@inventec.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: John Wang <wangzqbj@inspur.com>
> Cc: Ken Chen <chen.kenyy@inventec.com>
> Cc: Tao Ren <taoren@fb.com>
> Cc: Xo Wang <xow@google.com>
> Cc: Yuan Yao <yao.yuan@linaro.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts     |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts         |  9 +++++++--
>  arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts           |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts             |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts             |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts               |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts         |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts               |  2 +--
>  arch/arm/boot/dts/aspeed-g5.dtsi                         |  3 +--
>  10 files changed, 8 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> index c2ece0b91885..de9612e49c69 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> @@ -211,10 +211,6 @@
>         status = "okay";
>  };
>
> -&pinctrl {
> -       aspeed,external-nodes = <&gfx &lhc>;
> -};
> -
>  &gpio {
>         pin_gpio_c7 {
>                 gpio-hog;
> diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> index 2c29ac037d32..022d0744d786 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> @@ -200,10 +200,6 @@
>         status = "okay";
>  };
>
> -&pinctrl {
> -       aspeed,external-nodes = <&gfx &lhc>;
> -};
> -
>  &gpio {
>         pin_gpio_c7 {
>                 gpio-hog;
> diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> index c17bb7fce7ff..d69da58476fe 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> @@ -782,8 +782,13 @@
>         memory-region = <&gfx_memory>;
>  };
>
> -&pinctrl {
> -       aspeed,external-nodes = <&gfx &lhc>;
> +&gpio {
> +       pin_gpio_b7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(B,7) GPIO_ACTIVE_LOW>;
> +               output-high;
> +               line-name = "BMC_INIT_OK";
> +       };

Seems like an unrelated change?

Rob

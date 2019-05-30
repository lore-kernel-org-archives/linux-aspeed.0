From: Joel Stanley <joel@jms.id.au>
Date: Thu, 30 May 2019 00:34:04 +0000
Subject: [PATCH] ARM: dts: aspeed: g4: add video engine support
In-Reply-To: <20190527112753.1681-1-a.filippov@yadro.com>
References: <20190527112753.1681-1-a.filippov@yadro.com>
Message-ID: <CACPK8XeXh8uiQ6f5LWJRBJ=VwMAvdPHOo34uHhWZyMFBG2HVqw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Alexander,

On Mon, 27 May 2019 at 11:28, Alexander Filippov <a.filippov@yadro.com> wrote:
>
> Add a node to describe the video engine and VGA scratch registers on
> AST2400.

The scratch registers are unrelated to the video engine. As Andrew
pointed out, the bindings are not upstream either.

Can you re-spin this patch wit just the video engine changes?

We also need a platform to enable and test this on. Can you submit the
device tree for your system?

>
> These changes were copied from aspeed-g5.dtsi
>
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 62 ++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 6011692df15a..adc1804918df 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -168,6 +168,10 @@
>                                         compatible = "aspeed,g4-pinctrl";
>                                 };
>
> +                               vga_scratch: scratch {
> +                                       compatible = "aspeed,bmc-misc";
> +                               };
> +
>                                 p2a: p2a-control {
>                                         compatible = "aspeed,ast2400-p2a-ctrl";
>                                         status = "disabled";
> @@ -195,6 +199,16 @@
>                                 reg = <0x1e720000 0x8000>;      // 32K
>                         };
>
> +                       video: video at 1e700000 {
> +                               compatible = "aspeed,ast2400-video-engine";
> +                               reg = <0x1e700000 0x1000>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
> +                                        <&syscon ASPEED_CLK_GATE_ECLK>;
> +                               clock-names = "vclk", "eclk";
> +                               interrupts = <7>;
> +                               status = "disabled";
> +                       };
> +
>                         gpio: gpio at 1e780000 {
>                                 #gpio-cells = <2>;
>                                 gpio-controller;
> @@ -1408,6 +1422,54 @@
>         };
>  };
>
> +&vga_scratch {
> +       dac_mux {
> +               offset = <0x2c>;
> +               bit-mask = <0x3>;
> +               bit-shift = <16>;
> +       };
> +       vga0 {
> +               offset = <0x50>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga1 {
> +               offset = <0x54>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga2 {
> +               offset = <0x58>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga3 {
> +               offset = <0x5c>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga4 {
> +               offset = <0x60>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga5 {
> +               offset = <0x64>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga6 {
> +               offset = <0x68>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga7 {
> +               offset = <0x6c>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +};
> +
>  &sio_regs {
>         sio_2b {
>                 offset = <0xf0>;
> --
> 2.20.1
>

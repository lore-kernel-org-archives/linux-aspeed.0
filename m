From: Joel Stanley <joel@jms.id.au>
Date: Mon, 12 Oct 2020 04:30:00 +0000
Subject: [PATCH 1/3] Arm: dts: aspeed-g6: Fix the register range of gpio
In-Reply-To: <20201012033150.21056-2-billy_tsai@aspeedtech.com>
References: <20201012033150.21056-1-billy_tsai@aspeedtech.com>
 <20201012033150.21056-2-billy_tsai@aspeedtech.com>
Message-ID: <CACPK8XcQ+uodvYCyL7_RO9W2QF+AA2LidHhXi2tR3_uriQFccQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2020 at 03:32, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> This patch is used to fix the memory range of gpio0
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 97ca743363d7..ad19dce038ea 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -357,7 +357,7 @@
>                                 #gpio-cells = <2>;
>                                 gpio-controller;
>                                 compatible = "aspeed,ast2600-gpio";
> -                               reg = <0x1e780000 0x800>;
> +                               reg = <0x1e780000 0x400>;
>                                 interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>                                 gpio-ranges = <&pinctrl 0 0 208>;
>                                 ngpios = <208>;
> --
> 2.17.1
>

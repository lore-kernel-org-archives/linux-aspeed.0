From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Dec 2020 07:02:38 +0000
Subject: [PATCH v2 2/3] ARM: dts: aspeed: Add AST2600 edac into common
 devicetree
In-Reply-To: <20201202063612.21241-2-troy_lee@aspeedtech.com>
References: <20201202063612.21241-1-troy_lee@aspeedtech.com>
 <20201202063612.21241-2-troy_lee@aspeedtech.com>
Message-ID: <CACPK8XeMdz70aH59zR1GjD6+r+68Y46qhreTw0AG7bzctCtxCg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2 Dec 2020 at 06:37, Troy Lee <troy_lee@aspeedtech.com> wrote:
>
> Adding Aspeed AST2600 edac node into common devicetree.
>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 97ca743363d7..fb144515f397 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -69,6 +69,12 @@
>                 always-on;
>         };
>
> +       edac: sdram at 1e6e0000 {
> +               compatible = "aspeed,ast2600-sdram-edac", "syscon";
> +               reg = <0x1e6e0000 0x174>;
> +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
>         ahb {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
> --
> 2.17.1
>

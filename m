From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Mar 2022 22:45:31 +0000
Subject: [PATCH v2 10/10] ARM: dts: aspeed: Enable Dual SPI RX transfers
In-Reply-To: <20220302173114.927476-11-clg@kaod.org>
References: <20220302173114.927476-1-clg@kaod.org>
 <20220302173114.927476-11-clg@kaod.org>
Message-ID: <CACPK8XeDBCMCEO4=w7qUQxsYiFUDKPAuBhXW5Sr6=UHM_GRsWA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2 Mar 2022 at 17:31, C?dric Le Goater <clg@kaod.org> wrote:
>
> All these controllers support at least Dual SPI. Update the DTs.
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Thanks. I'll apply this to the aspeed tree now.

Did you also have a patch to add a second flash chip to the AST2400 FMC?

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 9ae67e83cf60..31e6569db97e 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -64,27 +64,32 @@ fmc: spi at 1e620000 {
>                         flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
> +                               spi-rx-bus-width = <2>;
>                                 spi-max-frequency = <50000000>;
>                                 status = "disabled";
>                         };
>                         flash at 1 {
>                                 reg = < 1 >;
>                                 compatible = "jedec,spi-nor";
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 2 {
>                                 reg = < 2 >;
>                                 compatible = "jedec,spi-nor";
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 3 {
>                                 reg = < 3 >;
>                                 compatible = "jedec,spi-nor";
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 4 {
>                                 reg = < 4 >;
>                                 compatible = "jedec,spi-nor";
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> @@ -100,6 +105,7 @@ flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index c3e0a8e13c8a..29bf017899b6 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -66,18 +66,21 @@ flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 1 {
>                                 reg = < 1 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 2 {
>                                 reg = < 2 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> @@ -93,12 +96,14 @@ flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 1 {
>                                 reg = < 1 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> @@ -114,12 +119,14 @@ flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 1 {
>                                 reg = < 1 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 1ad05dde19d2..ce93c56a21a7 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -106,18 +106,21 @@ flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 1 {
>                                 reg = < 1 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 2 {
>                                 reg = < 2 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> @@ -133,12 +136,14 @@ flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 1 {
>                                 reg = < 1 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> @@ -154,18 +159,21 @@ flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 1 {
>                                 reg = < 1 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                         flash at 2 {
>                                 reg = < 2 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> --
> 2.34.1
>

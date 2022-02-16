From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Feb 2022 07:21:29 +0000
Subject: [PATCH 09/10] ARM: dts: aspeed: Enable Dual SPI RX transfers
In-Reply-To: <20220214094231.3753686-10-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-10-clg@kaod.org>
Message-ID: <CACPK8Xd5peBdJ2MYH6OcT+vWyjdmKaOpNFw=eHKp6=RPjc6X=g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 14 Feb 2022 at 09:43, C?dric Le Goater <clg@kaod.org> wrote:
>
> All these controllers support at least Dual SPI. Update the DTs.
>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index f14dace34c5a..da211fbd8658 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -65,27 +65,32 @@ fmc: spi at 1e620000 {
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
> @@ -102,6 +107,7 @@ flash at 0 {
>                                 reg = < 0 >;
>                                 compatible = "jedec,spi-nor";
>                                 spi-max-frequency = <50000000>;
> +                               spi-rx-bus-width = <2>;
>                                 status = "disabled";
>                         };
>                 };
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 7495f93c5069..804b66d32127 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -67,18 +67,21 @@ flash at 0 {
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
> @@ -95,12 +98,14 @@ flash at 0 {
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
> @@ -117,12 +122,14 @@ flash at 0 {
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
> index c32e87fad4dc..542714c61a85 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -107,18 +107,21 @@ flash at 0 {
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
> @@ -135,12 +138,14 @@ flash at 0 {
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
> @@ -157,18 +162,21 @@ flash at 0 {
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

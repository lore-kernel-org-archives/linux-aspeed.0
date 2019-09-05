From: Cédric Le Goater <clg@kaod.org>
Date: Thu, 5 Sep 2019 08:43:43 +0200
Subject: [PATCH] ARM: dts: aspeed-g4: Add all flash chips
In-Reply-To: <20190905000221.31445-1-joel@jms.id.au>
References: <20190905000221.31445-1-joel@jms.id.au>
Message-ID: <3b7605e2-533e-2123-b866-4ef5c601dc2a@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/09/2019 02:02, Joel Stanley wrote:
> The FMC supports five chip selects, so describe the five possible flash
> chips.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C?dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index e465cda40fe7..dffb595d30e4 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -67,6 +67,26 @@
>  				compatible = "jedec,spi-nor";
>  				status = "disabled";
>  			};
> +			flash at 1 {
> +				reg = < 1 >;
> +				compatible = "jedec,spi-nor";
> +				status = "disabled";
> +			};
> +			flash at 2 {
> +				reg = < 2 >;
> +				compatible = "jedec,spi-nor";
> +				status = "disabled";
> +			};
> +			flash at 3 {
> +				reg = < 3 >;
> +				compatible = "jedec,spi-nor";
> +				status = "disabled";
> +			};
> +			flash at 4 {
> +				reg = < 4 >;
> +				compatible = "jedec,spi-nor";
> +				status = "disabled";
> +			};
>  		};
>  
>  		spi: spi at 1e630000 {
> 


From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 04 Jun 2021 08:59:55 +0930
Subject: [PATCH v3 2/5] ARM: dts: aspeed-g6: Add SGPIO node.
In-Reply-To: <20210603101822.9645-3-steven_lee@aspeedtech.com>
References: <20210603101822.9645-1-steven_lee@aspeedtech.com>
 <20210603101822.9645-3-steven_lee@aspeedtech.com>
Message-ID: <fcd435d9-4432-414e-9881-6044757a6fac@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 3 Jun 2021, at 19:48, Steven Lee wrote:
> AST2600 supports 2 SGPIO master interfaces one with 128 pins another one
> with 80 pins.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index f96607b7b4e2..e56e92e206f1 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -377,6 +377,36 @@
>  				#interrupt-cells = <2>;
>  			};
>  
> +			sgpiom0: sgpiom at 1e780500 {
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				compatible = "aspeed,ast2600-sgpiom1";

See my comment on the compatible names on the binding document.

Andrew

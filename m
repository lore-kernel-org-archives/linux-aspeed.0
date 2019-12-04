From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Wed, 04 Dec 2019 16:29:49 -0600
Subject: [PATCH 08/14] ARM: dts: swift: Cleanup gpio-keys-polled properties
In-Reply-To: <78ea3e17108c7c8fded921f5673777fc415cd66e.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
 <78ea3e17108c7c8fded921f5673777fc415cd66e.1575369656.git-series.andrew@aj.id.au>
Message-ID: <450addb633e8572a019ccaec5fd48248@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2019-12-03 06:04, Andrew Jeffery wrote:
> dtbs_check gave the following warning:
> 
>     Warning (avoid_unnecessary_addr_size): /gpio-keys-polled:
> unnecessary #address-cells/#size-cells without "ranges" or child "reg"
> property
> 
> Cc: Adriana Kobylak <anoo@us.ibm.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Adriana Kobylak <anoo@us.ibm.com>
Tested-by: Adriana Kobylak <anoo@us.ibm.com>

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> index 0831bc1f5a4c..555d79405884 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> @@ -82,8 +82,6 @@
> 
>  	gpio-keys-polled {
>  		compatible = "gpio-keys-polled";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		poll-interval = <1000>;
> 
>  		scm0-presence {

From: Alexander A. Filippov <a.filippov@yadro.com>
Date: Fri, 26 Jul 2019 10:56:53 +0300
Subject: [PATCH 04/17] ARM: dts: vesnin: Add unit address for memory node
In-Reply-To: <20190726053959.2003-5-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
 <20190726053959.2003-5-andrew@aj.id.au>
Message-ID: <20190726075653.GA10397@bbwork.lan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 26, 2019 at 03:09:46PM +0930, Andrew Jeffery wrote:
> Fixes the following warnings:
> 
>     arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dt.yaml: /: memory: False schema does not allow {'reg': [[1073741824, 536870912]]}
>     arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dt.yaml: memory: 'device_type' is a required property
> 
> Cc: Alexander Filippov <a.filippov@yadro.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> index 0b9e29c3212e..81d9dcb752a0 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> @@ -14,7 +14,7 @@
>  		bootargs = "console=ttyS4,115200 earlyprintk";
>  	};
>  
> -	memory {
> +	memory at 40000000 {
>  		reg = <0x40000000 0x20000000>;
>  	};
>  
> -- 
> 2.20.1
> 

Tested-by: Alexander Filippov <a.filippov@yadro.com>

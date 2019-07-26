From: Adriana Kobylak <anoo@us.ibm.com>
Date: Fri, 26 Jul 2019 12:53:29 -0500
Subject: [PATCH 06/17] ARM: dts: swift: Cleanup gpio-keys-polled properties
In-Reply-To: <20190726053959.2003-7-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
 <20190726053959.2003-7-andrew@aj.id.au>
Message-ID: <OF8D1EDAE6.971111FC-ON86258443.0062157C-86258443.00624798@notes.na.collabserv.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Andrew Jeffery <andrew@aj.id.au> wrote on 07/26/2019 12:39:48 AM:

> From: Andrew Jeffery <andrew@aj.id.au>
> To: linux-aspeed at lists.ozlabs.org
> Cc: Andrew Jeffery <andrew@aj.id.au>, robh+dt at kernel.org, 
> mark.rutland at arm.com, joel at jms.id.au, devicetree at vger.kernel.org, 
> linux-arm-kernel at lists.infradead.org, linux-kernel at vger.kernel.org, 
> Adriana Kobylak <anoo@us.ibm.com>
> Date: 07/26/2019 12:40 AM
> Subject: [EXTERNAL] [PATCH 06/17] ARM: dts: swift: Cleanup gpio-
> keys-polled properties
> 
> dtbs_check gave the following warning:
> 
>     Warning (avoid_unnecessary_addr_size): /gpio-keys-polled: 
> unnecessary #address-cells/#size-cells without "ranges" or child 
> "reg" property
> 
> Cc: Adriana Kobylak <anoo@us.ibm.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Adriana Kobylak <anoo@us.ibm.com>
Tested-by: Adriana Kobylak <anoo@us.ibm.com>

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/
> boot/dts/aspeed-bmc-opp-swift.dts
> index 2077e8d0e096..9f934509ca1b 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> @@ -82,8 +82,6 @@
> 
>     gpio-keys-polled {
>        compatible = "gpio-keys-polled";
> -      #address-cells = <1>;
> -      #size-cells = <0>;
>        poll-interval = <1000>;
> 
>        scm0-presence {
> -- 
> 2.20.1
> 


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190726/a10d5722/attachment-0001.htm>

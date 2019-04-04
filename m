From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 03 Apr 2019 20:34:37 -0400
Subject: [PATCH v2] ARM: dts: Aspeed: Witherspoon: Update BMC partitioning
In-Reply-To: <599ff977-9e23-d1de-24c9-a5f0f1585495@kaod.org>
References: <962b866599ac4dfd866d7433b7ddb276@linux.vnet.ibm.com>
 <1554310751-52446-1-git-send-email-anoo@linux.ibm.com>
 <599ff977-9e23-d1de-24c9-a5f0f1585495@kaod.org>
Message-ID: <afa93732-2a36-498f-8bf3-285192626a44@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 4 Apr 2019, at 04:09, C?dric Le Goater wrote:
> On 4/3/19 6:59 PM, Adriana Kobylak wrote:
> > From: "Edward A. James" <eajames@us.ibm.com>
> > 
> > Add simplified partitions for BMC and alternate flash. Include these by
> > default in Witherspoon.
> 
> at last ! :
> 
> Reviewed-by: C?dric Le Goater <clg@kaod.org>

Piling on:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> 
> Thanks,
> 
> C.
> 
> > 
> > Signed-off-by: Edward A. James <eajames@us.ibm.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 37 ++++++++++++++++++++++--
> >  1 file changed, 35 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> > index 1cdc96d..82f63aa 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> > @@ -194,14 +194,47 @@
> >  		label = "bmc";
> >  		m25p,fast-read;
> >  		spi-max-frequency = <50000000>;
> > -#include "openbmc-flash-layout.dtsi"
> > +		partitions {
> > +			#address-cells = < 1 >;
> > +			#size-cells = < 1 >;
> > +			compatible = "fixed-partitions";
> > +			u-boot at 0 {
> > +				reg = < 0 0x60000 >;
> > +				label = "u-boot";
> > +			};
> > +			u-boot-env at 60000 {
> > +				reg = < 0x60000 0x20000 >;
> > +				label = "u-boot-env";
> > +			};
> > +			obmc-ubi at 80000 {
> > +				reg = < 0x80000 0x1F80000 >;
> > +				label = "obmc-ubi";
> > +			};
> > +		};
> >  	};
> >  
> >  	flash at 1 {
> >  		status = "okay";
> > -		label = "alt";
> > +		label = "alt-bmc";
> >  		m25p,fast-read;
> >  		spi-max-frequency = <50000000>;
> > +		partitions {
> > +			#address-cells = < 1 >;
> > +			#size-cells = < 1 >;
> > +			compatible = "fixed-partitions";
> > +			u-boot at 0 {
> > +				reg = < 0 0x60000 >;
> > +				label = "alt-u-boot";
> > +			};
> > +			u-boot-env at 60000 {
> > +				reg = < 0x60000 0x20000 >;
> > +				label = "alt-u-boot-env";
> > +			};
> > +			obmc-ubi at 80000 {
> > +				reg = < 0x80000 0x1F80000 >;
> > +				label = "alt-obmc-ubi";
> > +			};
> > +		};
> >  	};
> >  };
> >  
> > 
> 
>

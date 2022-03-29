From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 29 Mar 2022 11:19:30 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <YkG2RPrtPaBNXb7a@latitude>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <YkG2RPrtPaBNXb7a@latitude>
Message-ID: <YkLPIgwClJAUc1Uf@piout.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On 28/03/2022 15:21:08+0200, Jonathan Neusch?fer wrote:
> On Mon, Mar 28, 2022 at 02:09:14AM +0200, Ansuel Smith wrote:
> >  create mode 100644 arch/arm/boot/dts/freescale/Makefile
> 
> Freescale has been part of NXP for a while, so it might make sense to
> merge the freescale and nxp directories. I can't speak for
> NXP-the-company, so that's just my view as a bystander.
> 

Maybe we should wait for the market consolidation to end so we can put
all the files in a single subfolder?

this would save us from all the bikeshedding ;)

> >  create mode 100644 arch/arm/boot/dts/kirkwood/Makefile
> 
> The Kirkwood family should probably be sorted into Marvell.
> 
> >  create mode 100644 arch/arm/boot/dts/layerscape/Makefile
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a-moxa-uc-8410a.dts (100%)
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a-qds.dts (100%)
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a-tsn.dts (100%)
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a-twr.dts (100%)
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a.dtsi (100%)
> 
> The Layerscape family is part of Freescale/NXP.
> 
> >  create mode 120000 arch/arm/boot/dts/nxp/armv7-m.dtsi
> 
> armv7-m.dtsi is a bit confusing, because it contains a few devices at
> fixed addresses, so it looks vendor-specific at a first glance into the
> file. However, if it is actually as vendor-neutral as the name implies,
> I think it should live dts/ directly, rather than in vendor
> subdirectories.
> 
> >  rename arch/arm/boot/dts/{ => nxp}/lpc18xx.dtsi (100%)
> 
> Here we have the NXP LPCxxxx family, which is AFAIK unrelated to the
> i.MX family (and thus the bulk of the Freescale legacy).
> 
> >  create mode 100644 arch/arm/boot/dts/vybrid/Makefile
> 
> Vybrid is another chip family of NXP, with a good deal of Freescale
> legacy in it as evidenced by the "fsl," prefix in the devicetrees.
> 
> 
> 
> Thanks,
> Jonathan



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

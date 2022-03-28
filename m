From: Ansuel Smith <ansuelsmth@gmail.com>
Date: Mon, 28 Mar 2022 15:27:13 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <YkG2RPrtPaBNXb7a@latitude>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <YkG2RPrtPaBNXb7a@latitude>
Message-ID: <YkG3sQ3MDhVoW8l4@Ansuel-xps.localdomain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 28, 2022 at 03:21:08PM +0200, Jonathan Neusch?fer wrote:
> On Mon, Mar 28, 2022 at 02:09:14AM +0200, Ansuel Smith wrote:
> > Hi,
> > as the title say, the intention of this ""series"" is to finally categorize
> > the ARM dts directory in subdirectory for each oem.
> [...]
> > [1] https://gist.github.com/Ansuel/47c49925ee7ef4b1dd035afc74679ab5
> > [2] https://gist.github.com/Ansuel/19f61f1e583c49407ce35c10e770fbe0
> 
> Nice idea, thank you!
> 
> A few notes on categorization below.
> 
> 
> >  create mode 100644 arch/arm/boot/dts/broadcom/Makefile
> >  rename arch/arm/boot/dts/{ => broadcom}/bcm-cygnus-clock.dtsi (100%)
> 
> Or maybe bcm instead of broadcom. Not sure which is preferred by
> Broadcom people.
> 

In arm64 they used broadcom so i assume the full name looks correct.

> >  create mode 100644 arch/arm/boot/dts/dove/Makefile
> >  rename arch/arm/boot/dts/{ => dove}/dove-cm-a510.dtsi (100%)
> 
> Arguably part of Marvell.
> 
> >  create mode 100644 arch/arm/boot/dts/edac/Makefile
> >  rename arch/arm/boot/dts/{ => edac}/ecx-2000.dts (100%)
> >  rename arch/arm/boot/dts/{ => edac}/ecx-common.dtsi (100%)
> >  rename arch/arm/boot/dts/{ => edac}/highbank.dts (100%)
> 
> Why edac?
> The most obvious name I can see here is calxeda.
> 
> >  create mode 100644 arch/arm/boot/dts/freescale/Makefile
> 
> Freescale has been part of NXP for a while, so it might make sense to
> merge the freescale and nxp directories. I can't speak for
> NXP-the-company, so that's just my view as a bystander.
> 
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

Considering it's really just 3 binding IMHO it should be just dropped
and merged in other dtsi... But lets not extend this too much.
This is really just a simplic link and armv7-m.dtsi is placed in dts/
I create links in each oem that includes it to skip any changes to the
dts.

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

Thx for the hint hope to get more comments about the dubious
categorization about nxp and freescale.

-- 
	Ansuel

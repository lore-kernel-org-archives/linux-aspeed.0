From: Alexander Stein <alexander.stein@ew.tq-group.com>
Date: Mon, 28 Mar 2022 16:00:02 +0200
Subject: (EXT) Re: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <YkG2RPrtPaBNXb7a@latitude>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <YkG2RPrtPaBNXb7a@latitude>
Message-ID: <2100132.irdbgypaU6@steina-w>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am Montag, 28. M?rz 2022, 15:21:08 CEST schrieb Jonathan Neusch?fer:
> * PGP Signed by an unknown key
> 
> On Mon, Mar 28, 2022 at 02:09:14AM +0200, Ansuel Smith wrote:
> > Hi,
> > as the title say, the intention of this ""series"" is to finally
> > categorize
> > the ARM dts directory in subdirectory for each oem.
> 
> [...]
> 
> > [1] https://gist.github.com/Ansuel/47c49925ee7ef4b1dd035afc74679ab5
> > [2] https://gist.github.com/Ansuel/19f61f1e583c49407ce35c10e770fbe0
> 
> Nice idea, thank you!
> 
> A few notes on categorization below.
> [...]
> >  create mode 100644 arch/arm/boot/dts/freescale/Makefile
> 
> Freescale has been part of NXP for a while, so it might make sense to
> merge the freescale and nxp directories. I can't speak for
> NXP-the-company, so that's just my view as a bystander.

Please don't mix the names for arm and arm64. It's very confusing if the 
vendor directory is named differently for each architecture.

>[...]
> >  create mode 120000 arch/arm/boot/dts/nxp/armv7-m.dtsi
> 
> armv7-m.dtsi is a bit confusing, because it contains a few devices at
> fixed addresses, so it looks vendor-specific at a first glance into the
> file. However, if it is actually as vendor-neutral as the name implies,
> I think it should live dts/ directly, rather than in vendor
> subdirectories.

This seems to be some generic devices common for all ARMv7M CPUs used in 
Cortex-M CPUs. It's also used by some stm32 .dtsi.

Best regards,
Alexander




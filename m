From: Corey Minyard <minyard@acm.org>
Date: Thu, 20 May 2021 08:33:33 -0500
Subject: [PATCH v3 00/16] ipmi: Allow raw access to KCS devices
In-Reply-To: <5b549fee-63b1-4c05-a1d6-f6a13e235e1e@www.fastmail.com>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <5b549fee-63b1-4c05-a1d6-f6a13e235e1e@www.fastmail.com>
Message-ID: <20210520133333.GH2921206@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 20, 2021 at 04:21:31PM +0930, Andrew Jeffery wrote:
> Hi Corey,
> 
> On Mon, 10 May 2021, at 15:11, Andrew Jeffery wrote:
> > Hello,
> > 
> > This is the 3rd spin of the series refactoring the keyboard-controller-style
> > device drivers in the IPMI subsystem.
> > 
> > v2 can be found (in two parts because yay patch workflow mistakes) at:
> > 
> > Cover letter:
> > https://lore.kernel.org/linux-arm-kernel/20210319061952.145040-1-andrew at aj.id.au/
> > 
> > Patches:
> > https://lore.kernel.org/linux-arm-kernel/20210319062752.145730-1-andrew at aj.id.au/
> > 
> > Several significant changes in v3:
> > 
> > 1. The series is rebased onto v5.13-rc1
> > 
> > 2. v5.13-rc1 includes Chiawei's patches reworking the LPC devicetree bindings,
> >    so they're no-longer required in the series.
> > 
> > 3. After some discussion with Arnd[1] and investigating the serio subsystem,
> >    I've replaced the "raw" KCS driver (patch 16/21 in v2) with a serio adaptor
> >    (patch 11/16 in this series). The adaptor allows us to take advantage of the
> >    existing chardevs provided by serio.
> > 
> > [1] 
> > https://lore.kernel.org/linux-arm-kernel/37e75b07-a5c6-422f-84b3-54f2bea0b917 at www.fastmail.com/
> > 
> > Finally, I've also addressed Zev Weiss' review comments where I thought it was
> > required. These comments covered a lot of minor issues across (almost) all the
> > patches, so it's best to review from a clean slate rather than attempt to review
> > the differences between spins.
> 
> I backported this series for OpenBMC and posting those patches provoked
> some feedback:
> 
> * A bug identified in patch 9/18 for the Nuvoton driver where we enable
>   the OBE interrupt:
> 
> https://lore.kernel.org/openbmc/HK2PR03MB4371F006185ADBBF812A5892AE509 at HK2PR03MB4371.apcprd03.prod.outlook.com/
> 
> * A discussion on patch 10/18 about lifting the single-open constraint
> 
> https://lore.kernel.org/openbmc/CAPnigKku-EjOnV9gsmnXzH=XZxSU78iLeccNbsK8k2_4b4UwSg at mail.gmail.com/
> 
> I need to do a v4 to fix the bug in the Nuvoton driver. Did you have any
> feedback for the remaining patches or thoughts on the discussions linked
> above?  I'd like to incorporate whatever I can into the series before
> respinning.

This will take a little while to review, but I'll try to get to it
today.

Thanks,

-corey

> 
> Cheers,
> 
> Andrew

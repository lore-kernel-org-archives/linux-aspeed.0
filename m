From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 07 Jun 2021 10:29:36 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v5_0/4]_mmc:_sdhci-of-aspeed:_Support_toggling_SD_b?=
 =?UTF-8?Q?us_signal?=
In-Reply-To: <e95c5263-d50f-4316-bb93-e14449559b1b@www.fastmail.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
 <CACPK8XcfvUQD5xwb=2Va5Sr+bmaWfJMZkh61HK1=J1qLYc84zQ@mail.gmail.com>
 <20210525094815.GA8757@aspeedtech.com>
 <CACPK8XfdYAcx=RX07hf1ar8A7th8G8390exvKbgh92X=ov8u2A@mail.gmail.com>
 <e95c5263-d50f-4316-bb93-e14449559b1b@www.fastmail.com>
Message-ID: <987dca0b-1164-42d0-91d9-39e45896a47f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 26 May 2021, at 08:29, Andrew Jeffery wrote:
> 
> 
> On Tue, 25 May 2021, at 22:26, Joel Stanley wrote:
> > On Tue, 25 May 2021 at 09:48, Steven Lee <steven_lee@aspeedtech.com> wrote:
> > >
> > > The 05/25/2021 15:55, Joel Stanley wrote:
> > > > When I was testing on my A2 EVB I saw this:
> > > >
> > > > [    1.436219] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > > > phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
> > > > clamping to tap 15
> > > > [    1.450913] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > > > phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
> > > > clamping to tap 15
> > > >
> > > > Do you know what is happening there?
> > > >
> > >
> > > Per MMC spec, eMMC bus speed is set as legacy mode(0~26MHz) at startup of
> > > eMMC initializtion flow. Clock phase calculation is triggered in set_clock()
> > > and it calculates taps based on phase_deg(<9>, <225>) in the dts file and the
> > > current speed(1562500Hz), which causes the warning message you mentioned.
> > > As the phase_deg in the dts file should be calculated with 100MHz.
> > >
> > > https://lkml.org/lkml/2021/5/24/95
> > >
> > > But after some initialization flow, eMMC bus speed will be set to
> > > correct speed(100MHz).
> > > Clock phase calculation will be triggered again to get correct taps.
> > 
> > Thanks for the explanation. I added another debug print and I can see
> > it doing what you describe:
> > 
> > [    1.465904] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
> > clamping to tap 15
> > [    1.480598] sdhci-aspeed 1e750100.sdhci: rate 1562500 phase 9 tap 15
> > [    1.490316] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
> > clamping to tap 15
> > [    1.505077] sdhci-aspeed 1e750100.sdhci: rate 1562500 phase 45 tap 15
> > [    1.515059] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 9 tap 3
> > [    1.524886] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 45 tap 15
> > [    1.534904] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 9 tap 3
> > [    1.544713] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 45 tap 15
> > 
> > We should change the "out of range" message to be dev_dbg, as it is
> > expected on a normal boot.
> 
> I would think the issue is rather that we shouldn't be applying a phase 
> correction for a bus speed that isn't what the correction was specified 
> for.
> 
> Let me look at this a bit further.

Okay, looks like the issue is that setting the card timing and the bus frequency are not atomic in the sense that the bus clock enable is toggled in between the two, and the MMC core calls through the driver's set_clock() callback when toggling the bus clock state. This means the driver observes a transient state where the card timing is not aligned with the bus frequency, and so we have garbage inputs to the phase correction calculation.

Ideally there'd be a better solution than just switching to dev_dbg(), but I'm not sure what it would look like.

Andrew

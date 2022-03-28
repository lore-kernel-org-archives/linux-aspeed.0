From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Date: Mon, 28 Mar 2022 15:35:18 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <YkG3sQ3MDhVoW8l4@Ansuel-xps.localdomain>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <YkG2RPrtPaBNXb7a@latitude>
 <YkG3sQ3MDhVoW8l4@Ansuel-xps.localdomain>
Message-ID: <YkG5lsXhNk+9ulnl@latitude>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 28, 2022 at 03:27:13PM +0200, Ansuel Smith wrote:
> On Mon, Mar 28, 2022 at 03:21:08PM +0200, Jonathan Neusch?fer wrote:
> > On Mon, Mar 28, 2022 at 02:09:14AM +0200, Ansuel Smith wrote:
> > > Hi,
> > > as the title say, the intention of this ""series"" is to finally categorize
> > > the ARM dts directory in subdirectory for each oem.
> > [...]
> > > [1] https://gist.github.com/Ansuel/47c49925ee7ef4b1dd035afc74679ab5
> > > [2] https://gist.github.com/Ansuel/19f61f1e583c49407ce35c10e770fbe0
> > 
> > Nice idea, thank you!
> > 
> > A few notes on categorization below.
> > 
> > 
> > >  create mode 100644 arch/arm/boot/dts/broadcom/Makefile
> > >  rename arch/arm/boot/dts/{ => broadcom}/bcm-cygnus-clock.dtsi (100%)
> > 
> > Or maybe bcm instead of broadcom. Not sure which is preferred by
> > Broadcom people.
> > 
> 
> In arm64 they used broadcom so i assume the full name looks correct.

Alright.


[...]
> > >  create mode 120000 arch/arm/boot/dts/nxp/armv7-m.dtsi
> > 
> > armv7-m.dtsi is a bit confusing, because it contains a few devices at
> > fixed addresses, so it looks vendor-specific at a first glance into the
> > file. However, if it is actually as vendor-neutral as the name implies,
> > I think it should live dts/ directly, rather than in vendor
> > subdirectories.
> >
> 
> Considering it's really just 3 binding IMHO it should be just dropped
> and merged in other dtsi... But lets not extend this too much.
> This is really just a simplic link and armv7-m.dtsi is placed in dts/
> I create links in each oem that includes it to skip any changes to the
> dts.

Ah, I missed the link bit (hidden in the file permissions) :)
I agree, this is something that can be cleaned up later.


Jonathan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220328/f9c02cc7/attachment.sig>

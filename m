From: Pratyush Yadav <p.yadav@ti.com>
Date: Wed, 5 Jan 2022 12:02:46 +0530
Subject: [PATCH] mtd: aspeed-smc: improve probe resilience
In-Reply-To: <YdSP6tKyQ2ZRUC+2@heinlein>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com>
 <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com>
 <20220103171721.46c8e697@xps13> <YdSP6tKyQ2ZRUC+2@heinlein>
Message-ID: <20220105063244.lno3xur64uepa7i5@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/01/22 12:20PM, Patrick Williams wrote:
> Hi Miquel,
> 
> On Mon, Jan 03, 2022 at 05:17:21PM +0100, Miquel Raynal wrote:
> 
> > > I am fine with taking in bug fixes but no longer want to take in any new 
> > > features. My main intention was to nudge you to convert it to SPI MEM 
> > > regardless of whether this is a bug fix or a new feature, because 
> > > eventually we want to get rid of drivers/mtd/spi-nor/controllers/ and 
> > > the API that comes along with it.
> > 
> > I totally agree with Pratyush here, we no longer want to support the
> > spi-nor controller API so if, as you say, there are boards failing
> > in the field, it means there are still users and these users must be
> > warned that at some point we might discontinue the support of these
> > drivers if it becomes too painful.
> >
> 
> Your response here makes it seem like you don't realize the scope of this
> driver.  There are probably, by my estimates, on the order of 10s of millions of
> deployed systems using this driver in the world.  The vast majority of servers
> in the world use an AST2400, AST2500, or AST2600 chip, which needs this driver
> in order access its own flash storage device.  Both OpenBMC and most of the
> proprietary alternatives use this driver.

Then we should easily be able to find people willing to spend a couple 
days on updating the driver :-)

> 
> The company I work for has a LOT of systems using this code.  After I made this
> fix, for a new design being developed, it was pointed out to me that our ODM ran
> into this problem a few years ago and we've been really bad about upstreaming
> those fixes.  For this new system I'm trying to keep us on top of all
> upstreaming efforts.

If a company wants to use an upstream kernel for their systems I think 
they should invest into maintaining the drivers they are using.

> 
> To me the inability to access your own storage, resulting in a kernel panic, is
> a pretty serious issue.  Bug or feature I guess is always in the eye of the

One option you always have is to disable the bad flash in your device 
tree. I don't see why you would want to keep a flash that does not work 
enabled anyway.

> beholder though.  I think this is pretty valuable to get in, from an impact
> standpoint, and pretty minimal in terms of maintenance efforts on the
> maintainers part.

Yes, I agree that your patch itself has fairly low maintenance burden. I 
would not be too opposed to taking it in. But for the driver as a whole, 
that is indeed a maintenance burden since we have to carry code in SPI 
NOR to support it which makes adding new features a bit tricky.

We had a discussion along these lines for old unmaintained flashes in 
SPI NOR. The idea then was to warn the people who touched code related 
to those flashes that they can either update it or we will drop the 
flashes after X releases. They would still work on older kernels of 
course, but if there are any upstream users they would have to update 
the code or live without the flashes.

I would like to use the same approach for the controllers API as well. 
We can't keep carrying around legacy code forever just because a 
device/driver has no active developers. If people want to use some 
driver in the upstream kernel, they should help maintain it.

> 
> I had an offline discussion with someone who knew more history on this driver.
> My understanding is that the linux-aspeed team is aware of this being deprecated
> but that there was some missing support for interface training that nobody has
> gotten around to write?  If that is the case this really isn't even a "simple"
> port to a new API at this point.

Unless the controller needs some unique feature (I don't think it does 
on a quick glance), the conversion should not be too difficult. For any 
experienced developer, even if they are unfamiliar with the SPI MEM API, 
I don't think it should take more than 2-3 days to do the conversion. 
The code to program the registers would stay the same, all that needs to 
change is the API through which it is accessed.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.

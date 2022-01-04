From: Patrick Williams <patrick@stwcx.xyz>
Date: Tue, 4 Jan 2022 12:20:26 -0600
Subject: [PATCH] mtd: aspeed-smc: improve probe resilience
In-Reply-To: <20220103171721.46c8e697@xps13>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com>
 <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com>
 <20220103171721.46c8e697@xps13>
Message-ID: <YdSP6tKyQ2ZRUC+2@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Miquel,

On Mon, Jan 03, 2022 at 05:17:21PM +0100, Miquel Raynal wrote:

> > I am fine with taking in bug fixes but no longer want to take in any new 
> > features. My main intention was to nudge you to convert it to SPI MEM 
> > regardless of whether this is a bug fix or a new feature, because 
> > eventually we want to get rid of drivers/mtd/spi-nor/controllers/ and 
> > the API that comes along with it.
> 
> I totally agree with Pratyush here, we no longer want to support the
> spi-nor controller API so if, as you say, there are boards failing
> in the field, it means there are still users and these users must be
> warned that at some point we might discontinue the support of these
> drivers if it becomes too painful.
>

Your response here makes it seem like you don't realize the scope of this
driver.  There are probably, by my estimates, on the order of 10s of millions of
deployed systems using this driver in the world.  The vast majority of servers
in the world use an AST2400, AST2500, or AST2600 chip, which needs this driver
in order access its own flash storage device.  Both OpenBMC and most of the
proprietary alternatives use this driver.

The company I work for has a LOT of systems using this code.  After I made this
fix, for a new design being developed, it was pointed out to me that our ODM ran
into this problem a few years ago and we've been really bad about upstreaming
those fixes.  For this new system I'm trying to keep us on top of all
upstreaming efforts.

To me the inability to access your own storage, resulting in a kernel panic, is
a pretty serious issue.  Bug or feature I guess is always in the eye of the
beholder though.  I think this is pretty valuable to get in, from an impact
standpoint, and pretty minimal in terms of maintenance efforts on the
maintainers part.

I had an offline discussion with someone who knew more history on this driver.
My understanding is that the linux-aspeed team is aware of this being deprecated
but that there was some missing support for interface training that nobody has
gotten around to write?  If that is the case this really isn't even a "simple"
port to a new API at this point.

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220104/4be800be/attachment.sig>

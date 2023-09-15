From: Maciej W. Rozycki <macro@orcam.me.uk>
Date: Fri, 15 Sep 2023 18:23:44 +0100 (BST)
Subject: [PATCH tty v1 00/74] serial: wrappers for uart port lock
In-Reply-To: <87il8b1w3l.ffs@tglx>
References: <20230914183831.587273-1-john.ogness@linutronix.de> <alpine.DEB.2.21.2309141959100.57368@angie.orcam.me.uk> <87il8b1w3l.ffs@tglx>
Message-ID: <alpine.DEB.2.21.2309151739290.57368@angie.orcam.me.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 15 Sep 2023, Thomas Gleixner wrote:

> >> Patches 2-74 switch all uart port locking call sites to use the new
> >> wrappers. These patches were automatically generated using coccinelle.
> >
> >  Hmm, no need to do this for drivers/tty/serial/zs.c?
> 
> zs.c does not use port lock at all. It has like a couple of other
> drivers a local homebrewn spinlock.

 Ah, right, that's because there are registers shared between two ports 
within one SCC, so the spinlock has to be shared as well.

 This also indicates that dz.c is wrong and shouldn't be using a per-port 
spinlock as the DZ has a shared register set between all the four ports 
(it's a serial line multiplexer rather than a set discrete ports; up to 8 
lines are architecturally supported, though we don't have support in Linux 
for systems having those), e.g. there's only one 16-bit receiver buffer 
register for all the four ports, supplying the 8-bit character received 
along with the receive status and the number of the line this data arrived 
on, and similarly there's only one transmit data register, which supplies 
data to the next enabled line whose transmit buffer needs servicing, and 
the chip routes the data itself.  Therefore the driver ought to use a 
shared spinlock too.

 I guess it wasn't noticed so far because DZ devices aren't that common 
(and my usual test machine is currently broken too, pending an SRAM chip 
replacement, hopefully in the next few weeks) and then hardly ever more 
than one serial line has been used at a time with these devices.  It looks 
like the first issue for me to look into once the machine has been fixed.

 Maybe dz.c shouldn't be touched by this series then?  (Though obviously 
both drivers will have to be eventually adapted for the ultimate console 
rework.)

 Thanks for your input, as it turns out it has had an unexpected outcome.

  Maciej

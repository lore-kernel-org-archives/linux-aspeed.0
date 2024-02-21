From: Corey Minyard <minyard@acm.org>
Date: Wed, 21 Feb 2024 12:08:16 -0600
Subject: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
In-Reply-To: <527F52AB-0070-43EA-BE82-945280CA2AEE@gmail.com>
References: <20240220123615.963916-1-geissonator@gmail.com>
 <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>
 <ZdT+eThnYqb3iawF@mail.minyard.net>
 <9680ad7d7a48fc36a0572dc2286a1229a29341fe.camel@codeconstruct.com.au>
 <527F52AB-0070-43EA-BE82-945280CA2AEE@gmail.com>
Message-ID: <ZdY8EDfeePse3c1s@mail.minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 21, 2024 at 10:57:38AM -0600, Andrew Geissler wrote:
> 
> 
> > On Feb 20, 2024, at 4:36?PM, Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
> > 
> > On Tue, 2024-02-20 at 13:33 -0600, Corey Minyard wrote:
> >> On Tue, Feb 20, 2024 at 04:51:21PM +0100, Paul Menzel wrote:
> >>> Dear Andrew,
> >> 
> >> It's because increasing that number causes it to poll longer for the
> >> event, the host takes longer than 100us to generate the event, and if
> >> the event is missed the time when it is checked again is very long.
> >> 
> >> Polling for 100us is already pretty extreme. 200us is really too long.
> >> 
> >> The real problem is that there is no interrupt for this.  I'd also guess
> >> there is no interrupt on the host side, because that would solve this
> >> problem, too, as it would certainly get around to handling the interupt
> >> in 100us.  I'm assuming the host driver is not the Linux driver, as it
> >> should also handle this in a timely manner, even when polling.
> > 
> > I expect the issues Andrew G is observing are with the Power10 boot
> > firmware. The boot firmware only polls. The runtime firmware enables
> > interrupts.
> 
> Yep, this is with the low level host boot firmware.
> Also, further testing over night showed that 200us wasn?t enough for
> our larger Everest P10 machines, I needed to go to 300us. As we
> were struggling to allow 200us, I assume 300us is going to be a no-go.

It seems odd to me that firmware polling would be an issue.  Usually,
with firmware, you have it just spinning waiting for something.  At
least in the firmware I worked with.

I'm not familiar with this firmware, though, maybe it has timers and
such and parallel execution.  Can this be fixed on the firmware side?

> 
> >> 
> > 
> >> 
> >> The right way to fix this is probably to do the same thing the host side
> >> Linux driver does.  It has a kernel thread that is kicked off to do
> >> this.  Unfortunately, that's more complicated to implement, but it
> >> avoids polling in this location (which causes latency issues on the BMC
> >> side) and lets you poll longer without causing issues.
> > 
> > In Andrew G's case he's talking MCTP over KCS using a vendor-defined
> > transport binding (that also leverages LPC FWH cycles for bulk data
> > transfers)[1]. I think it could have taken more inspiration from the
> > IPMI KCS protocol: It might be worth an experiment to write the dummy
> > command value to IDR from the host side after each ODR read to signal
> > the host's clearing of OBF (no interrupt for the BMC) with an IBF
> > (which does interrupt the BMC). And doing the obverse for the BMC. Some
> > brief thought suggests that if the dummy value is read there's no need
> > to send a dummy value in reply (as it's an indicator to read the status
> > register). With that the need for the spin here (or on the host side)
> > is reduced at the cost of some constant protocol overhead.
> > 
> 
> Thanks for the quick reviews and ideas.
> I?ll see if I can find someone on the team to help out with Andrew J?s
> thoughts and if that doesn?t work, look into the kernel thread idea.

I don't really understand Andrew J's ideas very well, but hopefully they
help.  The kernel thread idea is fairly complicated to implement, and
there has been an impetus in the kernel to not create new kernel
threads.  But there just has to be a good reason, and this probably is
one.  We worked on it a lot in the IPMI host driver to tune it and got
it to a point where it provided decent performance without causing power
management issues.  When I first read the title I was worried it was
talking about this code; I'm lothe to touch it for fear of breaking
things.

-corey

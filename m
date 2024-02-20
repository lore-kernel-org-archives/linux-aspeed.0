From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 21 Feb 2024 09:06:29 +1030
Subject: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
In-Reply-To: <ZdT+eThnYqb3iawF@mail.minyard.net>
References: <20240220123615.963916-1-geissonator@gmail.com>
	 <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>
	 <ZdT+eThnYqb3iawF@mail.minyard.net>
Message-ID: <9680ad7d7a48fc36a0572dc2286a1229a29341fe.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-02-20 at 13:33 -0600, Corey Minyard wrote:
> On Tue, Feb 20, 2024 at 04:51:21PM +0100, Paul Menzel wrote:
> > Dear Andrew,
> > 
> > 
> > Thank you for your patch. Some style suggestions.
> > 
> > Am 20.02.24 um 13:36 schrieb Andrew Geissler:
> > > From: Andrew Geissler <geissonator@yahoo.com>
> > 
> > (Oh no, Yahoo. (ignore))
> > 
> > You could be more specific in the git commit message by using *Double*:
> > 
> > > ipmi: kcs: Double OBF poll timeout to reduce latency
> > 
> > > ipmi: kcs: Double OBF poll timeout to 200 us to reduce latency
> > 
> > > Commit f90bc0f97f2b ("ipmi: kcs: Poll OBF briefly to reduce OBE
> > > latency") introduced an optimization to poll when the host has
> 
> I assume that removing that patch doesn't fix the issue, it would only
> make it worse, right?

Yep.

> 
> > > read the output data register (ODR). Testing has shown that the 100us
> > > timeout was not always enough. When we miss that 100us window, it
> > > results in 10x the time to get the next message from the BMC to the
> > > host. When you're sending 100's of messages between the BMC and Host,
> > 
> > I do not understand, how this poll timeout can result in such an increase,
> > and why a quite big timeout hurts, but I do not know the implementation.
> 
> It's because increasing that number causes it to poll longer for the
> event, the host takes longer than 100us to generate the event, and if
> the event is missed the time when it is checked again is very long.
> 
> Polling for 100us is already pretty extreme. 200us is really too long.
> 
> The real problem is that there is no interrupt for this.  I'd also guess
> there is no interrupt on the host side, because that would solve this
> problem, too, as it would certainly get around to handling the interupt
> in 100us.  I'm assuming the host driver is not the Linux driver, as it
> should also handle this in a timely manner, even when polling.

I expect the issues Andrew G is observing are with the Power10 boot
firmware. The boot firmware only polls. The runtime firmware enables
interrupts.

> 
> If people want hardware to perform well, they ought to design it and not
> expect software to fix all the problems.

+1

> 
> The right way to fix this is probably to do the same thing the host side
> Linux driver does.  It has a kernel thread that is kicked off to do
> this.  Unfortunately, that's more complicated to implement, but it
> avoids polling in this location (which causes latency issues on the BMC
> side) and lets you poll longer without causing issues.

In Andrew G's case he's talking MCTP over KCS using a vendor-defined
transport binding (that also leverages LPC FWH cycles for bulk data
transfers)[1]. I think it could have taken more inspiration from the
IPMI KCS protocol: It might be worth an experiment to write the dummy
command value to IDR from the host side after each ODR read to signal
the host's clearing of OBF (no interrupt for the BMC) with an IBF
(which does interrupt the BMC). And doing the obverse for the BMC. Some
brief thought suggests that if the dummy value is read there's no need
to send a dummy value in reply (as it's an indicator to read the status
register). With that the need for the spin here (or on the host side)
is reduced at the cost of some constant protocol overhead.

[1]: https://github.com/openbmc/libmctp/blob/master/docs/bindings/vendor-ibm-astlpc.md


Andrew J

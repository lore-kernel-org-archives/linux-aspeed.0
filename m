From: Corey Minyard <minyard@acm.org>
Date: Tue, 20 Feb 2024 13:33:13 -0600
Subject: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
In-Reply-To: <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>
References: <20240220123615.963916-1-geissonator@gmail.com>
 <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>
Message-ID: <ZdT+eThnYqb3iawF@mail.minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 20, 2024 at 04:51:21PM +0100, Paul Menzel wrote:
> Dear Andrew,
> 
> 
> Thank you for your patch. Some style suggestions.
> 
> Am 20.02.24 um 13:36 schrieb Andrew Geissler:
> > From: Andrew Geissler <geissonator@yahoo.com>
> 
> (Oh no, Yahoo. (ignore))
> 
> You could be more specific in the git commit message by using *Double*:
> 
> > ipmi: kcs: Double OBF poll timeout to reduce latency
> 
> > ipmi: kcs: Double OBF poll timeout to 200 us to reduce latency
> 
> > Commit f90bc0f97f2b ("ipmi: kcs: Poll OBF briefly to reduce OBE
> > latency") introduced an optimization to poll when the host has

I assume that removing that patch doesn't fix the issue, it would only
make it worse, right?

> > read the output data register (ODR). Testing has shown that the 100us
> > timeout was not always enough. When we miss that 100us window, it
> > results in 10x the time to get the next message from the BMC to the
> > host. When you're sending 100's of messages between the BMC and Host,
> 
> I do not understand, how this poll timeout can result in such an increase,
> and why a quite big timeout hurts, but I do not know the implementation.

It's because increasing that number causes it to poll longer for the
event, the host takes longer than 100us to generate the event, and if
the event is missed the time when it is checked again is very long.

Polling for 100us is already pretty extreme. 200us is really too long.

The real problem is that there is no interrupt for this.  I'd also guess
there is no interrupt on the host side, because that would solve this
problem, too, as it would certainly get around to handling the interupt
in 100us.  I'm assuming the host driver is not the Linux driver, as it
should also handle this in a timely manner, even when polling.

If people want hardware to perform well, they ought to design it and not
expect software to fix all the problems.

The right way to fix this is probably to do the same thing the host side
Linux driver does.  It has a kernel thread that is kicked off to do
this.  Unfortunately, that's more complicated to implement, but it
avoids polling in this location (which causes latency issues on the BMC
side) and lets you poll longer without causing issues.

I'll let the people who maintain that code comment.

-corey

> 
> > this results in a server boot taking 50% longer for IBM P10 machines.
> > 
> > Started with 1000 and worked it down until the issue started to reoccur.
> > 200 was the sweet spot in my testing. 150 showed the issue
> > intermittently.
> 
> I?d add a blank line here.
> 
> > Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> > ---
> >   drivers/char/ipmi/kcs_bmc_aspeed.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > index 72640da55380..af1eae6153f6 100644
> > --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> > +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > @@ -422,7 +422,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
> >   			 * missed the event.
> >   			 */
> >   			rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
> > -						      !(str & KCS_BMC_STR_OBF), 1, 100, false,
> > +						      !(str & KCS_BMC_STR_OBF), 1, 200, false,
> >   						      &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
> >   			/* Time for the slow path? */
> >   			if (rc == -ETIMEDOUT)
> 
> 
> Kind regards,
> 
> Paul

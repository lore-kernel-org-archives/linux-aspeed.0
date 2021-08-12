From: Corey Minyard <minyard@acm.org>
Date: Thu, 12 Aug 2021 08:36:55 -0500
Subject: [Openipmi-developer] [PATCH v5 1/3] i2c: aspeed: Add
 slave_enable() to toggle slave mode
In-Reply-To: <YRTQP9sX0hkTJMTx@shikoro>
References: <20210714033833.11640-1-quan@os.amperecomputing.com>
 <20210714033833.11640-2-quan@os.amperecomputing.com>
 <YRTQP9sX0hkTJMTx@shikoro>
Message-ID: <20210812133655.GT3406@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 12, 2021 at 09:39:43AM +0200, Wolfram Sang wrote:
> Hi all,
> 
> On Wed, Jul 14, 2021 at 10:38:31AM +0700, Quan Nguyen wrote:
> > Slave needs time to prepare the response data before Master could
> > enquiry via read transaction. However, there is no mechanism for
> > i2c-aspeed Slave to notify Master that it needs more time to process
> > and this make Master side to time out when trying to get the response.
> > 
> > This commit introduces the slave_enable() callback in struct
> > i2c_algorithm for Slave to temporary stop the Slave mode while working
> > on the response and re-enable the Slave when response data ready.
> 
> Sorry that I couldn't chime in earlier, but NAK!
> 
> >  include/linux/i2c.h             |  2 ++
> 
> @Corey: Please do not change this file without my ACK. It is not a
> trivial change but an API extenstion and that should really be acked by
> the subsystem maintainer, in this case me. I was really surprised to see
> this in linux-next already.

I am sorry, I'll pull it out.

-corey

> 
> @all: Plus, I neither like the API (because it doesn't look generic to
> me but mostly handling one issue needed here) nor do I fully understand
> the use case. Normally, when a read is requested and the backend needs
> time to deliver the data, the hardware should stretch the SCL clock
> until some data register is finally written to. If it doesn't do it for
> whatever reason, this is a quirky hardware in my book and needs handling
> in the driver only. So, what is special with this HW? Can't we solve it
> differently?
> 
> All the best,
> 
>    Wolfram
> 




> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer


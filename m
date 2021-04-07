From: Corey Minyard <minyard@acm.org>
Date: Wed, 7 Apr 2021 09:28:28 -0500
Subject: [PATCH v2 0/3] Add Aspeed SSIF BMC driver
In-Reply-To: <0e7fceff-4a01-5cb0-72eb-8b47d598f1c3@os.amperecomputing.com>
References: <20210330141029.20412-1-quan@os.amperecomputing.com>
 <20210402142124.GV507977@minyard.net>
 <0e7fceff-4a01-5cb0-72eb-8b47d598f1c3@os.amperecomputing.com>
Message-ID: <20210407142828.GE7166@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 07, 2021 at 08:09:50PM +0700, Quan Nguyen wrote:
> Hi Corey,
> 
> Thank you for reviewing
> I'll put my respond inline below.
> 
> -Quan
> 
> On 02/04/2021 21:21, Corey Minyard wrote:
> > On Tue, Mar 30, 2021 at 09:10:26PM +0700, Quan Nguyen wrote:
> > > This series add support for the Aspeed specific SSIF BMC driver which
> > > is to perform in-band IPMI communication with the host in management
> > > (BMC) side.
> > 
> > I don't have any specific feedback for this, but I'm wondering if it's
> > really necessary.
> > 
> > Why can't the BMC just open the I2C device and use it?  Is there any
> > functionality that this provides that cannot be accomplished from
> > userland access to the I2C device?  I don't see any.
> > 
> > If it tied into some existing framework to give abstract access to a BMC
> > slave side interface, I'd be ok with this.  But I don't see that.
> > 
> 
> The SSIF at the BMC side acts as an I2C slave and we think that the kernel
> driver is unavoidable to handle the I2c slave events
> (https://www.kernel.org/doc/html/latest/i2c/slave-interface.html)
> 
> And to make it works with existing OpenBMC IPMI stack, a userspace part,
> ssifbridge, is needed (https://github.com/openbmc/ssifbridge). This
> ssifbridge is to connect this driver with the OpenBMC IPMI stack so the IPMI
> stack can communicate via SSIF channel in similar way that was implemented
> with BT and KCS (ie: btbridge/kcsbridge and its corespondent kernel drivers
> (https://github.com/openbmc/btbridge and
> https://github.com/openbmc/kcsbridge))

Dang, I don't know why there's not a generic userland interface for
the slave.  And I've made this mistake before :(.

Anyway, you are right, you need a driver.  I'll review.

-corey

> 
> > Unless there is a big need to have this in the kernel, I'm against
> > including this and would suggest you do all this work in userland.
> > Perhaps write a library.  Sorry, but I'm trying to do my part to reduce
> > unnecessary things in the kernel.
> > 
> > Thanks,
> > 
> > -corey
> > 

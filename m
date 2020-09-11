From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 11 Sep 2020 14:15:56 +0930
Subject: [PATCH 0/4] Remove LPC register partitioning
In-Reply-To: <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
 <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
Message-ID: <551926fc-7bd4-4a0e-8fcf-4675dcdba22b@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 11 Sep 2020, at 13:33, Joel Stanley wrote:
> Hello,
> 
> On Fri, 11 Sep 2020 at 03:46, Chia-Wei, Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
> > The LPC controller has no concept of the BMC and the Host partitions.
> > The incorrect partitioning can impose unnecessary range restrictions
> > on register access through the syscon regmap interface.
> >
> > For instance, HICRB contains the I/O port address configuration
> > of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
> > HICRB as it is located at the other LPC partition.

Thanks for addressing this, I've regretted that choice for a while now.

The split was rooted in trying to support pinmux while not being
across every detail of the LPC controller, and so I made some poor
decisions.

> >
> > In addition, to be backward compatible, the newly added HW control
> > bits could be added at any reserved bits over the LPC addressing space.
> >
> > Thereby, this patch series aims to remove the LPC partitioning for
> > better driver development and maintenance.
> 
> I support this cleanup. The only consideration is to be careful with
> breaking the driver/device-tree relationship. We either need to ensure
> the drivers remain compatible with  both device trees.
> 
> Another solution is to get agreement from all parties that for the LPC
> device the device tree is always the one shipped with the kernel, so
> it is okay to make incompatible changes.
> 
> While we are doing a cleanup, Andrew suggested we remove the detailed
> description of LPC out of the device tree. We would have the one LPC
> node, and create a LPC driver that creates all of the sub devices
> (snoop, FW cycles, kcs, bt, vuart). Andrew, can  you elaborate on this
> plan?

I dug up the conversation I had with Rob over a year ago about being
unhappy with what I'd cooked up.

https://lore.kernel.org/linux-arm-kernel/CAL_JsqJ+sFDG8eKbV3gvmqVHx+otWbki4dY213apzXgfhbXXEw at mail.gmail.com/

But I think you covered most of the idea there: We have the LPC driver
create the subdevices and that moves the details out of the devicetree.
However, I haven't thought about it more than that, and I think there are
still problems with that idea. For instance, how we manage configuration
of those devices, and how to enable only the devices a given platform
actually cares about (i.e. the problems that devicetree solves for us).

It may be that the only way to do that is with platform code, and that's
not really a direction we should be going either.

Andrew

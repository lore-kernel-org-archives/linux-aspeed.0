From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 05 Sep 2018 09:45:54 +0930
Subject: [PATCH 1/2] misc: aspeed: Add Aspeed UART routing control driver.
In-Reply-To: <CACRpkdamHdGH9bANugQchYLWFS_mde6MmcbvBgcG-hrhvGVFWQ@mail.gmail.com>
References: <20180904202018.198707-1-osk@google.com>
 <20180904202018.198707-2-osk@google.com>
 <CACRpkdamHdGH9bANugQchYLWFS_mde6MmcbvBgcG-hrhvGVFWQ@mail.gmail.com>
Message-ID: <1536106554.3176480.1496936032.1C7BEEDC@webmail.messagingengine.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 5 Sep 2018, at 07:25, Linus Walleij wrote:
> On Tue, Sep 4, 2018 at 10:20 PM Oskar Senft <osk@google.com> wrote:
> 
> > This driver adds sysfs files that allow the BMC userspace to configure
> > how UARTs and physical serial I/O ports are routed.
> >
> > Tested: Checked correct behavior (both read & write) on TYAN S7106
> > board by manually changing routing settings and confirming that bits
> > flow as expected. Tested for UART1 and UART3 as this board doesn't have
> > the other UARTs wired up in a testable way.
> >
> > Signed-off-by: Oskar Senft <osk@google.com>
> 
> After reading some other messages about this I realize it's not very
> much you can do with the standard frameworks and you definately
> need something like this. Not like I have any better idea.
> 
> Arnd and Greg are misc maintainers so not you will need to
> talk to them.

Yes. I'm certainly not a person that can merge them. 

Oskar: Please add at least Greg and Arnd as Linus suggests, and in the future make use of ./scripts/get_maintainer.pl to identify people and lists who should receive the patches.

> 
> I would opt to put it in drivers/soc/aspeed though.

Yep, drivers/soc/aspeed seems like a better place. There are other drivers in misc likely should be moved there as well.

Thanks for your feedback Linus.

Andrew

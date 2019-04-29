From: Joel Stanley <joel@jms.id.au>
Date: Mon, 29 Apr 2019 07:48:52 +0000
Subject: [PATCH v2] soc: add aspeed folder and misc drivers
In-Reply-To: <20190425172549.GA12376@kroah.com>
References: <20190423142629.120717-1-venture@google.com>
 <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com>
Message-ID: <CACPK8XemgKvM38wDSUJsXXeK51dwmeUoKWn+e3ZNHd9v5VBZHA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2019 at 17:25, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > currently present into this folder.  These drivers are not generic part
> > > > drivers, but rather only apply to the ASPEED SoCs.
> > > >
> > > > Signed-off-by: Patrick Venture <venture@google.com>
> > >
> > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > didn't see it on v1 before re-sending v2 to the larger audience.
> >
> > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > Ack this version of the patchset since it changes when the soc/aspeed
> > Makefile is followed.
>
> I have no objection for moving stuff out of drivers/misc/ so the SOC
> maintainers are free to take this.

I was on the fence about this. The downside of moving drivers out of
drivers/misc is it allows SoCs to hide little drivers away from
scrutiny, when in fact they could be sharing a common userspace API
with other BMCs.  (Keep an eye out for the coming Nuvoton "bios post
code" driver which is very similar to
drivers/misc/aspeed-lpc-snoop.c).

However, in the effort to move away from BMC that are full of shell
scripts that bash on /dev/mem, we are going to see a collection of
small, very SoC specific, drivers and it doesn't make sense to clutter
up drivers/misc.

Acked-by: Joel Stanley <joel@jms.id.au>

The p2a driver has been merged by Greg. We should move that one over
too. Arnd, can you advise Patrick on how to proceed? We could have him
spin a v3 that includes the p2a driver, but it would depend on Greg's
char-misc-next branch.

Cheers,

Joel

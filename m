From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 06:10:03 +0000
Subject: [GIT PULL] ARM: aspeed: soc changes for 5.10
In-Reply-To: <CACPK8XcLOopkx0k14k25puD3YkwHzZS0+3TLcEL43xbxCZBphA@mail.gmail.com>
References: <CACPK8XcP_j7q+jWN6_JGaEcfPy=zSQHyizp1LOw05zFB4L9iGQ@mail.gmail.com>
 <20201003201352.GI8203@lx2k>
 <CACPK8XcLOopkx0k14k25puD3YkwHzZS0+3TLcEL43xbxCZBphA@mail.gmail.com>
Message-ID: <CACPK8XfWfvCBW2WET8WknZFkROSDX3WtQ39ie5wbn0eRJfb1UQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2020 at 11:18, Joel Stanley <joel@jms.id.au> wrote:
>
> On Sat, 3 Oct 2020 at 20:31, Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi Joel,
> >
> > On Fri, Sep 25, 2020 at 06:31:28AM +0000, Joel Stanley wrote:
> > > Hello Soc maintainers,
> > >
> > > Here are some ASPEED changes for the 5.10 merge window.
> > >
> > > The following changes since commit e55f541e51b5136fc0ced0bdf2b33ee3cca3bc96:
> > >
> > >   soc: aspeed: xdma: Add reset ioctl (2020-09-25 15:32:57 +0930)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> > > tags/aspeed-5.10-soc
> > >
> > > for you to fetch changes up to e55f541e51b5136fc0ced0bdf2b33ee3cca3bc96:
> > >
> > >   soc: aspeed: xdma: Add reset ioctl (2020-09-25 15:32:57 +0930)
> > >
> > > ----------------------------------------------------------------
> > > ASPEED soc driver updates for 5.10
> > >
> > > New drivers:
> > >
> > >  - XDMA driver for the BMC to host PCIe DMA device
> >
> > I don't think this driver belongs in drivers/soc, it's not "soc glue
> > logic", and it has a userspace interface. Some of the commits even
> > references it as a "misc driver". Mind resubmitting it for drivers/misc
> > instead?
>
> (Argh I missed this mail)
>
> We used to have the various little drivers in drivers/misc, but
> somewhere along the line we decided to move them to drivers/soc. I
> think that was Arnd asking Patrick Venture?
>
> https://lore.kernel.org/linux-arm-kernel/CAK8P3a3CK4o8KnD6M084ULEmm+6_CtNFqYHjSqE5vp+U9YAmkA at mail.gmail.com/
>
> The existing drivers have userspace interfaces for misc parts of the
> aspeed chip, mostly relating to the strange (from a traditional
> Linux/host perspective) interfaces it exposes to the host. This XDMA
> driver should go alongside those other drivers.
>
> With that context, how would you like to proceed?

Arnd, Olof, what would you like to do here?

Cheers,

Joel

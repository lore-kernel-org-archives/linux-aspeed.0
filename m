From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Aug 2023 05:37:41 +0000
Subject: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
In-Reply-To: <ZNR21UVdfxlvpZAt@taoren-fedora-PC23YAB4>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
 <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com> <ZNR21UVdfxlvpZAt@taoren-fedora-PC23YAB4>
Message-ID: <CACPK8Xd7LpMuVC63PSfcLmXf4wRThMNRYr9vRxZh246+-DUFFA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 at 05:34, Tao Ren <rentao.bupt@gmail.com> wrote:
>
> Hi Joel,
>
> On Wed, Aug 09, 2023 at 08:08:12AM +0000, Joel Stanley wrote:
> > On Thu, 3 Aug 2023 at 23:03, <rentao.bupt@gmail.com> wrote:
> > >
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > >
> > > The patch series fixes a few entries in wedge400 device tree.
> > >
> > > Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
> > > by wedge400 dts) to make sure spi bus is consistent with flash labels in
> > > flash layout.
> > >
> > > Patch #2 enables more ADC channels in wedge400 dts.
> > >
> > > Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.
> > >
> > > Tao Ren (3):
> > >   ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
> >
> > I wondered if we should do this in the aspeed-g5.dtsi.
>
> I also hesitated if I should do it in aspeed-g5.dtsi, but I didn't do it
> because I was not sure if others care about the spi aliases.. Should I
> send out v2 to move the alias to aspeed-g5.dtsi?

I wasn't sure either. Lets leave it as-is, but if we see other systems
wanting similar numbering then we can put it in the common dtsi.

I've applied this to the aspeed tree now.

Cheers,

Joel

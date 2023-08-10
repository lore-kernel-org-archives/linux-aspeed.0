From: Tao Ren <rentao.bupt@gmail.com>
Date: Wed, 9 Aug 2023 22:34:13 -0700
Subject: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
In-Reply-To: <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
 <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com>
Message-ID: <ZNR21UVdfxlvpZAt@taoren-fedora-PC23YAB4>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

On Wed, Aug 09, 2023 at 08:08:12AM +0000, Joel Stanley wrote:
> On Thu, 3 Aug 2023 at 23:03, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch series fixes a few entries in wedge400 device tree.
> >
> > Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
> > by wedge400 dts) to make sure spi bus is consistent with flash labels in
> > flash layout.
> >
> > Patch #2 enables more ADC channels in wedge400 dts.
> >
> > Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.
> >
> > Tao Ren (3):
> >   ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
> 
> I wondered if we should do this in the aspeed-g5.dtsi.

I also hesitated if I should do it in aspeed-g5.dtsi, but I didn't do it
because I was not sure if others care about the spi aliases.. Should I
send out v2 to move the alias to aspeed-g5.dtsi?

Cheers,

Tao

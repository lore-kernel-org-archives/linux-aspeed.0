From: Peter Delevoryas <peter@pjd.dev>
Date: Thu, 14 Jul 2022 13:24:59 -0700
Subject: [PATCH v3] The Yosemite V3.5 is a facebook multi-node server
 platform that host four OCP server. The BMC in the Yosemite V3.5 platform
 based on AST2600 SoC.
In-Reply-To: <CAK8P3a1juHV6N2QtXaEcobWs6kQHBqqUn9MynvobyJtFFyOsfg@mail.gmail.com>
References: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
 <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com>
 <YtBazSo/uJzFeF+L@pdel-mbp>
 <CAK8P3a1juHV6N2QtXaEcobWs6kQHBqqUn9MynvobyJtFFyOsfg@mail.gmail.com>
Message-ID: <YtB7mw1YSahFg0xI@pdel-mbp.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 14, 2022 at 10:15:15PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 14, 2022 at 8:05 PM Peter Delevoryas <peter@pjd.dev> wrote:
> > On Thu, Jul 07, 2022 at 03:33:48PM +0200, Arnd Bergmann wrote:
> > > > +       model = "Facebook fby35";
> > > > +       compatible = "facebook,fby35", "aspeed,ast2600";
> > > > +
> > > > +       aliases {
> > > > +               serial4 = &uart5;
> > > > +       };
> > >
> > > Why not start at serial0 here?
> >
> > Hey, Facebook person jumping in here (using a personal email):
> >
> > I think you're right, it should be like this:
> >
> >         aliases {
> >                 serial0 = &uart5;
> >                 serial1 = &uart1;
> >                 serial2 = &uart2;
> >                 serial3 = &uart3;
> >                 serial4 = &uart4;
> >         };
> 
> Are you actually using all five uarts though?

Actually yes, I should have mentioned this in my previous message.

YosemiteV3.5 is similar to YosemiteV3, which you can see here:

https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server

This dts is for the BMC on the sled baseboard, and it manages the 4 slots in the
sled. Each slot has a "Bridge Interconnect" (BIC) (an AST1030) that manages the
slot CPU/etc. uart1 is connected to a uart on slot1's BIC, uart2 to slot2, etc.

We also have a work-in-progress QEMU model for this:

https://lore.kernel.org/qemu-devel/20220714154456.2565189-1-clg at kaod.org/

> 
> > > > +       chosen {
> > > > +               stdout-path = &uart5;
> > > > +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";
> > > > +       };
> >
> > Also: if we do serial0 = &uart5, it should be console=ttyS0, not ttyS4.
> >
> > >
> > > The bootargs should really come from the boot loader.
> >
> > What if we want to boot the kernel by itself with QEMU? It's kinda annoying to
> > have to specify '-append "console=ttyS0,57600n8...' everytime, or to have to use
> > a wrapper script. But, it's also a source of bugs: I realized yesterday the
> > dts we were using here:
> >
> > https://github.com/facebook/openbmc-linux/blob/e26c76992e0761d9e440ff514538009384c094b4/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
> >
> > Has the wrong console setting.
> 
> You can encode the uart settings like
> 
>            stdout-path = "serial0:115200n8"
> 
> the rest really should be passed on the command line, not in
> the DT shipped with the kernel.
> 
>         Arnd

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Jul 2022 22:15:15 +0200
Subject: [PATCH v3] The Yosemite V3.5 is a facebook multi-node server
 platform that host four OCP server. The BMC in the Yosemite V3.5 platform
 based on AST2600 SoC.
In-Reply-To: <YtBazSo/uJzFeF+L@pdel-mbp>
References: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
 <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com> <YtBazSo/uJzFeF+L@pdel-mbp>
Message-ID: <CAK8P3a1juHV6N2QtXaEcobWs6kQHBqqUn9MynvobyJtFFyOsfg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 14, 2022 at 8:05 PM Peter Delevoryas <peter@pjd.dev> wrote:
> On Thu, Jul 07, 2022 at 03:33:48PM +0200, Arnd Bergmann wrote:
> > > +       model = "Facebook fby35";
> > > +       compatible = "facebook,fby35", "aspeed,ast2600";
> > > +
> > > +       aliases {
> > > +               serial4 = &uart5;
> > > +       };
> >
> > Why not start at serial0 here?
>
> Hey, Facebook person jumping in here (using a personal email):
>
> I think you're right, it should be like this:
>
>         aliases {
>                 serial0 = &uart5;
>                 serial1 = &uart1;
>                 serial2 = &uart2;
>                 serial3 = &uart3;
>                 serial4 = &uart4;
>         };

Are you actually using all five uarts though?

> > > +       chosen {
> > > +               stdout-path = &uart5;
> > > +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";
> > > +       };
>
> Also: if we do serial0 = &uart5, it should be console=ttyS0, not ttyS4.
>
> >
> > The bootargs should really come from the boot loader.
>
> What if we want to boot the kernel by itself with QEMU? It's kinda annoying to
> have to specify '-append "console=ttyS0,57600n8...' everytime, or to have to use
> a wrapper script. But, it's also a source of bugs: I realized yesterday the
> dts we were using here:
>
> https://github.com/facebook/openbmc-linux/blob/e26c76992e0761d9e440ff514538009384c094b4/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
>
> Has the wrong console setting.

You can encode the uart settings like

           stdout-path = "serial0:115200n8"

the rest really should be passed on the command line, not in
the DT shipped with the kernel.

        Arnd

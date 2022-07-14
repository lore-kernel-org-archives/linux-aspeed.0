From: Peter Delevoryas <peter@pjd.dev>
Date: Thu, 14 Jul 2022 11:05:01 -0700
Subject: [PATCH v3] The Yosemite V3.5 is a facebook multi-node server
 platform that host four OCP server. The BMC in the Yosemite V3.5 platform
 based on AST2600 SoC.
In-Reply-To: <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com>
References: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
 <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com>
Message-ID: <YtBazSo/uJzFeF+L@pdel-mbp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 07, 2022 at 03:33:48PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 7, 2022 at 3:20 PM Logananth Sundararaj
> <logananth13.hcl@gmail.com> wrote:
> >
> > This patch adds linux device tree entry related to
> > Yosemite V3.5 specific devices connected to BMC SoC.
> >
> > Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>
> 
> 
> Something went wrong with the patch description, it looks like you dropped
> the subject and sent the first paragraph as the subject instead.
> 
> > +/ {
> > +       model = "Facebook fby35";
> > +       compatible = "facebook,fby35", "aspeed,ast2600";
> > +
> > +       aliases {
> > +               serial4 = &uart5;
> > +       };
> 
> Why not start at serial0 here?

Hey, Facebook person jumping in here (using a personal email):

I think you're right, it should be like this:

	aliases {
		serial0 = &uart5;
		serial1 = &uart1;
		serial2 = &uart2;
		serial3 = &uart3;
		serial4 = &uart4;
	};

> 
> > +       chosen {
> > +               stdout-path = &uart5;
> > +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";
> > +       };

Also: if we do serial0 = &uart5, it should be console=ttyS0, not ttyS4.

> 
> The bootargs should really come from the boot loader.

What if we want to boot the kernel by itself with QEMU? It's kinda annoying to
have to specify '-append "console=ttyS0,57600n8...' everytime, or to have to use
a wrapper script. But, it's also a source of bugs: I realized yesterday the
dts we were using here:

https://github.com/facebook/openbmc-linux/blob/e26c76992e0761d9e440ff514538009384c094b4/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts

Has the wrong console setting.

Booting the kernel directly is actualy really useful for us, because U-Boot
literally takes 4+ minutes in QEMU because we execute in-place from flash for
most of it.

> 
> Why do you need the vmalloc=384M? That seems excessive.

Yeah I'm not sure what that is about, would need to find
the person who wrote this originally. Speaking of which:

The dts I linked above, from our repo, how come this patch is not just a copy of
that?

> 
> > +
> > +       memory at 80000000 {
> > +               device_type = "memory";
> > +               reg = <0x80000000 0x80000000>;
> > +       };
> 
> The memory location and size is usually also set by the boot loader

Yeah not sure what happens if I remove this and boot the kernel directly in
QEMU, would we need to specify the RAM size explicitly in console args? Hmmm,
I'll check it out.

Thanks for your comments!
Peter

> 
>         Arnd

From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 21 Oct 2020 16:12:49 +1030
Subject: [PATCH 2/2] ARM: dts: tacoma: Add reserved memory for ramoops
In-Reply-To: <CACPK8XeiPBPyLu5pvjCgYquCKh+PynVKGyibUSAi+W_xw0Awfg@mail.gmail.com>
References: <20201016043513.119841-1-andrew@aj.id.au>
 <20201016043513.119841-3-andrew@aj.id.au>
 <CACPK8XeiPBPyLu5pvjCgYquCKh+PynVKGyibUSAi+W_xw0Awfg@mail.gmail.com>
Message-ID: <1a5c7370-164c-4a58-a08c-d81e4b6ce419@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 21 Oct 2020, at 15:35, Joel Stanley wrote:
> On Fri, 16 Oct 2020 at 04:36, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Reserve a 1.5MiB region of memory to record kmsg dumps, console and
> > userspace message state into 16kiB ring-buffer slots. The sizing allows
> > for up to 32 dumps to be captured and read out.
> >
> > Set max-reason to KMSG_DUMP_EMERG to capture bad-path reboots.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> > index 46f2f538baba..4f7e9b490e1a 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> > @@ -26,6 +26,15 @@ reserved-memory {
> >                 #size-cells = <1>;
> >                 ranges;
> >
> > +               ramoops at b9e80000 {
> > +                       compatible = "ramoops";
> > +                       reg = <0xb9e80000 0x180000>;
> 
> I take that r-b back. When booting, we see:
> 
> [    0.000000] region at ba000000 (0xb8000000--0xbc000000) overlaps with
> ramoops at b9e80000 (0xb9e80000--0xba000000)
> 
> Which appears to be a true statement.

Yep:

> 
> > +                       record-size = <0x4000>;
> > +                       console-size = <0x4000>;
> > +                       pmsg-size = <0x4000>;
> > +                       max-reason = <3>; /* KMSG_DUMP_EMERG */
> > +               };
> > +
> >                 flash_memory: region at ba000000 {
> >                         no-map;
> >                         reg = <0xb8000000 0x4000000>; /* 64M */

Looks like I derived the ramoops address from the flash_memory node label, but 
that's mismatched with its reg value.

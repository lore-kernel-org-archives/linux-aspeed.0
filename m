From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 25 Feb 2020 10:10:06 +1030
Subject: [PATCH] ARM: dts: aspeed: tacoma: Enable eMMC controller
In-Reply-To: <CACPK8XeLWZT-VvuErtz6oE1tv1dhwwOnpZbV7PVr2PxgT2fopA@mail.gmail.com>
References: <20200202163939.13326-1-linux@roeck-us.net>
 <CACPK8XeLWZT-VvuErtz6oE1tv1dhwwOnpZbV7PVr2PxgT2fopA@mail.gmail.com>
Message-ID: <c5d15783-4e4c-426b-9df0-ee8efc57cefc@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 4 Feb 2020, at 16:24, Joel Stanley wrote:
> On Sun, 2 Feb 2020 at 16:39, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Enabling emmc without enabling its controller doesn't do any good.
> > Enable its controller as well to make it work.
> >
> > Cc: Andrew Jeffery <andrew@aj.id.au>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks Guenter. The description in aspeed-g6.dtsi changed at some
> point and Tacoma was not updated.
> 
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> > index ff49ec76fa7c..47293a5e0c59 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> > @@ -132,6 +132,10 @@
> >         use-ncsi;
> >  };
> >
> > +&emmc_controller {
> > +       status = "okay";
> > +};
> > +
> >  &emmc {
> >         status = "okay";
> >  };
> 
> This node is redundant, as it is not disabled in the dtsi.
> 
> Andrew, should we add disabled to the emmc node?

Probably. Also the nodes are badly named, partly because of the structure
of the IP block. 'emmc' in this instance isn't the actual card, it's the SDHCI,
and emmc_controller is a 'parent' that contains some global state which
applies to one or more SDHCIs inside the IP block.

We should probably cook up better names.

> 
> Or remove the label completely, and just have emmc_controller?

Maybe this is a better approach? The eMMC IP block only has one associated
SDHCI, so that would make sense.

Andrew

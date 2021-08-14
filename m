From: Tao Ren <rentao.bupt@gmail.com>
Date: Fri, 13 Aug 2021 22:22:29 -0700
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
In-Reply-To: <YRaFpq1LvRzMYr/A@lunn.ch>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
 <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
 <YRaFpq1LvRzMYr/A@lunn.ch>
Message-ID: <20210814052228.GA1298@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Fri, Aug 13, 2021 at 04:45:58PM +0200, Andrew Lunn wrote:
> On Thu, Aug 12, 2021 at 08:40:17PM -0700, Tao Ren wrote:
> > On Fri, Aug 13, 2021 at 01:29:17AM +0000, Joel Stanley wrote:
> > > On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> > > > +&mdio1 {
> > > > +       status = "okay";
> > > 
> > > You're enabling this but it looks like it's unused?
> > 
> > Thanks Joel for the careful review. The MDIO controller is not paired
> > with BMC MAC; instead, it's connected to the MDC/MDIO interface of the
> > on-board switch (whose ports are connected to BMC, Host and front panel
> > management port).
> 
> What switch is it? Is there a DSA driver for it? drivers/net/dsa/*
> Ideally you want Linux to be controlling the switch, in the standard
> linux way.
> 
>      Andrew

Thanks for jumping in. We are using BCM5389 and the MDIO bus is used to
access BCM5389 MDC/MDIO interface in Pseudo-PHY mode.

I didn't know drivers/net/dsa, but let me check out the drivers and see
if it works in the Cloudripper environment.


Thanks,

Tao

From: Joel Stanley <joel@jms.id.au>
Date: Thu, 5 Aug 2021 02:17:13 +0000
Subject: [PATCH 6/6] ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC
In-Reply-To: <20210805020946.GA29371@taoren-ubuntu-R90MNF91>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
 <20210728233755.17963-7-rentao.bupt@gmail.com>
 <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
 <20210805011951.GA28444@taoren-ubuntu-R90MNF91>
 <CACPK8XcwsOa5NzsUZeiv5qdWV5H6HBa7WK+cwbnqayP4zhoNkg@mail.gmail.com>
 <20210805020946.GA29371@taoren-ubuntu-R90MNF91>
Message-ID: <CACPK8XfewBvd4BLgkgkC0DBzVk5pmV4ZTVaVt=otrKfqJ6m5Lg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 5 Aug 2021 at 02:09, Tao Ren <rentao.bupt@gmail.com> wrote:
>
> On Thu, Aug 05, 2021 at 01:37:29AM +0000, Joel Stanley wrote:
> > On Thu, 5 Aug 2021 at 01:20, Tao Ren <rentao.bupt@gmail.com> wrote:
> > > > > +&ehci1 {
> > > > > +       status = "okay";
> > > > > +};
> > > >
> > > > Have you verified that USB works with mainline? I've had reports of it
> > > > working on 5.8 but it seems to have regressed as of v5.10.
> > >
> > > It stopped working on ASPEED since commit 280a9045bb18 ("ehci: fix EHCI
> > > host controller initialization sequence"): ehci_handshake() returns
> > > error because HCHalted bit EHCI24[12] stays at 1.
> > >
> > > I have a dirty hack in my tree (ignoring the halt bit) and it "works" on
> > > AST2500 and AST2600. Let me send an email to openbmc and aspeed email
> > > groups to see if anyone has more context.
> >
> > We discovered the same, except in my testing it wasn't actually
> > "working" on my EVB. I have a A3 EVB on my desk and when plugging in a
> > USB key nothing happened.
>
> We have a non-removable USB device on Fuji (AST2600) BMC and it can be
> enumerated successfully (after applying the hack). Let me vist the lab
> and plug a USB key to CMM (AST2500) BMC sometime next week. Will collect
> results and send out email then.

Thanks!

> > > status is set in ast2600 common dtsi, but let me set it here to avoid
> > > confusion. Will update pinmux in v2. Thanks.
> >
> > Are you looking at mainline? I think it's disabled by default there:
> >
> > https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/aspeed-g6.dtsi#L246
>
> Sorry for the confusion, Joel. I mean the device is enabled in
> "ast2600-facebook-netbmc-common.dtsi" (patch #3 in the series). Do we
> still need to set status to "okay" explicitly in platform dts (to avoid
> confusion)?

I see, thanks for explaining. It's a downside of the device tree
bindings for the ethernet device.

Given you will be the one working with the board, I think it's up to
you how you lay it out. You could choose to add a comment to the
platform dts, or put the hunk you currently have in the common.dtsi in
the platform.

>
> &mac3 {
>         status = "okay";
>         phy-mode = "rgmii";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_rgmii4_default>;
> };

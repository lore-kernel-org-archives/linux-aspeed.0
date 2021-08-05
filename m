From: Tao Ren <rentao.bupt@gmail.com>
Date: Wed, 4 Aug 2021 18:19:51 -0700
Subject: [PATCH 6/6] ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC
In-Reply-To: <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
 <20210728233755.17963-7-rentao.bupt@gmail.com>
 <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
Message-ID: <20210805011951.GA28444@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 05, 2021 at 12:28:02AM +0000, Joel Stanley wrote:
> On Wed, 28 Jul 2021 at 23:38, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Add initial version of device tree for Facebook Fuji (AST2600) BMC.
> 
> I like to read what kind of platform the BMC is going into if you can
> add that detail, but it's not essential.

Sure. I will add more details in v2.
 
> > +&spi1 {
> > +       status = "okay";
> > +
> > +       /*
> > +        * Customize spi1 flash memory size to 32MB (maximum flash size on
> > +        * the bus) to save vmalloc space.
> > +        */
> > +       reg = < 0x1e630000 0xc4
> > +               0x30000000 0x2000000 >;
> 
> Which driver supports this?
> 
> It would be great to see Facebook work to get the SPI NOR driver for
> the ast2600 merged to mainline.
> 
> I doubt the IBM team will get to this, as we are using eMMC instead.

Ah, I just checked aspeed-g6.dtsi (ast2600-spi) in mainline and I thought
the driver patches were also upstreamed. Let me remove the entry for now,
and will add it back when the driver is ready.

> 
> > +
> > +       flash at 0 {
> > +               status = "okay";
> > +               m25p,fast-read;
> > +               label = "spi1.0";
> > +               spi-max-frequency = <5000000>;
> > +
> > +               partitions {
> > +                       compatible = "fixed-partitions";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +
> > +                       flash1 at 0 {
> > +                               reg = <0x0 0x2000000>;
> > +                               label = "system-flash";
> > +                       };
> > +               };
> > +       };
> > +};
> 
> > +&ehci1 {
> > +       status = "okay";
> > +};
> 
> Have you verified that USB works with mainline? I've had reports of it
> working on 5.8 but it seems to have regressed as of v5.10.

It stopped working on ASPEED since commit 280a9045bb18 ("ehci: fix EHCI
host controller initialization sequence"): ehci_handshake() returns
error because HCHalted bit EHCI24[12] stays at 1.

I have a dirty hack in my tree (ignoring the halt bit) and it "works" on
AST2500 and AST2600. Let me send an email to openbmc and aspeed email
groups to see if anyone has more context.

Meanwhile, should I delete the entry until the fix is ready in driver?
 
> > +&mdio1 {
> > +       status = "okay";
> > +
> > +       ethphy3: ethernet-phy at 13 {
> > +               compatible = "ethernet-phy-ieee802.3-c22";
> > +               reg = <0x0d>;
> > +       };
> > +};
> > +
> > +&mac3 {
> > +       phy-handle = <&ethphy3>;
> 
> status = okay?
> 
> You should specify the pinmux too I think, even if the default happens
> to work, so that other devices cannot claim the pins.

status is set in ast2600 common dtsi, but let me set it here to avoid
confusion. Will update pinmux in v2. Thanks.

> 
> Cheers,
> 
> Joel

Cheers,

Tao

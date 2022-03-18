From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Fri, 18 Mar 2022 09:32:11 +0000
Subject: [PATCH v1] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
 MAC0/MAC1
In-Reply-To: <CACPK8XdYHb-PgVVQuTtMBokxu4GTObG7nCohm4dosK9XWzE9ow@mail.gmail.com>
References: <SG2PR06MB2315A7BAE2F1B384CDADB57FE6139@SG2PR06MB2315.apcprd06.prod.outlook.com>
 <CACPK8XdYHb-PgVVQuTtMBokxu4GTObG7nCohm4dosK9XWzE9ow@mail.gmail.com>
Message-ID: <SG2PR06MB23150B3673E58737ABB08D51E6139@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel

> > +&syscon {
> > +       mac0-clk-delay = <0x10 0x0a
> > +                         0x10 0x10
> > +                         0x10 0x10>;
> 
> These properties aren't supported by the mainline kernel. Do you have some
> code coming for that support?
No, clk-ast2600 did not support it yet.
Let me remove this setting for now since I confirmed that the patch wouldn't be ready very soon.
Currently, the delay will be set at u-boot stage with commit for OpenBMC https://github.com/openbmc/u-boot/commit/e40a4e447a0e7f4d8b38c3256349e39ff3701f1f
So it should be safe for OpenBMC if this part was removed.

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Friday, March 18, 2022 4:46 PM
> To: Howard Chiu <howard_chiu@aspeedtech.com>
> Cc: robh+dt at kernel.org; andrew at aj.id.au; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org; Troy Lee <troy_lee@aspeedtech.com>
> Subject: Re: [PATCH v1] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
> MAC0/MAC1
> 
> Hi Howard,
> 
> On Fri, 18 Mar 2022 at 08:09, Howard Chiu <howard_chiu@aspeedtech.com>
> wrote:
> >
> > Since mac0/1 and mac2/3 are physically located on different die, they
> > have different properties by nature, which is mac0/1 has smaller delay step.
> >
> > The property 'phy-mode' on ast2600 mac0 and mac1 is recommended to set
> to 'rgmii-rxid'
> > which enables the RX interface delay from the PHY chip.
> > Refer page 45 of SDK User Guide v08.00
> >
> https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.00/SD
> K
> > _User_Guide_v08.00.pdf
> >
> > Set mac delay according to the mactest result.
> 
> This bit confused me. How does the rxid relate to the mac delay numbers?
> Which device and code is responsible for using them?
> 
> >
> > Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > index b7eb552640cb..db16ba307e97 100644
> > --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > @@ -103,7 +103,7 @@ ethphy3: ethernet-phy at 0 {
> >  &mac0 {
> >         status = "okay";
> >
> > -       phy-mode = "rgmii";
> > +       phy-mode = "rgmii-rxid";
> >         phy-handle = <&ethphy0>;
> >
> >         pinctrl-names = "default";
> > @@ -114,7 +114,7 @@ &mac0 {
> >  &mac1 {
> >         status = "okay";
> >
> > -       phy-mode = "rgmii";
> > +       phy-mode = "rgmii-rxid";
> >         phy-handle = <&ethphy1>;
> >
> >         pinctrl-names = "default";
> > @@ -141,6 +141,21 @@ &mac3 {
> >         pinctrl-0 = <&pinctrl_rgmii4_default>;  };
> >
> > +&syscon {
> > +       mac0-clk-delay = <0x10 0x0a
> > +                         0x10 0x10
> > +                         0x10 0x10>;
> 
> These properties aren't supported by the mainline kernel. Do you have some
> code coming for that support?
> 
> > +       mac1-clk-delay = <0x10 0x0a
> > +                         0x10 0x10
> > +                         0x10 0x10>;
> > +       mac2-clk-delay = <0x08 0x04
> > +                         0x08 0x04
> > +                         0x08 0x04>;
> > +       mac3-clk-delay = <0x08 0x04
> > +                         0x08 0x04
> > +                         0x08 0x04>;
> > +};
> > +
> >  &emmc_controller {
> >         status = "okay";
> >  };
> > --
> > 2.25.1
> >

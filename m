From: Joel Stanley <joel@jms.id.au>
Date: Thu, 21 Oct 2021 06:48:40 +0000
Subject: [PATCH v7 1/5] ARM: dts: aspeed: Drop reg-io-width from LPC nodes
In-Reply-To: <HK0PR06MB3779F430883E60E7E47849BE91BF9@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-2-chiawei_wang@aspeedtech.com>
 <CACPK8Xc+9yFJn_pO1sAVQJu_FWkA1U9XnbB+TLYgfdbHi1TyaQ@mail.gmail.com>
 <CACPK8Xfj=wJBCX5ogyf02pLJsLrooVWBJ92GJ1E+jxQW5wiFEw@mail.gmail.com>
 <HK0PR06MB3779F430883E60E7E47849BE91BF9@HK0PR06MB3779.apcprd06.prod.outlook.com>
Message-ID: <CACPK8Xc2wzx1dthFYC_0vm4mj9e1BbL+Kwkqc_PvPFj4sqjOJg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 21 Oct 2021 at 06:37, ChiaWei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> > From: Joel Stanley <joel@jms.id.au>
> > Sent: Thursday, October 21, 2021 2:29 PM
> >
> > On Fri, 8 Oct 2021 at 04:35, Joel Stanley <joel@jms.id.au> wrote:
> > >
> > > On Mon, 27 Sept 2021 at 02:31, Chia-Wei Wang
> > > <chiawei_wang@aspeedtech.com> wrote:
> > > >
> > > > The 'reg-io-width' properties are not used by LPC drivers nor
> > > > documented as part of bindings. Therefore drop them.
> > >
> > > I assume they are there due to the lpc having a 'syscon' compatible.
> > > THey are documented in the syscon bindings:
> > >
> > > Documentation/devicetree/bindings/mfd/syscon.yaml
> > >
> > > Andrew, do you have any comments?
> >
> > Andrew indicated to me that he agreed with my observation: the properties
> > should be present as they are used by the regmap/syscon.
>
> Thanks. Shall we just drop this one and move on with the rest patches?
> However, like Rob mentioned, when doing 'make dtbs_check', there is a warning:
>
> /builds/robherring/linux-dt-review/arch/arm/boot/dts/aspeed-ast2500-evb.dt.yaml:
> lpc at 1e789000: 'ibt at 140', 'kcs at 114', 'kcs at 24', 'kcs at 28', 'kcs at 2c', 'lhc at a0', 'reg-io-width' do not match any of the regexes:
> '^lpc-ctrl@[0-9a-f]+$', '^lpc-snoop@[0-9a-f]+$', '^reset-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
>
> As part of this series has been applied, maybe we can fix this later?

Yes, that's a good idea.

I will send a pull request with your driver to the soc maintainers.

Cheers,

Joel

>
> Regards,
> Chiawei
>
> >
> > >
> > > >
> > > > This is in preparation to move aspeed-lpc.txt to YAML schema.
> > > >
> > > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > > ---
> > > >  arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
> > > > arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
> > > > arch/arm/boot/dts/aspeed-g6.dtsi | 1 -
> > > >  3 files changed, 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi
> > > > b/arch/arm/boot/dts/aspeed-g4.dtsi
> > > > index c5aeb3cf3a09..45a25eb4baa4 100644
> > > > --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> > > > +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> > > > @@ -345,7 +345,6 @@
> > > >                         lpc: lpc at 1e789000 {
> > > >                                 compatible =
> > "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon";
> > > >                                 reg = <0x1e789000 0x1000>;
> > > > -                               reg-io-width = <4>;
> > > >
> > > >                                 #address-cells = <1>;
> > > >                                 #size-cells = <1>; diff --git
> > > > a/arch/arm/boot/dts/aspeed-g5.dtsi
> > > > b/arch/arm/boot/dts/aspeed-g5.dtsi
> > > > index 73ca1ec6fc24..8e1d00d8445e 100644
> > > > --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> > > > +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> > > > @@ -436,7 +436,6 @@
> > > >                         lpc: lpc at 1e789000 {
> > > >                                 compatible =
> > "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
> > > >                                 reg = <0x1e789000 0x1000>;
> > > > -                               reg-io-width = <4>;
> > > >
> > > >                                 #address-cells = <1>;
> > > >                                 #size-cells = <1>; diff --git
> > > > a/arch/arm/boot/dts/aspeed-g6.dtsi
> > > > b/arch/arm/boot/dts/aspeed-g6.dtsi
> > > > index 1b47be1704f8..0d1aae6887cd 100644
> > > > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > > > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > > > @@ -490,7 +490,6 @@
> > > >                         lpc: lpc at 1e789000 {
> > > >                                 compatible =
> > "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
> > > >                                 reg = <0x1e789000 0x1000>;
> > > > -                               reg-io-width = <4>;
> > > >
> > > >                                 #address-cells = <1>;
> > > >                                 #size-cells = <1>;
> > > > --
> > > > 2.17.1
> > > >

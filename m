From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Fri, 20 May 2022 02:29:11 +0000
Subject: [PATCH v4 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
In-Reply-To: <CACPK8Xev-AYtrWzZyMGj8eBkTP2YXjnX=M+4UUGgfRZYeGMPtA@mail.gmail.com>
References: <SG2PR06MB23155E8A6193118544A7DBF3E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
 <CACPK8Xev-AYtrWzZyMGj8eBkTP2YXjnX=M+4UUGgfRZYeGMPtA@mail.gmail.com>
Message-ID: <SG2PR06MB2315E86259B3751AE8C47E39E6D39@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On Tue, 29 Mar 2022 at 03:24, Howard Chiu <howard_chiu@aspeedtech.com>
> wrote:
> >
> > Enable Aspeed VHub for HID emulation
> >
> > Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > index 158b88f38d2c..b98cdad86e90 100644
> > --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > @@ -314,6 +314,11 @@ &sdhci1 {
> >         clk-phase-sd-hs = <7>, <200>;
> >  };
> >
> > +&vhub {
> > +       status = "okay";
> > +       pinctrl-names = "default";
> > +};
> 
> When booting with this patch applied we see:
> 
> [    1.596377] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: pin A4
> already requested by 1e6a1000.usb; cannot claim for 1e6a0000.usb-vhub
> [    1.596678] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: pin-252
> (1e6a0000.usb-vhub) status -22
> [    1.596947] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: could not
> request pin 252 (A4) from group USBA  on device aspeed-g6-pinctrl
> [    1.597238] aspeed_vhub 1e6a0000.usb-vhub: Error applying setting,
> reverse things back
> 
The ehci0 should be disabled, I will remove it.
And I also find there is a duplicated ehci1 node in .dts, I will remove one of them too.
> 
> > +
> >  &video {
> >         status = "okay";
> >         memory-region = <&video_engine_memory>;
> > --
> > 2.25.1
> >


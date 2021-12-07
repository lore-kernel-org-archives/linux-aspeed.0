From: Howard Chiu (邱冠睿) <Howard.Chiu@quantatw.com>
Date: Tue, 7 Dec 2021 06:34:06 +0000
Subject: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <CACPK8Xd93Kmvh7kT+4tbMO0+6LWa-2ORmt_KNB_hpqMYhso46A@mail.gmail.com>
References: <20211201033738.121846-1-howard.chiu@quantatw.com>
 <Ya5/v+VhOM9o9BtQ@heinlein>
 <CACPK8XdCjqB+HZ_g9O=gjnSne3=iV44i6jKP5M8yWcsjnttaog@mail.gmail.com>
 <HKAPR04MB40033D58E2C1F96DDF16C13C966E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
 <CACPK8Xd93Kmvh7kT+4tbMO0+6LWa-2ORmt_KNB_hpqMYhso46A@mail.gmail.com>
Message-ID: <HKAPR04MB4003DBD7D21B59723CDC5718966E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel

> I'd suggest no, omit those features for now, and you can add them in
> once we have a driver. The device tree bindings for the tach/pwm need
> some work before they can be approved.

The driver you mentioned is for OpenBMC Linux or upstream?
If it is for OpenBMC, the upstream robot will reject my DTS because the aspeed-g6.dtsi did not contain pwm/tach node.

If it is for upstream, it will be a long time that OpenBMC Linux won't have tach driver for ast2600 series, and my patch to commit with Billy's early driver for OpenBMC Linux is also meaningless.

> When I asked you to fix the patch, I was referring to the usb-c
> warnings that I posted about the other week.
I will fix it and others you mentioned in the v7 patch.

Howard

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Tuesday, December 7, 2021 11:30 AM
> To: Howard Chiu (???) <Howard.Chiu@quantatw.com>
> Cc: Patrick Williams <patrick@stwcx.xyz>; Howard Chiu
> <howard10703049@gmail.com>; Arnd Bergmann <arnd@arndb.de>; Olof
> Johansson <olof@lixom.net>; SoC Team <soc@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Andrew Jeffery <andrew@aj.id.au>; Linux ARM
> <linux-arm-kernel@lists.infradead.org>; devicetree
> <devicetree@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-aspeed <linux-aspeed@lists.ozlabs.org>
> Subject: Re: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
> 
> On Tue, 7 Dec 2021 at 02:53, Howard Chiu (???)
> <Howard.Chiu@quantatw.com> wrote:
> >
> > Hi Joel
> >
> > Bletchley platform needs to support fan control.
> > Since Billy's patch for upstream is still under review, I can't add pwm/tach
> node into dts or the build would fail.
> >
> > As you know, I had committed the pwm/tach driver for ast26xx to OpenBMC
> linux, could I commit the dts to OpenBMC linux instead of upstream for early
> build?
> 
> I'd suggest no, omit those features for now, and you can add them in
> once we have a driver. The device tree bindings for the tach/pwm need
> some work before they can be approved.
> 
> When I asked you to fix the patch, I was referring to the usb-c
> warnings that I posted about the other week.
> 
> >
> > Howard
> >
> > > -----Original Message-----
> > > From: Joel Stanley <joel@jms.id.au>
> > > Sent: Tuesday, December 7, 2021 6:52 AM
> > > To: Patrick Williams <patrick@stwcx.xyz>
> > > Cc: Howard Chiu <howard10703049@gmail.com>; Arnd Bergmann
> > > <arnd@arndb.de>; Olof Johansson <olof@lixom.net>; SoC Team
> > > <soc@kernel.org>; Rob Herring <robh+dt@kernel.org>; Andrew Jeffery
> > > <andrew@aj.id.au>; Linux ARM <linux-arm-kernel@lists.infradead.org>;
> > > devicetree <devicetree@vger.kernel.org>; Linux Kernel Mailing List
> > > <linux-kernel@vger.kernel.org>; linux-aspeed
> <linux-aspeed@lists.ozlabs.org>;
> > > Howard Chiu (???) <Howard.Chiu@quantatw.com>
> > > Subject: Re: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
> > >
> > > On Mon, 6 Dec 2021 at 21:25, Patrick Williams <patrick@stwcx.xyz> wrote:
> > > >
> > > > On Wed, Dec 01, 2021 at 11:37:38AM +0800, Howard Chiu wrote:
> > > > > Initial introduction of Facebook Bletchley equipped with
> > > > > Aspeed 2600 BMC SoC.
> > > > >
> > > > > Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
> > > > >
> > > >
> > > > ...
> > > >
> > > > > Change since v2:
> > > > > - Remove uart5 workaround
> > > > > - Remove gpio nodes of pca9552/pca9539
> > > > > - Modify gpio-line-name of led/power/presence pins with openbmc
> > > pattern
> > > >
> > > > A number of the GPIOs do not have defined openbmc patterns for them
> yet.
> > > The
> > > > names you have chosen are ok for now, but we will be changing them as
> we
> > > refine
> > > > development of this machine further.
> > > >
> > > > > +             gpio-line-names =
> > > > > +
> > >
> "SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLE
> > > D0_P12V_STBY_ALERT",
> > > > > +
> > >
> "SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB
> > > 302_INT",
> > > > > +
> > >
> "SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","
> > > SLED0_MD_DECAY",
> > > > > +
> > >
> "SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-ho
> > > st0";
> > > >
> > > > Such as these...
> > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > Otherwise,
> > > >
> > > > Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
> > >
> > > Thanks for reviewing.
> > >
> > > Howard, I'm merging patches for v5.17 but I can't apply this until you
> > > fix the warnings I mentioned.
> > >
> > > Cheers,
> > >
> > > Jeol
> > > >
> > > > --
> > > > Patrick Williams

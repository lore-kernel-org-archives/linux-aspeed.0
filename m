From: karthikeyan P <pkarthikeyan1509@gmail.com>
Date: Tue, 13 Sep 2022 15:34:55 +0530
Subject: [PATCH v2] ARM: dts: aspeed: yosemit V2: Update for Facebook
 Yosemite V2 BMC
In-Reply-To: <Yx+zYP5qTuDrjP10@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220907125035.GA28461@hcl-ThinkPad-T495> <Yx+zYP5qTuDrjP10@heinlein.stwcx.org.github.beta.tailscale.net>
Message-ID: <CA+ezb7iEFDPPv0MAv78U8j6wSy9AqExTTE=wK2rojm9Qyv4W9Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Done.

On Tue, Sep 13, 2022 at 4:02 AM Patrick Williams <patrick@stwcx.xyz> wrote:

> On Wed, Sep 07, 2022 at 06:20:35PM +0530, Karthikeyan Pasupathi wrote:
>
> Please improve the title and commit message here.  "Update" is
> insufficient for a title.  There is no description of _why_ in the commit
> message.
>
> > Removed NIC EEPROM driver IPMB-12 channel and keeping it as
> > "status ok".
> >
> > ---
> > --- v2- Updated the title
> > ---
> >
> > ---
> > --- v1- Initial draft
> > ---
> >
> > Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > index 8864e9c312a8..2293f10e94d6 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > @@ -207,12 +207,6 @@
> >
> >  &i2c12 {
> >       status = "okay";
> > -     //MEZZ_FRU
> > -     eeprom at 51 {
> > -             compatible = "atmel,24c64";
> > -             reg = <0x51>;
> > -             pagesize = <32>;
> > -     };
> >  };
> >
> >  &pwm_tacho {
> > --
> > 2.17.1
> >
>
> --
> Patrick Williams
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220913/df460adc/attachment.htm>

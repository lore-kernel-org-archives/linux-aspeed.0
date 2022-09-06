From: karthikeyan P <pkarthikeyan1509@gmail.com>
Date: Tue, 6 Sep 2022 13:01:28 +0530
Subject: [PATCH v1] Update for Facebook yosemite V2 BMC.
In-Reply-To: <YxboXspF+0Y/+spD@taoren-fedora-PC23YAB4>
References: <20220906050702.GA10565@hcl-ThinkPad-T495> <YxboXspF+0Y/+spD@taoren-fedora-PC23YAB4>
Message-ID: <CA+ezb7hdon3duH_oOLdGJGv_6HxCqa=HB6Tu0stbSuj2tMaSeQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Noted.

On Tue, Sep 6, 2022 at 11:57 AM Tao Ren <rentao.bupt@gmail.com> wrote:

> Hi Karthikeyan,
>
> I don't have much experience with ipmb-dev, but I'd suggest updating the
> patch tile so it's consistent with other dts patches. For example:
>
> "ARM: dts: aspeed: yosemitev2: Enable i2c13 controller"
>
>
> Cheers,
>
> - Tao
>
> On Tue, Sep 06, 2022 at 10:37:02AM +0530, Karthikeyan Pasupathi wrote:
> > Added IPMB-13 channel for Debug Card communication.
> >
> > ---
> > --- v1 - Initial draft.
> > ---
> >
> > Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > index 8864e9c312a8..84236df522dc 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > @@ -215,6 +215,17 @@
> >       };
> >  };
> >
> > +&i2c13 {
> > +     status = "okay";
> > +     // Debug Card
> > +     multi-master;
> > +     ipmb13 at 10 {
> > +             compatible = "ipmb-dev";
> > +             reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> > +             i2c-protocol;
> > +     };
> > +};
> > +
> >  &pwm_tacho {
> >       status = "okay";
> >       //FSC
> > --
> > 2.17.1
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220906/50588086/attachment.htm>

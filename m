From: karthikeyan P <pkarthikeyan1509@gmail.com>
Date: Mon, 26 Sep 2022 17:13:09 +0530
Subject: [PATCH v4] ARM: dts: aspeed: yosemit V2: Enable OCP debug card
In-Reply-To: <Yy4qofFUIxudLxbS@heinlein>
References: <20220921064309.GA18932@hcl-ThinkPad-T495> <Yy4qofFUIxudLxbS@heinlein>
Message-ID: <CA+ezb7jrp3Fo0gGvXib4MgivWSx7V23Wjc-4EJJ2EQXscmYDRg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Will do, thanks!

On Sat, Sep 24, 2022 at 3:22 AM Patrick Williams <patrick@stwcx.xyz> wrote:

>
> > Subject: [PATCH v4] ARM: dts: aspeed: yosemit V2: Enable OCP debug card
>
> Please double-check your spelling of commit messages.  You've misspelled
> "yosemite" here, which gives an impression that it is quite likely that
> other things are wrong with your commit.
>
> On Wed, Sep 21, 2022 at 12:13:09PM +0530, Karthikeyan Pasupathi wrote:
> > Added IPMB-13 channel for Debug Card communication.
> > which improve the readability of the machine and makes
> > easier to debug the server.  and it will display the some
> > informations about the server like "system info",
> > "Critical sensors" and "critical sel".
> >
> > ---
> > --- v4- Resolved syntax error
> > --- v3- Updated the title and commit
> > --- v2- Updated the title
> > --- v1- Initial draft
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
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
>
> --
> Patrick Williams
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220926/c78a348a/attachment.htm>

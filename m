From: Joel Stanley <joel@jms.id.au>
Date: Mon, 6 Dec 2021 22:51:46 +0000
Subject: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <Ya5/v+VhOM9o9BtQ@heinlein>
References: <20211201033738.121846-1-howard.chiu@quantatw.com>
 <Ya5/v+VhOM9o9BtQ@heinlein>
Message-ID: <CACPK8XdCjqB+HZ_g9O=gjnSne3=iV44i6jKP5M8yWcsjnttaog@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 6 Dec 2021 at 21:25, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> On Wed, Dec 01, 2021 at 11:37:38AM +0800, Howard Chiu wrote:
> > Initial introduction of Facebook Bletchley equipped with
> > Aspeed 2600 BMC SoC.
> >
> > Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
> >
>
> ...
>
> > Change since v2:
> > - Remove uart5 workaround
> > - Remove gpio nodes of pca9552/pca9539
> > - Modify gpio-line-name of led/power/presence pins with openbmc pattern
>
> A number of the GPIOs do not have defined openbmc patterns for them yet.  The
> names you have chosen are ok for now, but we will be changing them as we refine
> development of this machine further.
>
> > +             gpio-line-names =
> > +             "SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
> > +             "SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB302_INT",
> > +             "SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
> > +             "SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-host0";
>
> Such as these...
>
> > --
> > 2.25.1
> >
>
> Otherwise,
>
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

Thanks for reviewing.

Howard, I'm merging patches for v5.17 but I can't apply this until you
fix the warnings I mentioned.

Cheers,

Jeol
>
> --
> Patrick Williams

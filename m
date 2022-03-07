From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 7 Mar 2022 14:16:06 +0100
Subject: [PATCH v6 8/9] misc: smpro-misc: Add Ampere's Altra SMpro misc
 driver
In-Reply-To: <51603aa7-4113-dba4-9a38-0a6683a1d249@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-9-quan@os.amperecomputing.com>
 <51603aa7-4113-dba4-9a38-0a6683a1d249@os.amperecomputing.com>
Message-ID: <CAK8P3a1Fw5cdxtr3LeG=tNbrTRbseXP+fDzfr-2B+LqbShA99w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 7, 2022 at 9:32 AM Quan Nguyen <quan@os.amperecomputing.com> wrote:
> > diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
> > index a7cd64bf9eaa..5611dd30f8f4 100644
> > --- a/drivers/mfd/smpro-mfd.c
> > +++ b/drivers/mfd/smpro-mfd.c
> > @@ -28,6 +28,7 @@ static const struct regmap_config simple_word_regmap_config = {
> >   static const struct mfd_cell smpro_devs[] = {
> >       MFD_CELL_NAME("smpro-hwmon"),
> >       MFD_CELL_NAME("smpro-errmon"),
> > +     MFD_CELL_NAME("smpro-misc"),
>
> [Lee Jones]
> Misc is a Linuxisum which are not allowed in DT.
>
> What does this driver actually do?
>
> [Quan]
> This drivers is to report the boot progress to BMC and allow BMC to
> configure the Soc Power Limit of Ampere's Altra family processor.

That doesn't sound like it should be platform specific at all, but rather
a generic BMC interface. I see you already have the openbmc list on Cc,
so I assume the right people can see this. Presumably this is a BMC that
already runs on openbmc and can have a platform-independent interface
for doing this.

        Arnd

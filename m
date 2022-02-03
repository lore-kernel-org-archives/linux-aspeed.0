From: Joel Stanley <joel@jms.id.au>
Date: Thu, 3 Feb 2022 11:39:38 +0000
Subject: [PATCH 2/2] ARM: aspeed: Add secure boot controller support
In-Reply-To: <YfjyNo5wBPs16vkz@kroah.com>
References: <20220201050501.182961-1-joel@jms.id.au>
 <20220201050501.182961-3-joel@jms.id.au>
 <YfjyNo5wBPs16vkz@kroah.com>
Message-ID: <CACPK8XcYFZUtw_-8A5hzT0dYqtnifuFOf7qoER0YVsbCsReH8A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 1 Feb 2022 at 08:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 01, 2022 at 03:35:01PM +1030, Joel Stanley wrote:

> > --- a/drivers/soc/aspeed/aspeed-socinfo.c
> > +++ b/drivers/soc/aspeed/aspeed-socinfo.c
> > @@ -8,6 +8,9 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/sys_soc.h>
> > +#include <linux/firmware_bootinfo.h>
> > +
> > +static u32 security_status;
> >
> >  static struct {
> >       const char *name;
> > @@ -74,6 +77,83 @@ static const char *siliconid_to_rev(u32 siliconid)
> >       return "??";
> >  }
> >
> > +#define SEC_STATUS           0x14
> > +#define ABR_IMAGE_SOURCE     BIT(13)
> > +#define OTP_PROTECTED                BIT(8)
> > +#define LOW_SEC_KEY          BIT(7)
> > +#define SECURE_BOOT          BIT(6)
> > +#define UART_BOOT            BIT(5)
>
> Where do these bits come from?

They are taken from the datasheet.

> > +     pr_info("AST2600 secure boot %s\n",
> > +             (security_status & SECURE_BOOT) ? "enabled" : "disabled");
>
> When all is good, no need to print anything out.

We had some back and forth on this in an earlier iteration of this change:

 https://lore.kernel.org/all/57584776-06e7-0faf-aeb2-eab0c7c5ae1f at molgen.mpg.de/

It boils down to what is "good"? The system is fine if it is not
provisioned with secure boot keys, if that's the intent of the system
builder.

A similar thing is done for efi secure boot, where it prints out
whether it's enabled, disabled or unable to determine.

I'll send out a v2 that takes on the suggestions you made in the cover letter.

Cheers,

Joel

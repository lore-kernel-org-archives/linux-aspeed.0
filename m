From: Joel Stanley <joel@jms.id.au>
Date: Fri, 4 Feb 2022 05:53:18 +0000
Subject: [PATCH v2 1/3] firmware: Add boot information to sysfs
In-Reply-To: <f44d2e01-b6cb-5f22-f651-f4dd7ced166f@arm.com>
References: <20220203115344.267159-1-joel@jms.id.au>
 <20220203115344.267159-2-joel@jms.id.au>
 <f44d2e01-b6cb-5f22-f651-f4dd7ced166f@arm.com>
Message-ID: <CACPK8Xed3AESz2JjqJa2v=6ipXDBBMd=CxmiwruJS5cBEE+Qfg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 3 Feb 2022 at 14:23, Robin Murphy <robin.murphy@arm.com> wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-firmware-bootinfo b/Documentation/ABI/testing/sysfs-firmware-bootinfo
> > new file mode 100644
> > index 000000000000..cd6c42316345
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-firmware-bootinfo
> > @@ -0,0 +1,43 @@
> > +What:                /sys/firmware/bootinfo/*
> > +Date:                Jan 2022
> > +Description:
> > +             A system can expose information about how it was started in
> > +             this directory.
> > +
> > +             This information is agnostic as to the firmware implementation.
> > +
> > +             A system may expose a subset of these properties as applicable.
> > +
> > +
> > +What:                /sys/firmware/bootinfo/secure_boot
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system was started with secure boot enabled in
> > +             the firmware.
> > +
> > +
> > +What:                /sys/firmware/bootinfo/abr_image
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system was started from the alternate image
> > +             loaded from an Alternate Boot Region. Often this is a result of
> > +             the primary firmware image failing to start the system.
> > +
> > +
> > +What:                /sys/firmware/bootinfo/low_security_key
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system's secure boot was verified with a low
> > +             security or development key.
> > +
> > +What:                /sys/firmware/bootinfo/otp_protected
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system's boot configuration region is write
> > +             protected and cannot be modified.
> > +
> > +What:                /sys/firmware/bootinfo/uart_boot
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system firmware was loaded from a UART instead of
> > +             an internal boot device.
>
> I'd be concerned about how well details like "uart_boot" and "abr_image"
> scale beyond one SoC family from one vendor. The combinatorial explosion
> of possible boot configurations across Linux-capable SoCs and firmware
> in general is larger than I'd care to imagine, even before considering
> that the nuances don't necessarily stop there - e.g. whether a given
> storage interface is hard-wired or user-accessible is not a fixed
> property on many SoCs, and even a socketed SD card might be "trusted" if
> a board is deployed in a product with a sealed enclosure.

This is a fair point. The first iteration of this idea was specific to
the aspeed soc.

For the system I'm building, secure_boot and otp_locked tell our
manufacturing test process that the machine has been correctly
provisioned. I'd like to get something agreed upon so we can start
using those sysfs files in the testing without having to go back and
change things.

abr_image is an indication that something went wrong at boot time. I
thought this was a standard eMMC concept, but taking a closer look
it's specific to the aspeed soc.

Would it help if we gave them generic names?

 - abr_image -> alternate_boot

I welcome other suggestions.

I'll drop the uart_boot property for now.

Cheers,

Joel

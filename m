From: Joel Stanley <joel@jms.id.au>
Date: Wed, 9 Mar 2022 22:40:41 +0000
Subject: [PATCH] ARM: soc: aspeed: Add secure boot controller support
In-Reply-To: <92c2301f-5759-c13c-84f6-52ec69af7de6@kaod.org>
References: <20220304030336.1017197-1-joel@jms.id.au>
 <92c2301f-5759-c13c-84f6-52ec69af7de6@kaod.org>
Message-ID: <CACPK8Xc+_hPU2wT10g6r2pKssTOdMB-xuCN7uL30rzNCLWWjEg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 9 Mar 2022 at 15:53, C?dric Le Goater <clg@kaod.org> wrote:
> > +#define SEC_STATUS           0x14
> > +#define ABR_IMAGE_SOURCE     BIT(13)
> > +#define OTP_PROTECTED                BIT(8)
> > +#define LOW_SEC_KEY          BIT(7)
> > +#define SECURE_BOOT          BIT(6)
> > +#define UART_BOOT            BIT(5)
>
> Why not put these definitions under a common header file ?

They are the register definitions. I don't think there will be any
users outside of this driver.

>
> > +struct sbe {> +      u8 abr_image;
> > +     u8 low_security_key;
> > +     u8 otp_protected;
> > +     u8 secure_boot;
> > +     u8 invert;
> > +     u8 uart_boot;
>
>  From what the code does below, these could be of type 'bool'

I made them boot initially, but debugfs_create_u8 gets unhappy about
taking a bool.

We could use debugfs_create_bool, but then the files return Y/N which
I didn't like.

> > +     sbe.abr_image = !!(security_status & ABR_IMAGE_SOURCE);
> > +     sbe.low_security_key = !!(security_status & LOW_SEC_KEY);
> > +     sbe.otp_protected = !!(security_status & OTP_PROTECTED);
> > +     sbe.secure_boot = !!(security_status & SECURE_BOOT);
> > +     /* Invert the bit, as 1 is boot from SPI/eMMC */
> > +     sbe.uart_boot =  !(security_status & UART_BOOT);
> > +
> > +     debugfs_root = debugfs_create_dir("aspeed", NULL);
>
> may be use 'arch_debugfs_dir' or is that the same ? and test the returned
> value as it can fail.
>
> Also, instead of 'debugfs_root', we could introduce an extern
> 'aspeed_debugfs_dir' for other aspeed drivers. For instance, the spi-mem
> driver for flash devices could expose some internal settings like the
> direct mapping ranges for each flash device. I am sure other drivers
> would use it.

Okay. I was hesitant to export it before we had other users, but given
you already have some in mind I'll do that.

The hard bit is where to put it.

We have arch_debugfs_dir in include/linux/debugfs.h. This is used by
ppc, x86, s390 and sh, but arm doesn't populate it. Neither do any of
the arm socs.

We could initalise that to the machine name. This means we don't need
to add the soc-specific names into the driver. OTOH, "arch" is "arm"
not "aspeed".

I like the idea.

>
> > +     debugfs_create_u8("abr_image", 0444, debugfs_root, &sbe.abr_image);
> > +     debugfs_create_u8("low_security_key", 0444, debugfs_root, &sbe.low_security_key);
> > +     debugfs_create_u8("otp_protected", 0444, debugfs_root, &sbe.otp_protected);
> > +     debugfs_create_u8("uart_boot", 0444, debugfs_root, &sbe.uart_boot);
> > +     debugfs_create_u8("secure_boot", 0444, debugfs_root, &sbe.secure_boot);
>
> It would be cleaner if these files were under a 'sbe' or 'sbc' directory.

Ok.

Thanks for the review.

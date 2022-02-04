From: Joel Stanley <joel@jms.id.au>
Date: Fri, 4 Feb 2022 06:55:26 +0000
Subject: [PATCH v2 1/3] firmware: Add boot information to sysfs
In-Reply-To: <YfvONCxvTTuWqI+J@kroah.com>
References: <20220203115344.267159-1-joel@jms.id.au>
 <20220203115344.267159-2-joel@jms.id.au>
 <YfvONCxvTTuWqI+J@kroah.com>
Message-ID: <CACPK8Xf-gEkMUxB=numzbzQyM7f+YioUcocDP9=6T4VaF822sg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 3 Feb 2022 at 12:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 03, 2022 at 10:23:42PM +1030, Joel Stanley wrote:

> > diff --git a/include/linux/firmware_bootinfo.h b/include/linux/firmware_bootinfo.h
> > new file mode 100644
> > index 000000000000..3fe630b061b9
> > --- /dev/null
> > +++ b/include/linux/firmware_bootinfo.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>
> I have to ask, do you really mean "or later"?

Yeah. That's what we're told we should use.

> > +/* Copyright 2022 IBM Corp. */
> > +
> > +#include <linux/sysfs.h>
> > +#include <linux/init.h>
> > +
> > +#define BOOTINFO_SET(b, n, v) b.n.en = true; b.n.val = v
>
> Please use a while {} loop around these two statements.
>
> Didn't checkpatch warn you about that?

No, it didn't. I'll add it.

>
> > +struct bootinfo_entry {
> > +     bool en;
>
> What does "en" mean?  "enabled"?  If so, please spell it out.
>
> > +     bool val;
>
> How can a "value" have a boolean?  Is this "valid"?  Again, please spell
> it out, we have no lack of letters to use here to keep people from being
> confused.

I meant value. I think it's reasonable for a value to be true or
false. I'll make the names clearer with docs as you suggest.

>
> Can you please use kernel-doc comments to describe this structure?
>
>
> > +};
> > +
> > +struct bootinfo {
> > +     struct bootinfo_entry abr_image;
> > +     struct bootinfo_entry low_security_key;
> > +     struct bootinfo_entry otp_protected;
> > +     struct bootinfo_entry secure_boot;
> > +     struct bootinfo_entry uart_boot;
> > +};
>
> Same here, please use kernel-doc
>
> > +
> > +int __init firmware_bootinfo_init(struct bootinfo *bootinfo_init);
>
> __init is not needed on a function definition like this.

ack.

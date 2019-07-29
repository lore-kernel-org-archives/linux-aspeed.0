From: Oskar Senft <osk@google.com>
Date: Sun, 28 Jul 2019 21:14:36 -0400
Subject: [PATCH] drivers/tty/serial/8250: Make Aspeed VUART SIRQ polarity
 configurable
In-Reply-To: <6b31627a8c5a2616c83783550517961b7ed8f3cb.camel@ozlabs.org>
References: <20190727134242.49847-1-osk@google.com>
 <9fb8c99449cebd68fb5975890dedaa06ce7808ae.camel@kernel.crashing.org>
 <CABoTLcRPXffZuKy-DTFUVKJQRydSzMDynYRgBbZ_470iVN1KnA@mail.gmail.com>
 <CABoTLcTSFvQruPRnoRPgiWjOXNDOCSnAXVesG7f1WAuLLLVSSg@mail.gmail.com>
 <6b31627a8c5a2616c83783550517961b7ed8f3cb.camel@ozlabs.org>
Message-ID: <CABoTLcQF4_He15F5oO0Pxjdm6f7pLCxBF77cz7wR=jjWaednYQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy

In my understanding the SIRQ polarity should be the same for all UARTs on
the particular bus, i.e. both UARTs controlled by the SuperI/O and the
VUART or PUART (pass-through). However, the host controls the UARTs on the
SuperI/O itself. The VUART is covered by this code and we don't have a
PUART driver yet.

It might make sense to have this as a global setting which each driver
could read. But wouldn't this be an exercise for the future where we
actually have a second device? I don't think the Aspeed currently has any
other devices that could generate a SIRQ (except for the PUART for which
there's no driver).

Having said that, ideally I'd like the SIRQ polarity to be auto-configured
from the LPC/eSPI HW pin strap anyway. I have the code for that almost
done. Maybe we shouldn't even have the sysfs interface for it and I should
strip that out?

Thanks
Oskar.

On Sun, Jul 28, 2019 at 8:51 PM Jeremy Kerr <jk@ozlabs.org> wrote:

> Hi Oskar,
>
> > For LPC, the polarity should be set to 1, for eSPI the default of 0 is
> > correct.
>
> Would there ever be a case where different SIRQs need different
> polarities? If not, we may want this to be global, rather than for each
> device (the VUART being one...)
>
> Cheers,
>
>
> Jeremy
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190728/b73f494d/attachment.htm>

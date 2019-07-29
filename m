From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 29 Jul 2019 10:02:56 +0800
Subject: [PATCH] drivers/tty/serial/8250: Make Aspeed VUART SIRQ
 polarity configurable
In-Reply-To: <CABoTLcQF4_He15F5oO0Pxjdm6f7pLCxBF77cz7wR=jjWaednYQ@mail.gmail.com>
References: <20190727134242.49847-1-osk@google.com>
 <9fb8c99449cebd68fb5975890dedaa06ce7808ae.camel@kernel.crashing.org>
 <CABoTLcRPXffZuKy-DTFUVKJQRydSzMDynYRgBbZ_470iVN1KnA@mail.gmail.com>
 <CABoTLcTSFvQruPRnoRPgiWjOXNDOCSnAXVesG7f1WAuLLLVSSg@mail.gmail.com>
 <6b31627a8c5a2616c83783550517961b7ed8f3cb.camel@ozlabs.org>
 <CABoTLcQF4_He15F5oO0Pxjdm6f7pLCxBF77cz7wR=jjWaednYQ@mail.gmail.com>
Message-ID: <9855284dfa4c4d4a52441553691c7b4b08a9cc34.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Oskar,

> In my understanding the SIRQ polarity should be the same for all UARTs
> on the particular bus, i.e. both UARTs controlled by the SuperI/O and
> the VUART or PUART (pass-through). However, the host controls the
> UARTs on the SuperI/O itself.

Somewhat offtopic, but are you sure you want to enable the SuperIO
device?

>  The VUART is covered by this code and we don't have a PUART driver
> yet.
> 
> It might make sense to have this as a global setting which each driver
> could read. But wouldn't this be an exercise for the future where we
> actually have a second device? I don't think the Aspeed currently has
> any other devices that could generate a SIRQ (except for the PUART for
> which there's no driver).

We have a bunch of SIRQ sources that we use (on OpenPOWER platforms) -
the BT interface, the KCS interface, the UARTs, and the mbox hardware.
It's not just the VUART/PUART :)

> Having said that, ideally I'd like the SIRQ polarity to be auto-
> configured from the LPC/eSPI HW pin strap anyway. I have the code for
> that almost done. Maybe we shouldn't even have the sysfs interface for
> it and I should strip that out?

Yeah, I think I agree with that. The only downside is that the 
individual drivers will now need to poke at the SCU to query the
LPC/eSPI configuration. If you can find a nice way to do that, then that
sounds like the best approach. Can you query it through the parent bus
perhaps?

Cheers,


Jeremy


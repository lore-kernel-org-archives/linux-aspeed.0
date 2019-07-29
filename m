From: Oskar Senft <osk@google.com>
Date: Sun, 28 Jul 2019 22:21:21 -0400
Subject: [PATCH] drivers/tty/serial/8250: Make Aspeed VUART SIRQ polarity
 configurable
In-Reply-To: <9855284dfa4c4d4a52441553691c7b4b08a9cc34.camel@ozlabs.org>
References: <20190727134242.49847-1-osk@google.com>
 <9fb8c99449cebd68fb5975890dedaa06ce7808ae.camel@kernel.crashing.org>
 <CABoTLcRPXffZuKy-DTFUVKJQRydSzMDynYRgBbZ_470iVN1KnA@mail.gmail.com>
 <CABoTLcTSFvQruPRnoRPgiWjOXNDOCSnAXVesG7f1WAuLLLVSSg@mail.gmail.com>
 <6b31627a8c5a2616c83783550517961b7ed8f3cb.camel@ozlabs.org>
 <CABoTLcQF4_He15F5oO0Pxjdm6f7pLCxBF77cz7wR=jjWaednYQ@mail.gmail.com>
 <9855284dfa4c4d4a52441553691c7b4b08a9cc34.camel@ozlabs.org>
Message-ID: <CABoTLcS2Pepyfc8A-gzm+Nh2T5yCCmexCC94K8Pm=4mtM4JHBA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy

Somewhat offtopic, but are you sure you want to enable the SuperIO
> device?
>
No :-D I'm aware of CVE-2019-6260. I just listed it as a potential source
of SIRQs.


> >  The VUART is covered by this code and we don't have a PUART driver
> > yet.
> >
> > It might make sense to have this as a global setting which each driver
> > could read. But wouldn't this be an exercise for the future where we
> > actually have a second device? I don't think the Aspeed currently has
> > any other devices that could generate a SIRQ (except for the PUART for
> > which there's no driver).
>
> We have a bunch of SIRQ sources that we use (on OpenPOWER platforms) -
> the BT interface, the KCS interface, the UARTs, and the mbox hardware.
> It's not just the VUART/PUART :)
>
Interesting. From what Aspeed explained, the SIRQ polarity for UARTs is
inverted to that for other devices. I haven't looked into how other devices
work, to be honest. Do we set the polarity there explicitly?


> > Having said that, ideally I'd like the SIRQ polarity to be auto-
> > configured from the LPC/eSPI HW pin strap anyway. I have the code for
> > that almost done. Maybe we shouldn't even have the sysfs interface for
> > it and I should strip that out?
>
> Yeah, I think I agree with that. The only downside is that the
> individual drivers will now need to poke at the SCU to query the
> LPC/eSPI configuration. If you can find a nice way to do that, then that
> sounds like the best approach. Can you query it through the parent bus
> perhaps?
>
I'm experimenting with this:
syscon_regmap_lookup_by_compatible("aspeed,ast2500-scu");

I'll need to think on how to make this work on both ast2400 and ast2500,
though. I actually need to have a look at the ast2400 data sheet wrt. VUART
registers, too!

The structure is this:
apb {
  syscon {
    ...
  }
  vuart {
    ...
  }
}

So the vuart is a sibling of syscon, which holds the registers. I guess
I'll have to go with "by_compatible"?

Oskar.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190728/9c5140c3/attachment.htm>

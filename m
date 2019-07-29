From: Oskar Senft <osk@google.com>
Date: Sun, 28 Jul 2019 22:23:11 -0400
Subject: [PATCH] drivers/tty/serial/8250: Make Aspeed VUART SIRQ polarity
 configurable
In-Reply-To: <cd7e4eacb7c6572e58ed5fdc2286082367520e9e.camel@kernel.crashing.org>
References: <20190727134242.49847-1-osk@google.com>
 <9fb8c99449cebd68fb5975890dedaa06ce7808ae.camel@kernel.crashing.org>
 <CABoTLcRPXffZuKy-DTFUVKJQRydSzMDynYRgBbZ_470iVN1KnA@mail.gmail.com>
 <CABoTLcTSFvQruPRnoRPgiWjOXNDOCSnAXVesG7f1WAuLLLVSSg@mail.gmail.com>
 <6b31627a8c5a2616c83783550517961b7ed8f3cb.camel@ozlabs.org>
 <cd7e4eacb7c6572e58ed5fdc2286082367520e9e.camel@kernel.crashing.org>
Message-ID: <CABoTLcRWKaNgzLa-26_MVg_tee+qyPhOG2bL4bqTh5DFXFAFbw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ok, so it sounds that a default value derived from HW strap for LPC/eSPI
(see discussion on how to access the registers correctly) + sysfs seems to
be ok?

Oskar.

On Sun, Jul 28, 2019 at 10:20 PM Benjamin Herrenschmidt <
benh@kernel.crashing.org> wrote:

> On Mon, 2019-07-29 at 08:51 +0800, Jeremy Kerr wrote:
> > Hi Oskar,
> >
> > > For LPC, the polarity should be set to 1, for eSPI the default of 0 is
> > > correct.
> >
> > Would there ever be a case where different SIRQs need different
> > polarities? If not, we may want this to be global, rather than for each
> > device (the VUART being one...)
>
> Leave it per device. The way to configure this is completely device
> dependent. In fact for most devices it can only be done by the host via
> SIO.
>
> Cheers,
> Ben.
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190728/f7c08438/attachment-0001.htm>

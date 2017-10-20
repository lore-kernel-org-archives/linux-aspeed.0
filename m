From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Oct 2017 19:32:53 +1030
Subject: [RFC PATCH 3/5] gpio: gpiolib: Add chardev support for
 maintaining GPIO values on reset
In-Reply-To: <CACRpkdY4F-ocFxomLEsVyGA0odGooWysQq5MHi9qwUt6E_VDzA@mail.gmail.com>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-4-andrew@aj.id.au>
 <CACRpkdY4F-ocFxomLEsVyGA0odGooWysQq5MHi9qwUt6E_VDzA@mail.gmail.com>
Message-ID: <1508490173.24322.53.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 2017-10-20 at 09:27 +0200, Linus Walleij wrote:
> I paged Bartosz and Michael on this, they are experts on the use cases for
> the character device and their opinions are likely more valuable than mine.
> 
> > On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > Similar to devicetree support, add flags and mappings to expose reset
> > tolerance configuration through the chardev interface.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> (...)
> 
> > +                * Unconditionally configure reset tolerance, as it's possible
> > +                * that the tolerance flag itself becomes tolerant to resets.
> > +                * Thus it could remain set from a previous environment, but
> > +                * the current environment may not expect it so.
> > +                */
> > +               ret = gpiod_set_reset_tolerant(desc,
> > +                               !!(lflags & GPIOHANDLE_REQUEST_RESET_TOLERANT));
> > +               if (ret < 0)
> > +                       goto out_free_descs;
> 
> First, as noted in the first patch, IMO we should just go for persistance,
> i.e. you want to flag to the system to keep the line persistent in any case,
> no matter if the system goes to sleep or resets.
> 
> So the usecase is going to be a control system or similar, a makerspace
> project, an industrial product of some kind, driving GPIO from userspace.
> 
> I don't see it as helpful to give userspace control over whether the line
> is persistent or not. It is more reasonable to assume persistance for
> userspace use cases, don't you think? Whether the system goes to sleep
> or the gpiochip resets should not make a door suddenly close or the
> lights in the christmas tree go out, right? I think if the gpiochip supports
> persistance of any kind, we should try to use it and not have userspace
> provide flags for that.

Right. I guess the counter argument to your examples is if the gpio is
controlling any active process that we don't want to continue if we've
lost the capacity to monitor some other inputs (some kind of dead-man's 
switch). But maybe the argument is that should be implemented in the
kernel anyway?

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20171020/1336ba91/attachment.sig>

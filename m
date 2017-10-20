From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Oct 2017 18:54:15 +1030
Subject: [RFC PATCH 1/5] gpio: gpiolib: Add core support for maintaining
 GPIO values on reset
In-Reply-To: <CACRpkda-7-uM5x4kbNXkx3F7F4VTZtTvXfys5VPFb1YiVDo1+g@mail.gmail.com>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-2-andrew@aj.id.au>
 <CACRpkda-7-uM5x4kbNXkx3F7F4VTZtTvXfys5VPFb1YiVDo1+g@mail.gmail.com>
Message-ID: <1508487855.24322.49.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 2017-10-20 at 09:17 +0200, Linus Walleij wrote:
> > On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > GPIO state reset tolerance is implemented in gpiolib through the
> > addition of a new pinconf parameter. With that, some renaming of helpers
> > is done to clarify the scope of the already existing
> > gpiochip_line_is_persistent(), as it's now ambiguous as to whether that
> > means on suspend, reset or both.
> 
> Isn't it most reasonable to say persistance covers both cases, reset
> and/or sleep? This seems a bit like overdefined.

I definitely had some internal debate about that. I erred on the side of
avoiding potential change in expectations for the arizona. If you consider that
overdefined then I'm happy to go the other way.

> 
> So can we say that is this flag is set, the hardware and driver should
> do its best to preserve the value across any system disruptions.
> 
> We can change the wording of course, patches welcome for that.

Yep.

> 
> But do we really need to distinguish the cases of disruption and
> whether we cover up for them or not?
> 
> I would say we can deal with that the day we have a system with
> two register bits (or similar) where you can select to preserve across
> sleep, reset, one or the other, AND there is also a usecase such that
> a user wants to preserve the value across reset but not suspend or
> vice versa.
> 
> I suspect that will not happen.

A very reasonable approach.

Cheers for the feedback.

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20171020/c21d9259/attachment.sig>

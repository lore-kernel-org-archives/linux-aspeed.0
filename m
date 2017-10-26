From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 26 Oct 2017 10:30:36 +1030
Subject: [RFC PATCH 1/5] gpio: gpiolib: Add core support for maintaining
 GPIO values on reset
In-Reply-To: <20171025081141.uczvbfstmt3jcisw@localhost.localdomain>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-2-andrew@aj.id.au>
 <CACRpkda-7-uM5x4kbNXkx3F7F4VTZtTvXfys5VPFb1YiVDo1+g@mail.gmail.com>
 <CACRpkdaW5jMEh_OR2oiy_Bc-6Cb+GM1Uap+1u2T2hw85CwBh3g@mail.gmail.com>
 <1508488347.24322.51.camel@aj.id.au>
 <20171025081141.uczvbfstmt3jcisw@localhost.localdomain>
Message-ID: <1508976036.13477.3.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2017-10-25 at 09:11 +0100, Charles Keepax wrote:
> On Fri, Oct 20, 2017 at 07:02:27PM +1030, Andrew Jeffery wrote:
> > On Fri, 2017-10-20 at 09:43 +0200, Linus Walleij wrote:
> > > On Fri, Oct 20, 2017 at 9:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > > > On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > > GPIO state reset tolerance is implemented in gpiolib through the
> > > > > addition of a new pinconf parameter. With that, some renaming of helpers
> > > > > is done to clarify the scope of the already existing
> > > > > gpiochip_line_is_persistent(), as it's now ambiguous as to whether that
> > > > > means on suspend, reset or both.
> > > > 
> > > > Isn't it most reasonable to say persistance covers both cases, reset
> > > > and/or sleep? This seems a bit like overdefined.
> 
> Seems reasonable to me to just expand the existing stuff to cover
> reset as well, I don't think that should cause any issues for the
> Arizona stuff.

Great. I addressed this in the non-RFC series.

Thanks for the feedback.

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20171026/a70bfd17/attachment-0001.sig>

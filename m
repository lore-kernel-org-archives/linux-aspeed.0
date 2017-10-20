From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Oct 2017 17:59:35 +1030
Subject: [RFC PATCH 2/5] gpio: gpiolib: Add OF support for maintaining
 GPIO values on reset
In-Reply-To: <CACRpkdbxOen3ohwmDc8ZNWkirn3mNHaGiZq1O-6VnOjhvFcw+w@mail.gmail.com>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-3-andrew@aj.id.au>
 <CACRpkdbxOen3ohwmDc8ZNWkirn3mNHaGiZq1O-6VnOjhvFcw+w@mail.gmail.com>
Message-ID: <1508484575.24322.43.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 2017-10-20 at 09:18 +0200, Linus Walleij wrote:
> On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au>
> wrote:
> 
> > @@ -32,6 +32,7 @@ enum of_gpio_flags {
> >         OF_GPIO_SINGLE_ENDED = 0x2,
> >         OF_GPIO_OPEN_DRAIN = 0x4,
> >         OF_GPIO_SLEEP_MAY_LOSE_VALUE = 0x8,
> > +       OF_GPIO_RESET_TOLERANT = 0x16,
> 
> Now you're mixing up decimal and hex.

Ugh. Whoops.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20171020/ea6499f4/attachment.sig>

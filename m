From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Aug 2021 09:54:53 +0930
Subject: [RFC PATCH 1/6] pinctrl: Add pinctrl_gpio_as_pin()
In-Reply-To: <CACRpkdZ4A3Lw2U+_jXfbuXJFhpesi3SzNN1Codqxi4sLNu5zPw@mail.gmail.com>
References: <20210723075858.376378-1-andrew@aj.id.au>
 <20210723075858.376378-2-andrew@aj.id.au>
 <CACRpkdZ4A3Lw2U+_jXfbuXJFhpesi3SzNN1Codqxi4sLNu5zPw@mail.gmail.com>
Message-ID: <53199b3e-a711-4071-96a3-7836d3323906@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 10 Aug 2021, at 23:04, Linus Walleij wrote:
> On Fri, Jul 23, 2021 at 9:59 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > Allow gpiochips to map the GPIO numberspace onto a pin numberspace when
> > the register layout for GPIO control is implemented in terms of the
> > pin numberspace.
> >
> > This requirement sounds kind of strange, but the patch is driven by
> > trying to resolve a bug in the leds-pca955x driver where this mapping is
> > not correctly performed.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> (...)
> 
> Hm  this looks a bit strange...
> 
> > +int pinctrl_gpio_as_pin(struct pinctrl_dev *pctldev, unsigned int gpio)
> 
> This is not a good name for this function. Try to come up with
> a name that says exactly what the function does.
> 
> E.g. "apple pear as apple slice" isn't very helpful, the use case for
> this is really hard to understand.

That's probably because I shouldn't be trying to do what I'm doing :)

I'll stop doing that (i.e. rework patch 4/6) and this will go away entirely.

> 
> > +EXPORT_SYMBOL_GPL(pinctrl_find_gpio_range_from_pin);
> 
> This looks completely wrong.

Yeah, whoops. That was an oversight while iterating on the patch.

Andrew

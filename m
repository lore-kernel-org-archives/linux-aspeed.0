From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Oct 2017 09:17:15 +0200
Subject: [RFC PATCH 1/5] gpio: gpiolib: Add core support for maintaining
 GPIO values on reset
In-Reply-To: <20171020033727.21557-2-andrew@aj.id.au>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-2-andrew@aj.id.au>
Message-ID: <CACRpkda-7-uM5x4kbNXkx3F7F4VTZtTvXfys5VPFb1YiVDo1+g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> GPIO state reset tolerance is implemented in gpiolib through the
> addition of a new pinconf parameter. With that, some renaming of helpers
> is done to clarify the scope of the already existing
> gpiochip_line_is_persistent(), as it's now ambiguous as to whether that
> means on suspend, reset or both.

Isn't it most reasonable to say persistance covers both cases, reset
and/or sleep? This seems a bit like overdefined.

So can we say that is this flag is set, the hardware and driver should
do its best to preserve the value across any system disruptions.

We can change the wording of course, patches welcome for that.

But do we really need to distinguish the cases of disruption and
whether we cover up for them or not?

I would say we can deal with that the day we have a system with
two register bits (or similar) where you can select to preserve across
sleep, reset, one or the other, AND there is also a usecase such that
a user wants to preserve the value across reset but not suspend or
vice versa.

I suspect that will not happen.

Yours,
Linus Walleij

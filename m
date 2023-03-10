From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 10 Mar 2023 23:44:40 +0100
Subject: [PATCH v3 00/17] Mass convert GPIO IRQ chips to be immutable
In-Reply-To: <CAMRc=MdyjQDEMNxGYOKwWHry7MnEFMHYZSg=-FPohNwn6dxjaQ@mail.gmail.com>
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org> <CAMRc=MdyjQDEMNxGYOKwWHry7MnEFMHYZSg=-FPohNwn6dxjaQ@mail.gmail.com>
Message-ID: <CACRpkdYZvvPRgdctcFo+o24+PEWaz-dpPd0ntFg7qWQDYNPKsA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 10, 2023 at 4:25?PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Thu, Mar 9, 2023 at 8:45?AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > We are getting tired of these irq_chips not getting converted
> > to be immutable, so I just take out the big hammer and fix
> > some that I deem not too complex as best I can.
> >
> > I stopped after doing some, I will take another sweep at some
> > point I guess.

> Normally these irq_chip conversions would go upstream as fixes but
> this time there are too many at once. I applied them to my
> gpio/for-next branch. Let's give them some time in next and later we
> can backport them if necessary.

That's fine since the maintainers didn't get around to fixing it themselves
yet anyway it can't be that important to them.

I will try to take a second sweep and see what is left on the floor, and
then I guess a sweep over the gpio_chips in pinctrl as well.

Yours,
Linus Walleij

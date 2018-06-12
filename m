From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 12 Jun 2018 17:18:06 +1000
Subject: [PATCH 2/4] gpio: aspeed: Add "Read Data" register to read the
 write latch
In-Reply-To: <CACPK8Xf6Z8AVxt8gHnjvD+hemzq-P5nZ0C30Q+biqZtUWFO1_A@mail.gmail.com>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <20180612001043.9327-3-benh@kernel.crashing.org>
 <CACPK8Xf6Z8AVxt8gHnjvD+hemzq-P5nZ0C30Q+biqZtUWFO1_A@mail.gmail.com>
Message-ID: <43f17984eb20fefc78189e4020d0abca36a90f8e.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2018-06-12 at 15:08 +0930, Joel Stanley wrote:
> On 12 June 2018 at 09:40, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > The Aspeed GPIO hardware has a quirk: the value register, for an
> > output GPIO, doesn't contain the last value written (the write
> > latch content) but the sampled input value.
> > 
> > This means that when reading back shortly after writing, you can
> > get an incorrect value as the input value is delayed by a few
> > synchronizers.
> > 
> > The HW supports a separate read-only register "Data Read Register"
> > which allows you to read the write latch instead.
> > 
> > This adds the definition for it, and uses it for the initial
> > population of the GPIO value cache. It will be used more in
> > subsequent patches.
> > can be
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  drivers/gpio/gpio-aspeed.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> > index 42aadd52f77d..210c3fcc7a40 100644
> > --- a/drivers/gpio/gpio-aspeed.c
> > +++ b/drivers/gpio/gpio-aspeed.c
> > @@ -59,7 +59,10 @@ struct aspeed_gpio {
> >  };
> > 
> >  struct aspeed_gpio_bank {
> > -       uint16_t        val_regs;
> > +       uint16_t        val_regs;       /* 0: Wr: set write latch, Rd: read input value (*)
> > +                                        * 4: Direction (0=in, 1=out)
> > +                                        */
> > +       uint16_t        rdata_reg;      /* Wr: <none> Rd: read write latch */
> 
> The numbers weren't immediately obvious to me.
> 
> >         uint16_t        irq_regs;
> >         uint16_t        debounce_regs;
> >         uint16_t        tolerance_regs;
> > @@ -71,6 +74,7 @@ static const int debounce_timers[4] = { 0x00, 0x50, 0x54, 0x58 };
> >  static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
> >         {
> >                 .val_regs = 0x0000,
> > +               .rdata_reg = 0x00c0,
> >                 .irq_regs = 0x0008,
> >                 .debounce_regs = 0x0040,
> >                 .tolerance_regs = 0x001c,
> > @@ -78,6 +82,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
> >         },
> >         {
> >                 .val_regs = 0x0020,
> > +               .rdata_reg = 0x00c4,
> >                 .irq_regs = 0x0028,
> >                 .debounce_regs = 0x0048,
> >                 .tolerance_regs = 0x003c,
> > @@ -85,6 +90,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
> >         },
> >         {
> >                 .val_regs = 0x0070,
> > +               .rdata_reg = 0x00c8,
> >                 .irq_regs = 0x0098,
> >                 .debounce_regs = 0x00b0,
> >                 .tolerance_regs = 0x00ac,
> > @@ -92,6 +98,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
> >         },
> >         {
> >                 .val_regs = 0x0078,
> > +               .rdata_reg = 0x00d0,
> 
> 0x00cc?
> 
> I was really confused for a second, as I'd applied the series to my
> tree for testing, and my source as correct. It looks like you fixed
> these in patch 3.

Ah yes, patch splitting mistake. I'll fix that up, thanks.

> >                 .irq_regs = 0x00e8,
> >                 .debounce_regs = 0x0100,
> >                 .tolerance_regs = 0x00fc,

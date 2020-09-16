From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 16 Sep 2020 13:09:20 +0200
Subject: [PATCH v2 1/2] gpio/aspeed-sgpio: enable access to all 80 input &
 output sgpios
In-Reply-To: <CACPK8XeQWNTyS53M9PLwkud9RnGNp3j87X8_UXtg4ZHJrQqQSQ@mail.gmail.com>
References: <20200911015105.48581-1-jk@codeconstruct.com.au>
 <CACPK8XdCkw7ix2J9WyOXDcwsMThXwQ62=E6cDLX+-9WJMsqrnA@mail.gmail.com>
 <CACPK8XeQWNTyS53M9PLwkud9RnGNp3j87X8_UXtg4ZHJrQqQSQ@mail.gmail.com>
Message-ID: <CAMpxmJW+PMV1+q66ywEAiZhrOu+kiSPXQCK0mTGLLwW-yfisSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 6:51 AM Joel Stanley <joel@jms.id.au> wrote:
>
> Hi GPIO maintainers,
>
> On Fri, 11 Sep 2020 at 02:20, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Fri, 11 Sep 2020 at 02:11, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
> > >
> > > Currently, the aspeed-sgpio driver exposes up to 80 GPIO lines,
> > > corresponding to the 80 status bits available in hardware. Each of these
> > > lines can be configured as either an input or an output.
> > >
> > > However, each of these GPIOs is actually an input *and* an output; we
> > > actually have 80 inputs plus 80 outputs.
> > >
> > > This change expands the maximum number of GPIOs to 160; the lower half
> > > of this range are the input-only GPIOs, the upper half are the outputs.
> > > We fix the GPIO directions to correspond to this mapping.
> > >
> > > This also fixes a bug when setting GPIOs - we were reading from the
> > > input register, making it impossible to set more than one output GPIO.
> > >
> > > Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> > > Fixes: 7db47faae79b ("gpio: aspeed: Add SGPIO driver")
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> This series is good to go in for 5.10:
>

Hi Joel,

I don't have this in my inbox. Did you copy me on this series?

Bartosz

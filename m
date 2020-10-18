From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 18 Oct 2020 21:26:45 +0300
Subject: [PATCH 1/3] iio: adc: aspeed: Orgnaize and add the define of adc
In-Reply-To: <20201018112249.44dd3bde@archlinux>
References: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
 <20201013103245.16723-2-billy_tsai@aspeedtech.com>
 <20201018112249.44dd3bde@archlinux>
Message-ID: <CAHp75Vd4Sequmg_qLbtkk2JktM95bk+xg65P0gJNzPO3OQ7Vkg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Oct 18, 2020 at 1:32 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 13 Oct 2020 18:32:43 +0800
> Billy Tsai <billy_tsai@aspeedtech.com> wrote:

...

> > +/* [31:16] */

Useless comment.

> > +#define ASPEED_ADC_CTRL_CH_EN(n)     (1 << (16 + n))
> > +#define ASPEED_ADC_CTRL_CH_EN_ALL    GENMASK(31, 16)

But the main point is here.
First of all you may use BIT() in above.
Second, it's a good practice to put variables in the additional
parentheses in macros in case you are doing some operations with.

So, something like BIT(16 + (n)) would be nice to have at the end.

-- 
With Best Regards,
Andy Shevchenko

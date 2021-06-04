From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 4 Jun 2021 13:21:43 +0300
Subject: [PATCH v3 3/5] gpio: gpio-aspeed-sgpio: Add AST2600 sgpio support
In-Reply-To: <20210604021422.GA25112@aspeedtech.com>
References: <20210603101822.9645-1-steven_lee@aspeedtech.com>
 <20210603101822.9645-4-steven_lee@aspeedtech.com>
 <CAHp75Vef0HDXAHzSNL-LtA0Sra6Zpivt513_+aFR_um0JeFkog@mail.gmail.com>
 <20210604021422.GA25112@aspeedtech.com>
Message-ID: <CAHp75VfmCJEP+N-U5nhg-R1bhG5iSfqAsPf3022u8T2mmTFRAA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 4, 2021 at 5:14 AM Steven Lee <steven_lee@aspeedtech.com> wrote:
> The 06/03/2021 19:05, Andy Shevchenko wrote:
> > On Thu, Jun 3, 2021 at 1:19 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> > > +#define GPIO_OFFSET(x)        ((x) & 0x1f)
> >
> > GENMASK()
> >
> > ...
> >
>
> Do you mean the macro should be modified as follows?
> #define GPIO_OFFSET(x)        ((x) & GENMASK(4, 0))

Yes.

-- 
With Best Regards,
Andy Shevchenko

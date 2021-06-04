From: Steven Lee <steven_lee@aspeedtech.com>
Date: Fri, 4 Jun 2021 10:14:23 +0800
Subject: [PATCH v3 3/5] gpio: gpio-aspeed-sgpio: Add AST2600 sgpio support
In-Reply-To: <CAHp75Vef0HDXAHzSNL-LtA0Sra6Zpivt513_+aFR_um0JeFkog@mail.gmail.com>
References: <20210603101822.9645-1-steven_lee@aspeedtech.com>
 <20210603101822.9645-4-steven_lee@aspeedtech.com>
 <CAHp75Vef0HDXAHzSNL-LtA0Sra6Zpivt513_+aFR_um0JeFkog@mail.gmail.com>
Message-ID: <20210604021422.GA25112@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 06/03/2021 19:05, Andy Shevchenko wrote:
> On Thu, Jun 3, 2021 at 1:19 PM Steven Lee <steven_lee@aspeedtech.com> wrote:
> >
> > AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> > with 80 pins.
> > In the current driver, the maximum number of gpio pins of SoC is hardcoded
> > as 80 and the gpio pin count mask for GPIO Configuration register is
> > hardcode as GENMASK(9,6). In addition, some functions uses the hardcoded
> 
> use
> 
> > value to calculate the gpio offset.
> > The patch adds ast2600 compatibles and platform data that includes the
> > max number of gpio pins supported by ast2600 and gpio pin count mask for
> > GPIO Configuration register.
> > The patch also modifies some functions to pass aspeed_sgpio struct for
> > calculating gpio offset wihtout using the hardcoded value.
> 
> without
> 
> ...
> 
> > +#include <linux/of_device.h>
> 
> Why?
> 
> ...
> 

I will remove it as of_device_get_match_data() will be replaced
to device_get_match_data()

> > +#define GPIO_OFFSET(x)        ((x) & 0x1f)
> 
> GENMASK()
> 
> ...
> 

Do you mean the macro should be modified as follows?
#define GPIO_OFFSET(x)        ((x) & GENMASK(4, 0))

> > +       pdata = of_device_get_match_data(&pdev->dev);
> 
> device_get_match_data()
> 
> I guess you may replace all those of_*() to the corresponding
> device_*() or fwnode_*() calls.
> 

Thanks for the reviews, I will add a new patch for replacing all
of_*() to device_*().

> -- 
> With Best Regards,
> Andy Shevchenko

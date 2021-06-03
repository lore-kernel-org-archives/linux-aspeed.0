From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 3 Jun 2021 14:05:53 +0300
Subject: [PATCH v3 3/5] gpio: gpio-aspeed-sgpio: Add AST2600 sgpio support
In-Reply-To: <20210603101822.9645-4-steven_lee@aspeedtech.com>
References: <20210603101822.9645-1-steven_lee@aspeedtech.com>
 <20210603101822.9645-4-steven_lee@aspeedtech.com>
Message-ID: <CAHp75Vef0HDXAHzSNL-LtA0Sra6Zpivt513_+aFR_um0JeFkog@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 3, 2021 at 1:19 PM Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> with 80 pins.
> In the current driver, the maximum number of gpio pins of SoC is hardcoded
> as 80 and the gpio pin count mask for GPIO Configuration register is
> hardcode as GENMASK(9,6). In addition, some functions uses the hardcoded

use

> value to calculate the gpio offset.
> The patch adds ast2600 compatibles and platform data that includes the
> max number of gpio pins supported by ast2600 and gpio pin count mask for
> GPIO Configuration register.
> The patch also modifies some functions to pass aspeed_sgpio struct for
> calculating gpio offset wihtout using the hardcoded value.

without

...

> +#include <linux/of_device.h>

Why?

...

> +#define GPIO_OFFSET(x)        ((x) & 0x1f)

GENMASK()

...

> +       pdata = of_device_get_match_data(&pdev->dev);

device_get_match_data()

I guess you may replace all those of_*() to the corresponding
device_*() or fwnode_*() calls.

-- 
With Best Regards,
Andy Shevchenko

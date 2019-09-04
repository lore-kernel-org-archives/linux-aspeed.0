From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2019 19:27:33 +0300
Subject: [PATCH 1/4] gpio/aspeed: Fix incorrect number of banks
In-Reply-To: <20190904061245.30770-1-rashmica.g@gmail.com>
References: <20190904061245.30770-1-rashmica.g@gmail.com>
Message-ID: <CAHp75Vd_6Rpt5=BjzV8YFCiFP7qsRrYHHo7+=gWwnZH-zT9jNw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 4, 2019 at 9:14 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:
>
> Fixes: 361b79119a4b7 ('gpio: Add Aspeed driver')
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

>         /* Allocate a cache of the output registers */
> -       banks = gpio->config->nr_gpios >> 5;
> +       banks = (gpio->config->nr_gpios >> 5) + 1;

Shouldn't be rather DIV_ROUND_UP(nr_gpios, sizeof(u32)) ?

>         gpio->dcache = devm_kcalloc(&pdev->dev,
>                                     banks, sizeof(u32), GFP_KERNEL);


-- 
With Best Regards,
Andy Shevchenko

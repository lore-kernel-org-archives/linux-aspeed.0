From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 3 Jun 2021 14:07:28 +0300
Subject: [PATCH v3 4/5] gpio: gpio-aspeed-sgpio: Add set_config function
In-Reply-To: <20210603101822.9645-5-steven_lee@aspeedtech.com>
References: <20210603101822.9645-1-steven_lee@aspeedtech.com>
 <20210603101822.9645-5-steven_lee@aspeedtech.com>
Message-ID: <CAHp75VcPdUeK49w9qg9RuJY7ASMyFMEEi=cX1gnp=wM_QHDZ+w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 3, 2021 at 1:20 PM Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> AST SoC supports *retain pin state* function when wdt reset.
> The patch adds set_config function for handling sgpio reset tolerance
> register.

...

> +static int aspeed_sgpio_set_config(struct gpio_chip *chip, unsigned int offset,
> +                                  unsigned long config)
> +{
> +       unsigned long param = pinconf_to_config_param(config);
> +       u32 arg = pinconf_to_config_argument(config);
> +
> +       if (param == PIN_CONFIG_PERSIST_STATE)
> +               return aspeed_sgpio_reset_tolerance(chip, offset, arg);

> +       else

Redundant.

> +               return -EOPNOTSUPP;

IIRC we are using ENOTSUPP internally in the kernel. YEs, checkpatch
warning may be ignored.

> +}

-- 
With Best Regards,
Andy Shevchenko

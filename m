From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Sep 2020 03:11:33 +0000
Subject: [PATCH v2 1/3] pinctrl: aspeed: Format pinconf debug consistent
 with pinmux
In-Reply-To: <20200910025631.2996342-2-andrew@aj.id.au>
References: <20200910025631.2996342-1-andrew@aj.id.au>
 <20200910025631.2996342-2-andrew@aj.id.au>
Message-ID: <CACPK8XePJtLq7pJ3-dYL+Ac1Q2Z5sQQ=qc5gYNsGM2zkXPyFmA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2020 at 02:57, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> When displaying which pinconf register and field is being touched,
> format the field mask so that it's consistent with the way the pinmux
> portion formats the mask.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> In v2: Format val with %X as suggested by Joel

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> index 53f3f8aec695..2e0260c1a57c 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> @@ -539,9 +539,9 @@ int aspeed_pin_config_set(struct pinctrl_dev *pctldev, unsigned int offset,
>                 if (rc < 0)
>                         return rc;
>
> -               pr_debug("%s: Set SCU%02X[%lu]=%d for param %d(=%d) on pin %d\n",
> -                               __func__, pconf->reg, __ffs(pconf->mask),
> -                               pmap->val, param, arg, offset);
> +               pr_debug("%s: Set SCU%02X[0x%08X]=0x%X for param %d(=%d) on pin %d\n",
> +                               __func__, pconf->reg, pconf->mask,
> +                               val, param, arg, offset);
>         }
>
>         return 0;
> --
> 2.25.1
>

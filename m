From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Sep 2020 01:52:04 +0000
Subject: [PATCH 1/3] pinctrl: aspeed: Format pinconf debug consistent with
 pinmux
In-Reply-To: <20200909114312.2863675-2-andrew@aj.id.au>
References: <20200909114312.2863675-1-andrew@aj.id.au>
 <20200909114312.2863675-2-andrew@aj.id.au>
Message-ID: <CACPK8XeOf1H2Cdo434DsAjDNGrohip_MZTSMMOh1nhspz2y7dA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2020 at 11:43, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> When displaying which pinconf register and field is being touched, format the
> field mask so that it's consistent with the way the pinmux portion
> formats the mask.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> index 53f3f8aec695..d8972911d505 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> @@ -539,9 +539,9 @@ int aspeed_pin_config_set(struct pinctrl_dev *pctldev, unsigned int offset,
>                 if (rc < 0)
>                         return rc;
>
> -               pr_debug("%s: Set SCU%02X[%lu]=%d for param %d(=%d) on pin %d\n",
> -                               __func__, pconf->reg, __ffs(pconf->mask),
> -                               pmap->val, param, arg, offset);
> +               pr_debug("%s: Set SCU%02X[0x%08X]=%d for param %d(=%d) on pin %d\n",


The pr_debug in pinmux-aspeed.c prints val as 0x%X. Did you want to do
that here?

> +                               __func__, pconf->reg, pconf->mask,
> +                               val, param, arg, offset);
>         }
>
>         return 0;
> --
> 2.25.1
>

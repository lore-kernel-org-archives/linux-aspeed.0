From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date: Tue, 11 Oct 2022 10:31:33 +0200
Subject: [PATCH v2 25/36] pinctrl: starfive: Add missed header(s)
In-Reply-To: <20221010201453.77401-26-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com> <20221010201453.77401-26-andriy.shevchenko@linux.intel.com>
Message-ID: <CAJM55Z_ApPowttZrjn_0dUs81H4FfByDfv=fbhvmHquipULANg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 10 Oct 2022 at 22:26, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
>
> While at it, sort headers alphabetically.

The patch is fine, but I don't see any sorting other than just adding
the headers at the appropriate place.
In any case

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> index 5b544fb7f3d8..6a8a9cfe8965 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> @@ -15,8 +15,10 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> +#include <linux/seq_file.h>
>  #include <linux/spinlock.h>
>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
>
> --
> 2.35.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

From: Joel Stanley <joel@jms.id.au>
Date: Mon, 13 Dec 2021 23:12:55 +0000
Subject: [PATCH] i2c: aspeed: Remove unused includes
In-Reply-To: <20211207141722.440213-1-thierry.reding@gmail.com>
References: <20211207141722.440213-1-thierry.reding@gmail.com>
Message-ID: <CACPK8XfKp1fDLjVPHb0bO-fi2JryOP5H6Jh1bmovt68Qne+D9Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 13 Dec 2021 at 22:22, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> No symbols from the linux/irqchip/chained_irq.h and linux/irqdomain.h
> headers are used in the driver, so they can be removed.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Agreed, it looks like these were added in the initial commit and never used.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/i2c/busses/i2c-aspeed.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 67e8b97c0c95..771e53d3d197 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -16,8 +16,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> -#include <linux/irqchip/chained_irq.h>
> -#include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> --
> 2.33.1
>

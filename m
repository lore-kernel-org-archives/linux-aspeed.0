From: Joel Stanley <joel@jms.id.au>
Date: Mon, 6 Apr 2020 01:20:01 +0000
Subject: [PATCH] mtd: spi-nor: Compile files in controllers/ directory
In-Reply-To: <20200404153631.103549-1-linux@roeck-us.net>
References: <20200404153631.103549-1-linux@roeck-us.net>
Message-ID: <CACPK8Xdmjp0qg0JHHnR1MJp7zmuZHCHTOs7+qn5_16oLbe+r+g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 4 Apr 2020 at 15:37, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Commit a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code
> split") moved various files into a new directory, but did not add the new
> directory to its parent directory Makefile. The moved files no longer
> build, and affected flash chips no longer instantiate.
>
> Adding the new directory to the parent directory Makefile fixes the
> problem.
>
> Fixes: a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code split")
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter. I just discovered this too.

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/mtd/spi-nor/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 7ddb742de1fe..653923896205 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -18,3 +18,5 @@ spi-nor-objs                  += winbond.o
>  spi-nor-objs                   += xilinx.o
>  spi-nor-objs                   += xmc.o
>  obj-$(CONFIG_MTD_SPI_NOR)      += spi-nor.o
> +
> +obj-$(CONFIG_MTD_SPI_NOR)      += controllers/
> --
> 2.17.1
>

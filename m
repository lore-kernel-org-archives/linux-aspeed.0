From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Oct 2022 14:32:02 +0100
Subject: [PATCH 05/10] iio: imu: Replace spi->chip_select references to
 spi->chip_select[0]
In-Reply-To: <20221017121249.19061-6-amit.kumar-mahapatra@amd.com>
References: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
	<20221017121249.19061-6-amit.kumar-mahapatra@amd.com>
Message-ID: <20221017143202.00003b1d@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 17 Oct 2022 17:42:44 +0530
Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com> wrote:

> For adding multi CS support & to prevent any existing driver from
> breaking, replaced all spi->chip_select references to spi->chip_slect[0].
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

Hmm. No particular reason why that print should exist at all.
The warning above it covers the case where there is a mismatch
in IDs so this adds nothing useful.

So patch is fine, but I'd be equally happy with just dropping the
print.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/imu/adis16400.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 17bb0c40a149..aa7bfcee3510 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -466,7 +466,7 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
>  
>  		dev_info(&indio_dev->dev, "%s: prod_id 0x%04x at CS%d (irq %d)\n",
>  			indio_dev->name, prod_id,
> -			st->adis.spi->chip_select, st->adis.spi->irq);
> +			st->adis.spi->chip_select[0], st->adis.spi->irq);
>  	}
>  	/* use high spi speed if possible */
>  	if (st->variant->flags & ADIS16400_HAS_SLOW_MODE) {


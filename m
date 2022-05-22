From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 22 May 2022 12:48:04 +0100
Subject: [PATCH] iio: adc: aspeed: Fix refcount leak in
 aspeed_adc_set_trim_data
In-Reply-To: <20220516075206.34580-1-linmq006@gmail.com>
References: <20220516075206.34580-1-linmq006@gmail.com>
Message-ID: <20220522124804.7ec5940a@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 16 May 2022 11:52:02 +0400
Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_node_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: d0a4c17b4073 ("iio: adc: aspeed: Get and set trimming data.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

In the 'hopefully obviously correct' category so applied to the fixes
togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 0793d2474cdc..9341e0e0eb55 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -186,6 +186,7 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
>  		return -EOPNOTSUPP;
>  	}
>  	scu = syscon_node_to_regmap(syscon);
> +	of_node_put(syscon);
>  	if (IS_ERR(scu)) {
>  		dev_warn(data->dev, "Failed to get syscon regmap\n");
>  		return -EOPNOTSUPP;


From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Date: Mon, 23 Jan 2023 18:16:33 +0100
Subject: [PATCH v2 02/13] spi: Replace all spi->chip_select and
 spi->cs_gpiod references with function call
In-Reply-To: <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
References: <20230119185342.2093323-1-amit.kumar-mahapatra@amd.com>
 <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
Message-ID: <e068c541-b492-a513-6212-fd698e4fc9c4@foss.st.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Amit

On 1/19/23 19:53, Amit Kumar Mahapatra wrote:
> Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
> members of struct spi_device to be an array. But changing the type of these
> members to array would break the spi driver functionality. To make the
> transition smoother introduced four new APIs to get/set the
> spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and
> spi->cs_gpiod references with get or set API calls.
> While adding multi-cs support in further patches the chip_select & cs_gpiod
> members of the spi_device structure would be converted to arrays & the
> "idx" parameter of the APIs would be used as array index i.e.,
> spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---

[...]

>  drivers/spi/spi-stm32-qspi.c      | 12 ++++++------

[...]

> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index 9131660c1afb..b9e61372dcfb 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -359,7 +359,7 @@ static int stm32_qspi_get_mode(u8 buswidth)
>  static int stm32_qspi_send(struct spi_device *spi, const struct spi_mem_op *op)
>  {
>  	struct stm32_qspi *qspi = spi_controller_get_devdata(spi->master);
> -	struct stm32_qspi_flash *flash = &qspi->flash[spi->chip_select];
> +	struct stm32_qspi_flash *flash = &qspi->flash[spi_get_chipselect(spi, 0)];
>  	u32 ccr, cr;
>  	int timeout, err = 0, err_poll_status = 0;
>  
> @@ -564,7 +564,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
>  	struct spi_mem_op op;
>  	int ret = 0;
>  
> -	if (!spi->cs_gpiod)
> +	if (!spi_get_csgpiod(spi, 0))
>  		return -EOPNOTSUPP;
>  
>  	ret = pm_runtime_resume_and_get(qspi->dev);
> @@ -573,7 +573,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
>  
>  	mutex_lock(&qspi->lock);
>  
> -	gpiod_set_value_cansleep(spi->cs_gpiod, true);
> +	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), true);
>  
>  	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
>  		u8 dummy_bytes = 0;
> @@ -626,7 +626,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
>  	}
>  
>  end_of_transfer:
> -	gpiod_set_value_cansleep(spi->cs_gpiod, false);
> +	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), false);
>  
>  	mutex_unlock(&qspi->lock);
>  
> @@ -669,8 +669,8 @@ static int stm32_qspi_setup(struct spi_device *spi)
>  
>  	presc = DIV_ROUND_UP(qspi->clk_rate, spi->max_speed_hz) - 1;
>  
> -	flash = &qspi->flash[spi->chip_select];
> -	flash->cs = spi->chip_select;
> +	flash = &qspi->flash[spi_get_chipselect(spi, 0)];
> +	flash->cs = spi_get_chipselect(spi, 0);
>  	flash->presc = presc;
>  
>  	mutex_lock(&qspi->lock);

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

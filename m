From: Michal Simek <michal.simek@amd.com>
Date: Mon, 23 Jan 2023 13:44:56 +0100
Subject: [PATCH v2 01/13] spi: Add APIs in spi core to set/get
 spi->chip_select and spi->cs_gpiod
In-Reply-To: <20230119185342.2093323-2-amit.kumar-mahapatra@amd.com>
References: <20230119185342.2093323-1-amit.kumar-mahapatra@amd.com>
 <20230119185342.2093323-2-amit.kumar-mahapatra@amd.com>
Message-ID: <2f4171f8-badb-a33a-7ae6-c375d9d725c3@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 1/19/23 19:53, Amit Kumar Mahapatra wrote:
> Supporting multi-cs in spi core and spi controller drivers would require
> the chip_select & cs_gpiod members of struct spi_device to be an array.
> But changing the type of these members to array would break the spi driver
> functionality. To make the transition smoother introduced four new APIs to
> get/set the spi->chip_select & spi->cs_gpiod and replaced all
> spi->chip_select and spi->cs_gpiod references in spi core with the API
> calls.
> While adding multi-cs support in further patches the chip_select & cs_gpiod
> members of the spi_device structure would be converted to arrays & the
> "idx" parameter of the APIs would be used as array index i.e.,
> spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>   drivers/spi/spi.c       | 45 ++++++++++++++++++++---------------------
>   include/linux/spi/spi.h | 20 ++++++++++++++++++
>   2 files changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 3cc7bb4d03de..38421e831a7d 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -604,7 +604,7 @@ static void spi_dev_set_name(struct spi_device *spi)
>   	}
>   
>   	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
> -		     spi->chip_select);
> +		     spi_get_chipselect(spi, 0));
>   }
>   
>   static int spi_dev_check(struct device *dev, void *data)
> @@ -613,7 +613,7 @@ static int spi_dev_check(struct device *dev, void *data)
>   	struct spi_device *new_spi = data;
>   
>   	if (spi->controller == new_spi->controller &&
> -	    spi->chip_select == new_spi->chip_select)
> +	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
>   		return -EBUSY;
>   	return 0;
>   }
> @@ -638,7 +638,7 @@ static int __spi_add_device(struct spi_device *spi)
>   	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
>   	if (status) {
>   		dev_err(dev, "chipselect %d already in use\n",
> -				spi->chip_select);
> +				spi_get_chipselect(spi, 0));
>   		return status;
>   	}
>   
> @@ -649,7 +649,7 @@ static int __spi_add_device(struct spi_device *spi)
>   	}
>   
>   	if (ctlr->cs_gpiods)
> -		spi->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
> +		spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi, 0)]);
>   
>   	/*
>   	 * Drivers may modify this initial i/o setup, but will
> @@ -692,8 +692,8 @@ int spi_add_device(struct spi_device *spi)
>   	int status;
>   
>   	/* Chipselects are numbered 0..max; validate. */
> -	if (spi->chip_select >= ctlr->num_chipselect) {
> -		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
> +	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> +		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
>   			ctlr->num_chipselect);
>   		return -EINVAL;
>   	}
> @@ -714,8 +714,8 @@ static int spi_add_device_locked(struct spi_device *spi)
>   	struct device *dev = ctlr->dev.parent;
>   
>   	/* Chipselects are numbered 0..max; validate. */
> -	if (spi->chip_select >= ctlr->num_chipselect) {
> -		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
> +	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> +		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
>   			ctlr->num_chipselect);
>   		return -EINVAL;
>   	}
> @@ -761,7 +761,7 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
>   
>   	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
>   
> -	proxy->chip_select = chip->chip_select;
> +	spi_set_chipselect(proxy, 0, chip->chip_select);
>   	proxy->max_speed_hz = chip->max_speed_hz;
>   	proxy->mode = chip->mode;
>   	proxy->irq = chip->irq;
> @@ -970,24 +970,23 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>   	 * Avoid calling into the driver (or doing delays) if the chip select
>   	 * isn't actually changing from the last time this was called.
>   	 */
> -	if (!force && ((enable && spi->controller->last_cs == spi->chip_select) ||
> -				(!enable && spi->controller->last_cs != spi->chip_select)) &&
> +	if (!force && ((enable && spi->controller->last_cs == spi_get_chipselect(spi, 0)) ||
> +		       (!enable && spi->controller->last_cs != spi_get_chipselect(spi, 0))) &&
>   	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
>   		return;
>   
>   	trace_spi_set_cs(spi, activate);
>   
> -	spi->controller->last_cs = enable ? spi->chip_select : -1;
> +	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0) : -1;
>   	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
>   
> -	if ((spi->cs_gpiod || !spi->controller->set_cs_timing) && !activate) {
> +	if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) && !activate)
>   		spi_delay_exec(&spi->cs_hold, NULL);
> -	}
>   
>   	if (spi->mode & SPI_CS_HIGH)
>   		enable = !enable;
>   
> -	if (spi->cs_gpiod) {
> +	if (spi_get_csgpiod(spi, 0)) {
>   		if (!(spi->mode & SPI_NO_CS)) {
>   			/*
>   			 * Historically ACPI has no means of the GPIO polarity and
> @@ -1000,10 +999,10 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>   			 * into account.
>   			 */
>   			if (has_acpi_companion(&spi->dev))
> -				gpiod_set_value_cansleep(spi->cs_gpiod, !enable);
> +				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
>   			else
>   				/* Polarity handled by GPIO library */
> -				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
> +				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
>   		}
>   		/* Some SPI masters need both GPIO CS & slave_select */
>   		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> @@ -1013,7 +1012,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>   		spi->controller->set_cs(spi, !enable);
>   	}
>   
> -	if (spi->cs_gpiod || !spi->controller->set_cs_timing) {
> +	if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
>   		if (activate)
>   			spi_delay_exec(&spi->cs_setup, NULL);
>   		else
> @@ -2304,7 +2303,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>   			nc, rc);
>   		return rc;
>   	}
> -	spi->chip_select = value;
> +	spi_set_chipselect(spi, 0, value);
>   
>   	/* Device speed */
>   	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
> @@ -2423,7 +2422,7 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
>   	strscpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
>   
>   	/* Use provided chip-select for ancillary device */
> -	ancillary->chip_select = chip_select;
> +	spi_set_chipselect(ancillary, 0, chip_select);
>   
>   	/* Take over SPI mode/speed from SPI main device */
>   	ancillary->max_speed_hz = spi->max_speed_hz;
> @@ -2670,7 +2669,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>   	spi->mode		|= lookup.mode;
>   	spi->irq		= lookup.irq;
>   	spi->bits_per_word	= lookup.bits_per_word;
> -	spi->chip_select	= lookup.chip_select;
> +	spi_set_chipselect(spi, 0, lookup.chip_select);
>   
>   	return spi;
>   }
> @@ -3632,7 +3631,7 @@ static int spi_set_cs_timing(struct spi_device *spi)
>   	struct device *parent = spi->controller->dev.parent;
>   	int status = 0;
>   
> -	if (spi->controller->set_cs_timing && !spi->cs_gpiod) {
> +	if (spi->controller->set_cs_timing && !spi_get_csgpiod(spi, 0)) {
>   		if (spi->controller->auto_runtime_pm) {
>   			status = pm_runtime_get_sync(parent);
>   			if (status < 0) {
> @@ -3837,7 +3836,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>   	 * cs_change is set for each transfer.
>   	 */
>   	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
> -					  spi->cs_gpiod)) {
> +					  spi_get_csgpiod(spi, 0))) {
>   		size_t maxsize;
>   		int ret;
>   
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 9a32495fbb1f..9b23a1d0dd0d 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -263,6 +263,26 @@ static inline void *spi_get_drvdata(struct spi_device *spi)
>   	return dev_get_drvdata(&spi->dev);
>   }
>   
> +static inline u8 spi_get_chipselect(struct spi_device *spi, u8 idx)
> +{
> +	return spi->chip_select;
> +}
> +
> +static inline void spi_set_chipselect(struct spi_device *spi, u8 idx, u8 chipselect)
> +{
> +	spi->chip_select = chipselect;
> +}
> +
> +static inline struct gpio_desc *spi_get_csgpiod(struct spi_device *spi, u8 idx)
> +{
> +	return spi->cs_gpiod;
> +}
> +
> +static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx, struct gpio_desc *csgpiod)
> +{
> +	spi->cs_gpiod = csgpiod;
> +}
> +
>   struct spi_message;
>   
>   /**

Lars suggested this style in v1 version of this patch here.
https://lore.kernel.org/all/12fe1b84-1981-bf56-9323-b7f5b698c196 at metafoo.de/

That's why let me also add his
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>

And
Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal



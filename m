From: John Garry <john.garry@huawei.com>
Date: Fri, 4 Oct 2019 10:39:51 +0100
Subject: [PATCH v2 10/22] mtd: spi-nor: Rework write_sr()
In-Reply-To: <20190924074533.6618-11-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-11-tudor.ambarus@microchip.com>
Message-ID: <83d62334-bd1c-20b7-3c58-225392c819f8@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/09/2019 08:46, Tudor.Ambarus at microchip.com wrote:
> +}
> +
> +/**
> + * spi_nor_write_sr() - Write the Status Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @sr:		buffer to write to the Status Register.
> + * @len:	number of bytes to write to the Status Register.
> + *
> + * Return: 0 on success, -errno otherwise.
>   */
> -static int write_sr(struct spi_nor *nor, u8 val)
> +static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
>  {
> -	nor->bouncebuf[0] = val;
> +	int ret;
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +

Hi Tudor,

>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>  				   SPI_MEM_OP_NO_ADDR,
>  				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));

This be SPI_MEM_OP_DATA_OUT() in the current mainline code also, right?

I'm testing my under development driver on top of v5.4-rc1, and 
flash_lock -u is broken.

Cheers,
John

> +				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
>
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> +						     sr, len);
>  	}
>
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> -					      nor->bouncebuf, 1);
> +	if (ret) {
> +		dev_err(nor->dev, "error while writing Status Register\n");
> +		return ret;
> +	}
> +
> +	ret = spi_nor_wait_till_ready(nor);
> +
> +	return ret;
>  }
>
>  static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
> @@ -741,161 +914,6 @@ static int winbond_set_4byte(struct spi_nor *nor, bool enable)
>  	return ret;
>  }



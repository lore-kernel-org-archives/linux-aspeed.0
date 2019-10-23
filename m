From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Wed, 23 Oct 2019 23:39:31 +0000
Subject: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
In-Reply-To: <20191010092117.4c5018a8@dhcp-172-31-174-146.wireless.concordia.ca>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-9-tudor.ambarus@microchip.com>
 <20191010092117.4c5018a8@dhcp-172-31-174-146.wireless.concordia.ca>
Message-ID: <34fbb0d7-ee8f-a6d7-4a3e-d64f2f8555ff@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/10/2019 10:21 AM, Boris Brezillon wrote:
> External E-Mail
> 
> 
> On Tue, 24 Sep 2019 07:46:18 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> static int write_enable(struct spi_nor *nor)
>> static int write_disable(struct spi_nor *nor)
>> become
>> static int spi_nor_write_enable(struct spi_nor *nor)
>> static int spi_nor_write_disable(struct spi_nor *nor)
>>
>> Check for errors after each call to them. Move them up in the
>> file as the first SPI NOR Register Operations, to avoid further
>> forward declarations.
> 
> Same here, split that in 3 patches please.

:)

> 
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 175 +++++++++++++++++++++++++++++-------------
>>  1 file changed, 120 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 0fb124bd2e77..0aee068a5835 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -389,6 +389,64 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>>  }
>>  
>>  /**
>> + * spi_nor_write_enable() - Set write enable latch with Write Enable command.
>> + * @nor:        pointer to 'struct spi_nor'
>> + *
>> + * Return: 0 on success, -errno otherwise.
>> + */
>> +static int spi_nor_write_enable(struct spi_nor *nor)
>> +{
>> +	int ret;
>> +
>> +	if (nor->spimem) {
>> +		struct spi_mem_op op =
>> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
>> +				   SPI_MEM_OP_NO_ADDR,
>> +				   SPI_MEM_OP_NO_DUMMY,
>> +				   SPI_MEM_OP_NO_DATA);
>> +
>> +		ret = spi_mem_exec_op(nor->spimem, &op);
>> +	} else {
>> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
>> +						     NULL, 0);
>> +	}
>> +
>> +	if (ret)
>> +		dev_err(nor->dev, "error %d on Write Enable\n", ret);
> 
> Do we really need these error messages? I mean, if there's an error it
> should be propagated to the upper layer, so maybe we should use
> dev_dbg() here.
> 

I find them useful. On error conditions, I would like to see what were the
difficulties when interacting with the hardware.


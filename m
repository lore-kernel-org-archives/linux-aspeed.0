From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Fri, 4 Oct 2019 10:03:40 +0000
Subject: [PATCH v2 10/22] mtd: spi-nor: Rework write_sr()
In-Reply-To: <83d62334-bd1c-20b7-3c58-225392c819f8@huawei.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-11-tudor.ambarus@microchip.com>
 <83d62334-bd1c-20b7-3c58-225392c819f8@huawei.com>
Message-ID: <e5d9b91f-cb86-0b82-5631-af0868ba4796@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, John,

On 10/04/2019 12:39 PM, John Garry wrote:
> External E-Mail
> 
> 
> On 24/09/2019 08:46, Tudor.Ambarus at microchip.com wrote:
>> +}
>> +
>> +/**
>> + * spi_nor_write_sr() - Write the Status Register.
>> + * @nor:??? pointer to 'struct spi_nor'.
>> + * @sr:??????? buffer to write to the Status Register.
>> + * @len:??? number of bytes to write to the Status Register.
>> + *
>> + * Return: 0 on success, -errno otherwise.
>> ? */
>> -static int write_sr(struct spi_nor *nor, u8 val)
>> +static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
>> ?{
>> -??? nor->bouncebuf[0] = val;
>> +??? int ret;
>> +
>> +??? ret = spi_nor_write_enable(nor);
>> +??? if (ret)
>> +??????? return ret;
>> +
> 
> Hi Tudor,
> 
>> ???? if (nor->spimem) {
>> ???????? struct spi_mem_op op =
>> ???????????? SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>> ??????????????????? SPI_MEM_OP_NO_ADDR,
>> ??????????????????? SPI_MEM_OP_NO_DUMMY,
>> -?????????????????? SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> 
> This be SPI_MEM_OP_DATA_OUT() in the current mainline code also, right?

In v5.4-rc1 this is defined as SPI_MEM_OP_DATA_IN, so the Mainline code should
fail. This looks like a bug. I didn't noticed it when doing the patch.

> 
> I'm testing my under development driver on top of v5.4-rc1, and flash_lock -u is broken.

It's not clear to me, does flash_lock fail with my patches on top of v5.4-rc1?
Or it fails when testing v5.4-rc1?

Can you test v5.4-rc1 and see if flash_lock works on you flash or not?

Please specify which flash do you use, and which controller.

Thanks for testing this!
ta

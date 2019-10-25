From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Fri, 25 Oct 2019 07:34:30 +0000
Subject: [PATCH v2 09/22] mtd: spi-nor: Fix retlen handling in sst_write()
In-Reply-To: <20191010093308.2fe94974@dhcp-172-31-174-146.wireless.concordia.ca>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-10-tudor.ambarus@microchip.com>
 <20191010093308.2fe94974@dhcp-172-31-174-146.wireless.concordia.ca>
Message-ID: <7f23e9c0-0e9c-e365-e103-75ead47000a3@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/10/2019 10:33 AM, Boris Brezillon wrote:

>>  drivers/mtd/spi-nor/spi-nor.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 0aee068a5835..be5dee622d51 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -2665,12 +2665,12 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
>>  		/* write one byte. */
>>  		ret = spi_nor_write_data(nor, to, 1, buf);
>>  		if (ret < 0)
>> -			goto sst_write_err;
>> +			goto unlock_and_unprep;
>>  		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
>>  		     (int)ret);
>>  		ret = spi_nor_wait_till_ready(nor);
>>  		if (ret)
>> -			goto sst_write_err;
>> +			goto unlock_and_unprep;
>>  	}
>>  	to += actual;
> Not sure we need this new label, we can just have:
> 
> 	actual = 0;
> 	/* Start write from odd address. */
> 	if (to % 2) {
> 		nor->program_opcode = SPINOR_OP_BP;
> 
> 		/* write one byte. */
> 		ret = spi_nor_write_data(nor, to, 1, buf);
> 		if (ret < 0)
> 			goto out;
> 		WARN(ret != 1, "While writing 1 byte written %i
> 		bytes\n", (int)ret);
> 		ret = spi_nor_wait_till_ready(nor);
> 		if (ret)
> 			goto out;
> 
> 		to++;
> 		actual++;
> 	}
> 

nice, thanks!

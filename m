From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Thu, 19 Sep 2019 15:54:52 +0000
Subject: [PATCH 17/23] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
In-Reply-To: <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <20190917155426.7432-18-tudor.ambarus@microchip.com>
 <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
Message-ID: <b44e398a-037a-8f32-58dd-15b7f714a8a3@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 09/19/2019 05:33 PM, Vignesh Raghavendra wrote:
> Hi Tudor
> 

Hi, Vignesh,

> [...]
> 
> On 17-Sep-19 9:25 PM, Tudor.Ambarus at microchip.com wrote:
>> +static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 status_new,
>> +					    u8 mask)
>> +{
>> +	int ret;
>> +	u8 *sr_cr = nor->bouncebuf;
>> +	u8 cr_written;
>> +
>> +	/* Make sure we don't overwrite the contents of Status Register 2. */
>> +	if (!(nor->flags & SNOR_F_NO_READ_CR)) {
> Assuming SNOR_F_NO_READ_CR is not set...
> 
when SNOR_F_NO_READ_CR is not set, I read the Status Register 2 on the next line:

>> +		ret = spi_nor_read_cr(nor, &sr_cr[1]);
>> +		if (ret)
>> +			return ret;
>> +	} else if (nor->flash.quad_enable) {
>> +		/*
>> +		 * If the Status Register 2 Read command (35h) is not
>> +		 * supported, we should at least be sure we don't
>> +		 * change the value of the SR2 Quad Enable bit.
>> +		 *
>> +		 * We can safely assume that when the Quad Enable method is
>> +		 * set, the value of the QE bit is one, as a consequence of the
>> +		 * nor->flash.quad_enable() call.
>> +		 *
>> +		 * We can safely assume that the Quad Enable bit is present in
>> +		 * the Status Register 2 at BIT(1). According to the JESD216
>> +		 * revB standard, BFPT DWORDS[15], bits 22:20, the 16-bit
>> +		 * Write Status (01h) command is available just for the cases
>> +		 * in which the QE bit is described in SR2 at BIT(1).
>> +		 */

when SNOR_F_NO_READ_CR is set and nor->flash.quad_enable != NULL, Status
Register 2 (CR) is equal to CR_QUAD_EN_SPAN.

>> +		sr_cr[1] = CR_QUAD_EN_SPAN;
>> +	} else {

if SNOR_F_NO_READ_CR is set and nor->flash.quad_enable == NULL we don't need to
enable Quad Mode, so Status Register 2 is 0.

>> +		sr_cr[1] = 0;
>> +	}
>> +
> CR_QUAD_EN_SPAN will not be in sr_cr[1] when we reach here. So code
> won't enable quad mode.
> 
> 

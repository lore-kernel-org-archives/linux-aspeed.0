From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Fri, 20 Sep 2019 05:23:26 +0000
Subject: [PATCH 17/23] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
In-Reply-To: <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <20190917155426.7432-18-tudor.ambarus@microchip.com>
 <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
Message-ID: <06a6e4e8-6802-3f85-ec3c-6295cd703c85@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, Vignesh,

On 09/19/2019 05:33 PM, Vignesh Raghavendra wrote:
> External E-Mail
> 
> 
> Hi Tudor
> 
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
> 
> Assuming SNOR_F_NO_READ_CR is not set...
> 
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
>> +		sr_cr[1] = CR_QUAD_EN_SPAN;
>> +	} else {
>> +		sr_cr[1] = 0;
>> +	}
>> +
> 
> CR_QUAD_EN_SPAN will not be in sr_cr[1] when we reach here. So code
> won't enable quad mode.
> 

I get the problem now. spi_nor_write_16bit_sr_and_check() does not modify the
value of the QE bit, which is good in the lock/unlock() case. We want to
lock/unlock() without enabling or disabling the Quad Mode.

As you found, the problem comes later in spi_nor_sr2_bit1_quad_enable() because
I use there spi_nor_write_16bit_sr_and_check() which keeps the value of the QE
bit, without setting it to one, so the spi_nor_sr2_bit1_quad_enable() did not
enable the Quad Mode if not previously enabled.

What I'll do is to introduce a new argument to:
static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 status_new,
					    u8 mask, bool set_quad_enable)

and do a
if (set_quad_enable)
	sr_cr[1] |= CR_QUAD_EN_SPAN;
after initializing sr_cr[1]

The lock/unlock() methods will call the function with set_quad_enable being
false (we don't want to modify the QE value), and the
spi_nor_sr2_bit1_quad_enable() will call it with set_quad_enable being true, we
want to set QE to one (we don't care of the QE bit previous value).

We'll avoid code duplication, lock/unlock() and spi_nor_sr2_bit1_quad_enable()
calling the same method.

Cheers,
ta

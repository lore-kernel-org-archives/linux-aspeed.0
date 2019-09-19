From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Thu, 19 Sep 2019 16:07:15 +0000
Subject: [PATCH 00/23] mtd: spi-nor: Quad Enable and (un)lock methods
In-Reply-To: <920a9946-af0d-1190-d59c-0b4acee71931@ti.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <920a9946-af0d-1190-d59c-0b4acee71931@ti.com>
Message-ID: <041440d2-1f10-4ab3-ec36-53bd23aed739@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 09/19/2019 05:37 PM, Vignesh Raghavendra wrote:
> External E-Mail
> 
> 
> Hi,

Hi, thanks for reviewing!

> 
> On 17-Sep-19 9:24 PM, Tudor.Ambarus at microchip.com wrote:
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
> [...]
>> Tudor Ambarus (23):
>>   mtd: spi-nor: hisi-sfc: Drop nor->erase NULL assignment
>>   mtd: spi-nor: Introduce 'struct spi_nor_controller_ops'
>>   mtd: spi-nor: cadence-quadspi: Fix cqspi_command_read() definition
>>   mtd: spi-nor: Rename nor->params to nor->flash
>>   mtd: spi-nor: Rework read_sr()
>>   mtd: spi-nor: Rework read_fsr()
>>   mtd: spi-nor: Rework read_cr()
>>   mtd: spi-nor: Rework write_enable/disable()
>>   mtd: spi-nor: Fix retlen handling in sst_write()
>>   mtd: spi-nor: Rework write_sr()
>>   mtd: spi-nor: Rework spi_nor_read/write_sr2()
>>   mtd: spi-nor: Report error in spi_nor_xread_sr()
>>   mtd: spi-nor: Void return type for spi_nor_clear_sr/fsr()
>>   mtd: spi-nor: Drop duplicated new line
>>   mtd: spi-nor: Drop spansion_quad_enable()
>>   mtd: spi-nor: Fix errno on quad_enable methods
>>   mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
>>   mtd: spi-nor: Rework macronix_quad_enable()
>>   mtd: spi-nor: Rework spansion(_no)_read_cr_quad_enable()
>>   mtd: spi-nor: Update sr2_bit7_quad_enable()
>>   mtd: spi-nor: Rework the disabling of block write protection
>>   mtd: spi-nor: Add Global Block Unlock support
>>   mtd: spi-nor: Unlock global block protection on sst26vf064b
> 
> With whole series applied, I see:
> 
> drivers/mtd/spi-nor/spi-nor.c:520: warning: Function parameter or member 'cr' not described in 'spi_nor_read_cr'
> drivers/mtd/spi-nor/spi-nor.c:520: warning: Excess function parameter 'fsr' description in 'spi_nor_read_cr'
> drivers/mtd/spi-nor/spi-nor.c:742: warning: Function parameter or member 'len' not described in 'spi_nor_write_sr'
> drivers/mtd/spi-nor/spi-nor.c:889: warning: Function parameter or member 'status_new' not described in 'spi_nor_write_sr1_and_check'
> drivers/mtd/spi-nor/spi-nor.c:889: warning: Function parameter or member 'mask' not described in 'spi_nor_write_sr1_and_check'
> drivers/mtd/spi-nor/spi-nor.c:923: warning: Function parameter or member 'status_new' not described in 'spi_nor_write_16bit_sr_and_check'
> drivers/mtd/spi-nor/spi-nor.c:923: warning: Function parameter or member 'mask' not described in 'spi_nor_write_16bit_sr_and_check'
> drivers/mtd/spi-nor/spi-nor.c:997: warning: Function parameter or member 'status_new' not described in 'spi_nor_write_sr_and_check'
> drivers/mtd/spi-nor/spi-nor.c:997: warning: Function parameter or member 'mask' not described in 'spi_nor_write_sr_and_check'
> 
> Could you please fix up docs next time around?

I'll fix these, thanks!

I've just compiled the code and I can't see the warnings. What should I do to
get these warnings?

Thanks,
ta

> 
> Regards
> Vignesh
>>
>>  drivers/mtd/spi-nor/aspeed-smc.c      |   23 +-
>>  drivers/mtd/spi-nor/cadence-quadspi.c |   54 +-
>>  drivers/mtd/spi-nor/hisi-sfc.c        |   23 +-
>>  drivers/mtd/spi-nor/intel-spi.c       |   24 +-
>>  drivers/mtd/spi-nor/mtk-quadspi.c     |   25 +-
>>  drivers/mtd/spi-nor/nxp-spifi.c       |   23 +-
>>  drivers/mtd/spi-nor/spi-nor.c         | 1697 ++++++++++++++++++---------------
>>  include/linux/mtd/spi-nor.h           |   75 +-
>>  8 files changed, 1050 insertions(+), 894 deletions(-)
>>
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> 

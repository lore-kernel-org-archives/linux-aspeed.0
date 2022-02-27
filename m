From: Cédric Le Goater <clg@kaod.org>
Date: Sun, 27 Feb 2022 22:27:52 +0100
Subject: [PATCH 08/10] spi: aspeed: Calibrate read timings
In-Reply-To: <20220225091809.gvup3mcst45szi6x@ti.com>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-9-clg@kaod.org>
 <20220225091809.gvup3mcst45szi6x@ti.com>
Message-ID: <890fce14-8001-74c9-21a9-0de117e743ef@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/25/22 10:18, Pratyush Yadav wrote:
> On 14/02/22 10:42AM, C?dric Le Goater wrote:
>> To accommodate the different response time of SPI transfers on different
>> boards and different SPI NOR devices, the Aspeed controllers provide a
>> set of Read Timing Compensation registers to tune the timing delays
>> depending on the frequency being used. The AST2600 SoC has one of
>> these registers per device. On the AST2500 and AST2400 SoCs, the
>> timing register is shared by all devices which is a bit problematic to
>> get good results other than for one device.
>>
>> The algorithm first reads a golden buffer at low speed and then performs
>> reads with different clocks and delay cycle settings to find a breaking
>> point. This selects a default good frequency for the CEx control register.
>> The current settings are bit optimistic as we pick the first delay giving
>> good results. A safer approach would be to determine an interval and
>> choose the middle value.
>>
>> Due to the lack of API, calibration is performed when the direct mapping
>> for reads is created.
> 
> The dirmap_create mapping says nothing about _when_ it should be called.
> So there is no guarantee that it will only be called after the flash is
> fully initialized. 

spi_nor_create_read_dirmap() is called after spi_nor_scan() in spi_nor_probe().
Since a spi_mem_dirmap_info descriptor is created using the nor fields :

	struct spi_mem_dirmap_info info = {
		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
		.offset = 0,
		.length = nor->params->size,
	};
	struct spi_mem_op *op = &info.op_tmpl;

the spi-mem framework makes the assumption that the nor object is initialized.

> I suggest you either make this a requirement of the API,

how ?

Thanks,

C.


> or create a new API that guarantees it will only be called after
> the flash is initialized, like [0].
> 
> [0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210311191216.7363-2-p.yadav at ti.com/
> 
>>
>> Cc: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>> ---
> 


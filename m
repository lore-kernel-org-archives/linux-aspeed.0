From: Cédric Le Goater <clg@kaod.org>
Date: Sun, 8 May 2022 09:14:52 +0200
Subject: [PATCH v6 03/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
In-Reply-To: <YnFseFBfe5eaIqg0@robh.at.kernel.org>
References: <20220503060634.122722-1-clg@kaod.org>
 <20220503060634.122722-4-clg@kaod.org> <YnFseFBfe5eaIqg0@robh.at.kernel.org>
Message-ID: <4af36c47-0895-bce4-b074-c934749e6faf@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/3/22 19:55, Rob Herring wrote:
> On Tue, May 03, 2022 at 08:06:26AM +0200, C?dric Le Goater wrote:
>> This SPI driver adds support for the Aspeed static memory controllers
>> of the AST2600, AST2500 and AST2400 SoCs using the spi-mem interface.
>>
>>   * AST2600 Firmware SPI Memory Controller (FMC)
>>     . BMC firmware
>>     . 3 chip select pins (CE0 ~ CE2)
>>     . Only supports SPI type flash memory
>>     . different segment register interface
>>     . single, dual and quad mode.
>>
>>   * AST2600 SPI Flash Controller (SPI1 and SPI2)
>>     . host firmware
>>     . 2 chip select pins (CE0 ~ CE1)
>>     . different segment register interface
>>     . single, dual and quad mode.
>>
>>   * AST2500 Firmware SPI Memory Controller (FMC)
>>     . BMC firmware
>>     . 3 chip select pins (CE0 ~ CE2)
>>     . supports SPI type flash memory (CE0-CE1)
>>     . CE2 can be of NOR type flash but this is not supported by the driver
>>     . single, dual mode.
>>
>>   * AST2500 SPI Flash Controller (SPI1 and SPI2)
>>     . host firmware
>>     . 2 chip select pins (CE0 ~ CE1)
>>     . single, dual mode.
>>
>>   * AST2400 New Static Memory Controller (also referred as FMC)
>>     . BMC firmware
>>     . New register set
>>     . 5 chip select pins (CE0 ? CE4)
>>     . supports NOR flash, NAND flash and SPI flash memory.
>>     . single, dual and quad mode.
>>
>> Each controller has a memory range on which flash devices contents are
>> mapped. Each device is assigned a window that can be changed at bootime
>> with the Segment Address Registers.
>>
>> Each SPI flash device can then be accessed in two modes: Command and
>> User. When in User mode, SPI transfers are initiated with accesses to
>> the memory segment of a device. When in Command mode, memory
>> operations on the memory segment of a device generate SPI commands
>> automatically using a Control Register for the settings.
>>
>> This initial patch adds support for User mode. Command mode needs a little
>> more work to check that the memory window on the AHB bus fits the device
>> size. It will come later when support for direct mapping is added.
>>
>> Single and dual mode RX transfers are supported. Other types than SPI
>> are not supported.
>>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Tao Ren <rentao.bupt@gmail.com>
>> Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>> ---
>>   drivers/mtd/spi-nor/controllers/aspeed-smc.c  | 921 ------------------
>>   drivers/spi/spi-aspeed-smc.c                  | 717 ++++++++++++++
>>   .../devicetree/bindings/mtd/aspeed-smc.txt    |  51 -
> 
> This belongs with the binding patch. But then it is converting rather
> than adding a binding. You should be converting the binding and then
> adding to it (like adding 2600 support).

OK.

So, I will send, some time next week, a v7 patchset updating the binding
patch 02/11 to include the removal of the old binding.

Thanks,

C.

> 
>>   MAINTAINERS                                   |   1 +
>>   drivers/mtd/spi-nor/controllers/Kconfig       |  10 -
>>   drivers/mtd/spi-nor/controllers/Makefile      |   1 -
>>   drivers/spi/Kconfig                           |  11 +
>>   drivers/spi/Makefile                          |   1 +
>>   8 files changed, 730 insertions(+), 983 deletions(-)
>>   delete mode 100644 drivers/mtd/spi-nor/controllers/aspeed-smc.c
>>   create mode 100644 drivers/spi/spi-aspeed-smc.c
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/aspeed-smc.txt


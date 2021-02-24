From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 24 Feb 2021 11:17:16 -0800
Subject: [PATCH v4 0/4] i2c: aspeed: Add buffer and DMA modes support
Message-ID: <20210224191720.7724-1-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series adds buffer mode and DMA mode transfer support for the
Aspeed I2C driver. With this change, buffer mode and DMA mode can be
selectively used depend on platform configuration.

* Buffer mode
  AST2400:
    It has 2 KBytes (256 Bytes x 8 pages) of I2C SRAM buffer pool from
    0x1e78a800 to 0x1e78afff that can be used for all busses with
    buffer pool manipulation. To simplify implementation for supporting
    both AST2400 and AST2500, it assigns each 128 Bytes per bus without
    using buffer pool manipulation so total 1792 Bytes of I2C SRAM
    buffer will be used.

  AST2500:
    It has 16 Bytes of individual I2C SRAM buffer per each bus and its
    range is from 0x1e78a200 to 0x1e78a2df, so it doesn't have 'buffer
    page selection' bit field in the Function control register, and
    neither 'base address pointer' bit field in the Pool buffer control
    register it has. To simplify implementation for supporting both
    AST2400 and AST2500, it writes zeros on those register bit fields
    but it's okay because it does nothing in AST2500.

  AST2600:
    It has 32 Bytes of individual I2C SRAM buffer per each bus and its
    range is from 0x1e78ac00 to 0x1e78adff. Works just like AST2500
    does.

* DMA mode
  Only AST2500 and later versions support DMA mode under some limitations
  in case of AST2500:
    I2C is sharing the DMA H/W with UHCI host controller and MCTP
    controller. Since those controllers operate with DMA mode only, I2C
    has to use buffer mode or byte mode instead if one of those
    controllers is enabled. Also make sure that if SD/eMMC or Port80
    snoop uses DMA mode instead of PIO or FIFO respectively, I2C can't
    use DMA mode.

Please review it.

Changes since v3:
- Added a comment to explain SRAM buffer handling logic.

Changes since v2:
- Added SRAM resources back to default dtsi and added mode selection
  property.
- Refined SoC family dependent xfer mode configuration functions.

Changes since v1:
V1: https://lore.kernel.org/linux-arm-kernel/20191007231313.4700-1-jae.hyun.yoo at linux.intel.com/
- Removed a bug fix patch which was merged already from this patch series. 
- Removed buffer reg settings from default device tree and added the settings
  into bindings document to show the predefined buffer range per each bus.
- Updated commit message and comments.
- Refined driver code using abstract functions.

Jae Hyun Yoo (4):
  dt-bindings: i2c: aspeed: add transfer mode support
  ARM: dts: aspeed: modify I2C node to support buffer mode
  i2c: aspeed: add buffer mode transfer support
  i2c: aspeed: add DMA mode transfer support

 .../devicetree/bindings/i2c/i2c-aspeed.txt    |  37 +-
 arch/arm/boot/dts/aspeed-g4.dtsi              |  47 +-
 arch/arm/boot/dts/aspeed-g5.dtsi              |  47 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |  32 +-
 drivers/i2c/busses/i2c-aspeed.c               | 641 ++++++++++++++++--
 5 files changed, 688 insertions(+), 116 deletions(-)

-- 
2.17.1


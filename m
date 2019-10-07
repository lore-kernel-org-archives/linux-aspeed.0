From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon,  7 Oct 2019 16:13:08 -0700
Subject: [PATCH 0/5] i2c: aspeed: Add buffer and DMA modes support
Message-ID: <20191007231313.4700-1-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series adds buffer mode and DMA mode transfer support for the
Aspeed I2C driver. With this change, default transfer mode will be set to
buffer mode for better performance, and DMA mode can be selectively used
depends on platform configuration.

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

* DMA mode
  Only AST2500 and later versions support DMA mode under some limitations:
    I2C is sharing the DMA H/W with UHCI host controller and MCTP
    controller. Since those controllers operate with DMA mode only, I2C
    has to use buffer mode or byte mode instead if one of those
    controllers is enabled. Also make sure that if SD/eMMC or Port80
    snoop uses DMA mode instead of PIO or FIFO respectively, I2C can't
    use DMA mode.

Please review it.

-Jae

Jae Hyun Yoo (5):
  dt-bindings: i2c: aspeed: add buffer and DMA mode transfer support
  ARM: dts: aspeed: add I2C buffer mode support
  i2c: aspeed: fix master pending state handling
  i2c: aspeed: add buffer mode transfer support
  i2c: aspeed: add DMA mode transfer support

 .../devicetree/bindings/i2c/i2c-aspeed.txt    |  67 ++-
 arch/arm/boot/dts/aspeed-g4.dtsi              |  47 +-
 arch/arm/boot/dts/aspeed-g5.dtsi              |  47 +-
 drivers/i2c/busses/i2c-aspeed.c               | 513 ++++++++++++++++--
 4 files changed, 588 insertions(+), 86 deletions(-)

-- 
2.23.0


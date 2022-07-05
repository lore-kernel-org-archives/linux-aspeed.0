From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 5 Jul 2022 10:09:31 +0800
Subject: [PATCH v7 0/5] Add Aspeed crypto driver for hardware acceleration
Message-ID: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aspeed Hash and Crypto Engine (HACE) is designed to accelerate the
throughput of hash data digest, encryption and decryption.

These patches aim to add Aspeed hash & crypto driver support.
The hash & crypto driver also pass the run-time self tests that
take place at algorithm registration.

The patch series are tested on both AST2500 & AST2600 evaluation boards.

Tested-by below configs:
- CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
- CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
- CONFIG_DMA_API_DEBUG=y
- CONFIG_DMA_API_DEBUG_SG=y
- CONFIG_CPU_BIG_ENDIAN=y

Change since v6:
- Refine debug print.
- Change aspeed_sg_list struct memeber's type to __le32.

Change since v5:
- Re-define HACE clock define to fix breaking ABI.

Change since v4:
- Add AST2500 clock definition & dts node.
- Add software fallback for handling corner cases.
- Fix copy wrong key length.

Change since v3:
- Use dmam_alloc_coherent() instead to manage dma_alloc_coherent().
- Add more error handler of dma_prepare() & crypto_engine_start().

Change since v2:
- Fix endianness issue. Tested on both little endian & big endian
  system.
- Use common crypto hardware engine for enqueue & dequeue requests.
- Use pre-defined IVs for SHA-family.
- Revise error handler flow.
- Fix sorts of coding style problems.

Change since v1:
- Add more error handlers, including DMA memory allocate/free, DMA
  map/unmap, clock enable/disable, etc.
- Fix check dma_map error for config DMA_API_DEBUG.
- Fix dt-binding doc & dts node naming.


Neal Liu (5):
  crypto: aspeed: Add HACE hash driver
  dt-bindings: clock: Add AST2500/AST2600 HACE reset definition
  ARM: dts: aspeed: Add HACE device controller node
  dt-bindings: crypto: add documentation for aspeed hace
  crypto: aspeed: add HACE crypto driver

 .../bindings/crypto/aspeed,ast2500-hace.yaml  |   53 +
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |    8 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |    8 +
 drivers/crypto/Kconfig                        |    1 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/aspeed/Kconfig                 |   40 +
 drivers/crypto/aspeed/Makefile                |    9 +
 drivers/crypto/aspeed/aspeed-hace-crypto.c    | 1121 +++++++++++++
 drivers/crypto/aspeed/aspeed-hace-hash.c      | 1428 +++++++++++++++++
 drivers/crypto/aspeed/aspeed-hace.c           |  302 ++++
 drivers/crypto/aspeed/aspeed-hace.h           |  293 ++++
 include/dt-bindings/clock/aspeed-clock.h      |    1 +
 include/dt-bindings/clock/ast2600-clock.h     |    1 +
 14 files changed, 3273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
 create mode 100644 drivers/crypto/aspeed/Kconfig
 create mode 100644 drivers/crypto/aspeed/Makefile
 create mode 100644 drivers/crypto/aspeed/aspeed-hace-crypto.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace.h

-- 
2.25.1


From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 6 Jun 2022 14:49:30 +0800
Subject: [PATCH v2 0/5] Add Aspeed crypto driver for hardware acceleration
Message-ID: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
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

Tested-by below configs:
- CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
- CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
- CONFIG_DMA_API_DEBUG=y
- CONFIG_DMA_API_DEBUG_SG=y

Change since v1:
- Add more error handlers, including DMA memory allocate/free, DMA
  map/unmap, clock enable/disable, etc.
- Fix check dma_map error for config DMA_API_DEBUG
- Fix dt-binding doc & dts node naming


Neal Liu (5):
  crypto: aspeed: Add HACE hash driver
  dt-bindings: clock: Add AST2600 HACE reset definition
  ARM: dts: aspeed: Add HACE device controller node
  dt-bindings: crypto: add documentation for aspeed hace
  crypto: aspeed: add HACE crypto driver

 .../bindings/crypto/aspeed,ast2500-hace.yaml  |   53 +
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |    8 +
 drivers/crypto/Kconfig                        |    1 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/aspeed/Kconfig                 |   38 +
 drivers/crypto/aspeed/Makefile                |    8 +
 drivers/crypto/aspeed/aspeed-hace-crypto.c    | 1028 ++++++++++++
 drivers/crypto/aspeed/aspeed-hace-hash.c      | 1409 +++++++++++++++++
 drivers/crypto/aspeed/aspeed-hace.c           |  350 ++++
 drivers/crypto/aspeed/aspeed-hace.h           |  292 ++++
 include/dt-bindings/clock/ast2600-clock.h     |    1 +
 12 files changed, 3196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
 create mode 100644 drivers/crypto/aspeed/Kconfig
 create mode 100644 drivers/crypto/aspeed/Makefile
 create mode 100644 drivers/crypto/aspeed/aspeed-hace-crypto.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
 create mode 100644 drivers/crypto/aspeed/aspeed-hace.h

-- 
2.25.1


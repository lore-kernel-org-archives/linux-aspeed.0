From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 2 Sep 2022 14:00:08 +0800
Subject: [PATCH v1 0/4] Add Aspeed ACRY driver for hardware acceleration
Message-ID: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aspeed ACRY engine is designed to accelerate the throughput of
ECDSA/RSA signature and verification.

These patches aim to add Aspeed ACRY RSA driver support.
This driver also pass the run-time self tests that take place at
algorithm registration on both big-endian/little-endian system
in AST2600 evaluation board .

Tested-by below configs:
- CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
- CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
- CONFIG_DMA_API_DEBUG=y
- CONFIG_DMA_API_DEBUG_SG=y
- CONFIG_CPU_BIG_ENDIAN=y

Neal Liu (4):
  crypto: aspeed: Add ACRY RSA driver
  ARM: dts: aspeed: Add ACRY/AHBC device controller node
  dt-bindings: crypto: add documentation for Aspeed ACRY
  dt-bindings: bus: add documentation for Aspeed AHBC

 .../bindings/bus/aspeed,ast2600-ahbc.yaml     |  39 +
 .../bindings/crypto/aspeed,ast2600-acry.yaml  |  49 +
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |  13 +
 drivers/crypto/aspeed/Kconfig                 |  11 +
 drivers/crypto/aspeed/Makefile                |   5 +-
 drivers/crypto/aspeed/aspeed-acry.c           | 848 ++++++++++++++++++
 7 files changed, 965 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
 create mode 100644 drivers/crypto/aspeed/aspeed-acry.c

-- 
2.25.1


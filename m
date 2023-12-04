From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Mon,  4 Dec 2023 13:41:29 +0800
Subject: [PATCH v4 0/2] Add Facebook Minerva Harma (AST2600) BMC
Message-ID: <20231204054131.1845775-1-peter.yin@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peter Yin <peteryin.openbmc@gmail.com>

Summary:
Add linux device tree entry related to Minerva Harma
specific devices connected to BMC SoC.

v3:https://lore.kernel.org/all/20231123050415.3441429-3-peteryin.openbmc at gmail.com/
v2:https://lore.kernel.org/all/cdbc75b9-3be1-4017-9bee-c8f161b6843c at linaro.org/
v1:https://lore.kernel.org/all/20231024082404.735843-3-peteryin.openbmc at gmail.com/

Change log
v3 -> v4
  - Add SGPIO line name

v2 -> v3:
  - Fixed led schema
  - Fixed i2c mux schema
  - Add BMC_READY and SGPIO_READY

v1 -> v2:
  - Add Power sensors
  - Modify ehci number
  - Add Led
  - Modify SGPIO line-name
v1:
  - Create minerva harma dts file.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
Peter Yin (2):
  dt-bindings: arm: aspeed: add Meta Minerva Harma board
  ARM: dts: aspeed: Minerva Harma: Add Facebook Minerva Harma (AST2600)
    BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 595 ++++++++++++++++++
 3 files changed, 597 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

-- 
2.25.1


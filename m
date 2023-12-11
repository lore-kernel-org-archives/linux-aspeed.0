From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 00:26:53 +0800
Subject: [PATCH v7 0/2] Add Meta(Facebook) Harma BMC(AST2600)
Message-ID: <20231211162656.2564267-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Summary:
Add linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

v6:https://lore.kernel.org/all/20231206155316.4181813-3-peteryin.openbmc at gmail.com/
v5:https://lore.kernel.org/all/20231204081029.2272626-3-peteryin.openbmc at gmail.com/
v4:https://lore.kernel.org/all/20231204054131.1845775-3-peter.yin at quantatw.com/
v3:https://lore.kernel.org/all/20231123050415.3441429-3-peteryin.openbmc at gmail.com/
v2:https://lore.kernel.org/all/cdbc75b9-3be1-4017-9bee-c8f161b6843c at linaro.org/
v1:https://lore.kernel.org/all/20231024082404.735843-3-peteryin.openbmc at gmail.com/

Change log

v6 -> v7
  - Remove mac3 and vuart unsue property.
  - Rename the GPIO line name to match OpenBMC naming style.

v5 -> v6
  - Add Retimer eeprom
  - Add Power Led
  - Add GPIO/SGPIO Line Name

v4 -> v5
  - Rename document and file from minerva-harma to harma. 
  - remove Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
v3 -> v4
  - Add SGPIO line name.

v2 -> v3:
  - Fixed led schema.
  - Fixed i2c mux schema.
  - Add BMC_READY and SGPIO_READY.

v1 -> v2:
  - Add Power sensors.
  - Modify ehci number.
  - Add Led.
  - Modify SGPIO line-name.
v1:
  - Create minerva harma dts file.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
Peter Yin (2):
  dt-bindings: arm: aspeed: add Meta Harma board
  ARM: dts: aspeed: Harma: Add Meta Harma (AST2600) BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 585 ++++++++++++++++++
 3 files changed, 587 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

-- 
2.25.1


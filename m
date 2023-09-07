From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Thu,  7 Sep 2023 14:45:11 +0800
Subject: [PATCH v9 0/2] Add Facebook Minerva (AST2600) BMC
Message-ID: <20230907064514.1764010-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Summary:
Add linux device tree entry related to Minerva
specific devices connected to BMC SoC.

Change log:
v1 link : https://lore.kernel.org/all/fb09f5e6-8381-312f-2f1e-f2b471cec68a at linaro.org/
v2 link : https://lore.kernel.org/lkml/9f499fe5-db59-f4c8-6a50-93725b7287fd at linaro.org/
v3 link : https://lore.kernel.org/lkml/20230830025133.3756506-1-peteryin.openbmc at gmail.com/
v4 link : https://lore.kernel.org/all/1d531692-5455-fbfd-0775-50856bf0fbc7 at linaro.org/
v5 link : https://lore.kernel.org/all/5347163b-c225-d805-d851-fe28e6b57c56 at gmail.com/
v6 link : https://lore.kernel.org/all/20230831072048.3966398-2-peteryin.openbmc at gmail.com/
v7 link : https://lore.kernel.org/lkml/20230831082819.4000425-3-peteryin.openbmc at gmail.com/
v8 link : https://lore.kernel.org/all/136c0434-a588-877e-54e5-dd1078ff94a3 at gmail.com/

v8->v9:
  - Remove dts jtag1.
  - Remove blank line between tags.

v7->v8:
  - Fixed dts path

v6->v7:
  - Change order before aspeed-bmc-facebook-minipack.dtb

v5->v6:
  - Correcting the arrangement order in Makefile.

v4->v5:
  - Remove redundant blank line.
  - Correcting the arrangement order in document.

v3->v4:
  - Seprate dts document.

v2->v3:
  - Fixed commit description.
  - Add sgpio line name to sgpioP.
  - Add ipmb debug card bus.

v1->v2:
  - Add facebook,minerva-bmc in aspeed.yaml
  - Use stdout-path
  - Add Makefile

v1:
  - Create minerva dts file.

Peter Yin (2):
  ARM: dts: aspeed: Minerva: Add Facebook Minerva (AST2600) BMC
  dt-bindings: arm: aspeed: add Meta Minerva board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 377 ++++++++++++++++++
 3 files changed, 379 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts

-- 
2.25.1


From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 25 Jul 2024 00:48:16 +0800
Subject: [PATCH v4 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Message-ID: <20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v4:
- change back io_expanderX due to parser error, build passed in v4 version.
- Link to v3: https://lore.kernel.org/r/20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc at gmail.com

Changes in v3:
- rename tmp75 nodes to temperature-sensor
- rename tmp421 nodes to temperature-sensor
- rename ina230 nodes to power-sensor
- rename io_expanderX nodes to io-expanderX
- Link to v2: https://lore.kernel.org/r/20240724-potin-catalina-dts-v2-0-ba8d475c4073 at gmail.com

Changes in v2:
- drop commented code in dts
- rename i2c-mux channel nodes as i2c1muxXchY
- rename gpio expander as io_expanderX
- use "stdout-path" instead of "bootargs"
- Link to v1: https://lore.kernel.org/all/20240722145857.2131100-1-potin.lai.pt at gmail.com/

---
Potin Lai (2):
      dt-bindings: arm: aspeed: add Meta Catalina board
      ARM: dts: aspeed: catalina: add Meta Catalina BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1020 ++++++++++++++++++++
 3 files changed, 1022 insertions(+)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-potin-catalina-dts-fda1ea3297b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


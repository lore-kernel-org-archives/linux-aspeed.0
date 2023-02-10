From: Jordan Chang <jordan.chang@ufispace.com>
Date: Fri, 10 Feb 2023 13:54:48 +0800
Subject: [PATCH v3 0/3] Add Ufispace NCPLite platform device tree
Message-ID: <20230210055451.72153-1-jordan.chang@ufispace.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes for v3:
- add "Acked-by: Krzysztof Kozlowski"

Changes for v2:
- modify node name to generic one and check with dtbs_check
- send-email without confidential mode

Jordan Chang (3):
  dt-bindings: vendor-prefixes: Add prefix for Ufi Space
  dt-bindings: arm: aspeed: document Ufispace NCPLite
  ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 359 ++++++++++++++++++
 4 files changed, 363 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts

-- 
2.39.0


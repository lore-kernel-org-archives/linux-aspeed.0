From: Renze Nicolai <renze@rnplus.nl>
Date: Sat,  2 Dec 2023 01:38:43 +0100
Subject: [PATCH v3 0/2] ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
Message-ID: <20231202003908.3635695-1-renze@rnplus.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

These patches add a device-tree (and a bindings update) for the
Aspeed BMC on the ASRock X570D4U, so that it can be added as a
supported OpenBMC platform.

Changes since v2:
  - Renamed leds to led-0 and led-1 to match Documentation/devicetree/bindings/leds/leds-gpio.yaml
  - Added aliasses and labels for the i2c-mux on i2c bus 4
  - Added the missing blank line between the ehci1 and uhci nodes

Greetings,
Renze Nicolai

Renze Nicolai (2):
  dt-bindings: arm: aspeed: add Asrock X570D4U board
  ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 377 ++++++++++++++++++
 3 files changed, 379 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts

-- 
2.43.0


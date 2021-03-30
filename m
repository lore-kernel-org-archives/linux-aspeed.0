From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 29 Mar 2021 19:23:35 -0500
Subject: [PATCH 0/3] simplify Aspeed VUART SIRQ polarity DT config,
 add e3c246d4i BMC dts
Message-ID: <20210330002338.335-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series reworks the existing aspeed,sirq-polarity-sense DT
property as a simple boolean (aspeed,sirq-active-high) so as to
disentangle the interrupt polarity from the eSPI/LPC strapping and
updates the documentation accordingly.

The third patch adds an in-tree consumer of this property
(aspeed,sirq-polarity-sense never really had one) in the form of a
device tree for the ASRock E3C246D4I BMC, an OpenBMC target in
progress at Equinix Metal (formerly known as Packet).


Zev Weiss (3):
  drivers/tty/serial/8250: simplify Aspeed VUART SIRQ polarity DT config
  dt-bindings: serial: 8250: update for aspeed,sirq-active-high
  ARM: dts: aspeed: add ASRock E3C246D4I BMC

 .../devicetree/bindings/serial/8250.yaml      |  14 +-
 .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 188 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c   |  39 +---
 drivers/tty/serial/8250/Kconfig               |   1 -
 4 files changed, 196 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts

-- 
2.31.1


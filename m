From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 09:59:58 -0500
Subject: [PATCH 00/22] ARM: dts: aspeed: Updates for Rainier and Everest
 machines
Message-ID: <20210329150020.13632-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series updates the device trees for the Rainier and Everest system
BMCs. For Rainier, the changes have been tested fairly extensively in
hardware. Everest has largely been tested in simulation and some basic
hardware verification testing.

Alpana Kumari (3):
  ARM: dts: aspeed: rainier: Add presence GPIOs
  ARM: dts: aspeed: everest: GPIOs support
  ARM: dts: aspeed: rainier: Support pass 2 planar

Brandon Wyman (2):
  ARM: dts: aspeed: rainier: Add gpio-keys-polled for fans
  ARM: dts: aspeed: everest: Add power supply i2c devices

Eddie James (7):
  ARM: dts: aspeed: rainier: Add additional processor CFAMs
  ARM: dts: aspeed: rainier: Enable fan watchdog
  ARM: dts: aspeed: rainier 4U: Fix fan configuration
  ARM: dts: Aspeed: Everest: Add FSI CFAMs and re-number engines
  ARM: dts: Aspeed: Everest: Add RTC
  ARM: dts: aspeed: everest: Enable fan watchdog
  ARM: dts: aspeed: Add Rainier 1S4U machine

Jim Wright (1):
  ARM: dts: aspeed: everest: Add UCD90320 power sequencer

Matthew Barth (2):
  ARM: dts: Aspeed: Everest: Add max31785 fan controller device
  ARM: dts: Aspeed: Everest: Add pca9552 fan presence

PriyangaRamasamy (1):
  ARM: dts: aspeed: Everest: Add I2C components

Vishwanatha Subbanna (6):
  ARM: dts: aspeed: rainier: Add Operator Panel LEDs
  ARM: dts: aspeed: rainier: Add directly controlled LEDs
  ARM: dts: aspeed: rainier: Add leds that are off PCA9552
  ARM: dts: aspeed: rainier: Add leds that are off pic16f882
  ARM: dts: aspeed: rainier: Add leds on optional DASD cards
  ARM: dts: aspeed: rainier: Add leds on optional PCI cable cards

 arch/arm/boot/dts/Makefile                    |    3 +
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  | 1770 +++++++++++-
 .../boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts  |   14 +
 .../boot/dts/aspeed-bmc-ibm-rainier-4u-v2.dts |  198 ++
 .../boot/dts/aspeed-bmc-ibm-rainier-4u.dts    |   14 +
 .../boot/dts/aspeed-bmc-ibm-rainier-v2.dts    |  198 ++
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  | 2367 +++++++++++++++--
 7 files changed, 4290 insertions(+), 274 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u-v2.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-v2.dts

-- 
2.27.0


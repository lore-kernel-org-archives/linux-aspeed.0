From: Eddie James <eajames@linux.ibm.com>
Date: Fri,  3 Sep 2021 16:48:34 -0500
Subject: [PATCH 0/2] ARM: dts: aspeed: p10 i2c and leds additions
Message-ID: <20210903214836.48286-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add I2C mux devices to the Everest system, and add all the PCA-chip
attached LEDs to the Rainier system.

Eddie James (2):
  ARM: dts: aspeed: rainier: Add system LEDs
  ARM: dts: aspeed: everest: Add I2C bus 15 muxes

 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts |  158 +++
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 1133 +++++++++++++++++-
 2 files changed, 1279 insertions(+), 12 deletions(-)

-- 
2.27.0


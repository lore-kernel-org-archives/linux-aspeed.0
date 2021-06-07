From: Joel Stanley <joel@jms.id.au>
Date: Mon,  7 Jun 2021 12:42:53 +0930
Subject: [PATCH 0/6] ARM: dts: aspeed: Add Everest LED descriptions
Message-ID: <20210607031259.475020-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This describes the various status LEDs attached to expanders on the
Everest system.

Vishwanatha Subbanna (6):
  ARM: dts: aspeed: everest: Add system level indicator leds
  ARM: dts: aspeed: everest: Add nvme and fan indicator leds
  ARM: dts: aspeed: everest: Add pcie slot indicator leds
  ARM: dts: aspeed: everest: Add dimm indicator leds
  ARM: dts: aspeed: everest: Add vrm and other indicator leds
  ARM: dts: aspeed: everest: Add pcie cable card indicator leds

 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 1997 ++++++++++++++++--
 1 file changed, 1866 insertions(+), 131 deletions(-)

-- 
2.30.2


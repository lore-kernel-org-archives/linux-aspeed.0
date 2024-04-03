From: Renze Nicolai <renze@rnplus.nl>
Date: Wed,  3 Apr 2024 15:28:50 +0200
Subject: [PATCH v2 0/3] ARM: dts: Update devicetree of Asrock X570D4U BMC
Message-ID: <20240403133037.37782-1-renze@rnplus.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These patches change the GPIO table, ADC channel configuration and
I2C bus configuration of the devicetree for the X570D4U BMC as part of
ongoing efforts to support OpenBMC on this platform.

Changes since v1:
 - Fixed warnings indicated by checkpatch.pl
 - Change commit message of ADC channels commit to match imperative mood
 - Restructure GPIO table to better match other ASPEED devices
 - Clarify naming scheme better

Best regards,
Renze Nicolai

Renze Nicolai (3):
  ARM: dts: Modify GPIO table for Asrock X570D4U BMC
  ARM: dts: Disable unused ADC channels for Asrock X570D4U BMC
  ARM: dts: Modify I2C bus configuration

 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 131 ++++++++----------
 1 file changed, 57 insertions(+), 74 deletions(-)

-- 
2.44.0


From: Joel Stanley <joel@jms.id.au>
Date: Tue, 27 Jul 2021 13:03:17 +0930
Subject: [PATCH 0/2] ARM: dts: aspeed: Add TPM GPIO names
Message-ID: <20210727033319.473152-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These patches add GPIO line names for the TPM reset signals in the p10
bmc designs. The lines are documented in the tacoma, ingram and tola
schematics.

Joel Stanley (2):
  ARM: dts: rainier, everest: Add TPM reset GPIO
  ARM: dts: aspeed: tacoma: Add TPM reset GPIO

 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.32.0


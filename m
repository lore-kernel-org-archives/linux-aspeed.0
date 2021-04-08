From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 8 Apr 2021 09:52:16 +0800
Subject: [PATCH v1 0/2] mmc: sdhci-of-aspeed: Support toggling SD bus signal
Message-ID: <20210408015218.20560-1-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series implements support for toggling SD bus signal voltage by
GPIO pin.

This series has been tested on AST2600-A2 EVB with APLL and 200MHz HCLK
clock source with sdr104, sdr50, sdr25, sdr12 and high speed mode. 
This series were also be tested on AST2600-A1 EVB and AST2500 EVB that
don't have the design of signal voltage toggling by GPIO.

Please help to review.

Regards,
Steven

Steven Lee (2):
  dt-bindings: mmc: sdhci-of-aspeed: Add power-gpio and
    power-switch-gpio
  mmc: sdhci-of-aspeed: Support toggling SD bus signal voltage by GPIO

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |  25 +++
 drivers/mmc/host/sdhci-of-aspeed.c            | 155 ++++++++++++++++--
 2 files changed, 162 insertions(+), 18 deletions(-)

-- 
2.17.1


From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 23 Jul 2021 16:16:13 +0800
Subject: [v2 0/8] Add support for ast2600 ADC
Message-ID: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch serials make aspeed_adc.c can support ast2600.
In additional,
patch #6 is used to improve the adc accurate 
patch #7 is used to fix the clock issue in the original code.

Changes since v1:
dt-bindings:
  - Fix the aspeed,adc.yaml check error.
  - Add battery-sensing property.
aspeed_adc.c:
  - Change the init flow:
    Clock and reference voltage setting should be completed before adc
    engine enable.
  - Change the default sampling rate to meet most user case.
  - Add patch #8 to suppoert battery sensing mode.

Billy Tsai (8):
  dt-bindings: iio: adc: rename the aspeed adc yaml
  dt-bindings: iio: adc: Binding ast2600 adc.
  iio: adc: aspeed: completes the bitfield declare.
  iio: adc: aspeed: Allow driver to support ast2600
  iio: adc: aspeed: Add func to set sampling rate.
  iio: adc: aspeed: Add compensation phase.
  iio: adc: aspeed: Fix the calculate error of clock.
  iio: adc: aspeed: Support battery sensing.

 .../bindings/iio/adc/aspeed,adc.yaml          |  79 ++++
 .../bindings/iio/adc/aspeed,ast2400-adc.yaml  |  55 ---
 drivers/iio/adc/aspeed_adc.c                  | 376 ++++++++++++++----
 3 files changed, 385 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml

-- 
2.25.1


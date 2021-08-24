From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 24 Aug 2021 17:12:28 +0800
Subject: [RESEND v4 00/15] Add support for ast2600 ADC
Message-ID: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch serials make aspeed_adc.c can support ast2600 and backward
compatible.

RESEND due to miss some patches when sent patch v4.
Change since v3:
dt-bindings:
  - Fix properties:aspeed,int_vref_mv type error.

Change since v2:
dt-bindings:
  - Create a new dt-bindings for ast2600 adc
aspeed_adc.c:
  - Splits the patch for more details
  - Remove version enum and use the flags in model data to distinguish
  hardware feature
  - Support trimming data get and set.
  - Use devm_add_action_or_reset to simplify probe error handling.

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

Billy Tsai (15):
  dt-bindings: iio: adc: Add ast2600-adc bindings
  iio: adc: aspeed: completes the bitfield declare.
  iio: adc: aspeed: set driver data when adc probe.
  iio: adc: aspeed: Keep model data to driver data.
  iio: adc: aspeed: Refactory model data structure
  iio: adc: aspeed: Add vref config function
  iio: adc: aspeed: Set num_channels with model data
  iio: adc: aspeed: Use model_data to set clk scaler.
  iio: adc: aspeed: Use devm_add_action_or_reset.
  iio: adc: aspeed: Support ast2600 adc.
  iio: adc: aspeed: Fix the calculate error of clock.
  iio: adc: aspeed: Add func to set sampling rate.
  iio: adc: aspeed: Add compensation phase.
  iio: adc: aspeed: Support battery sensing.
  iio: adc: aspeed: Get and set trimming data.

 .../bindings/iio/adc/aspeed,ast2600-adc.yaml  |  97 +++
 drivers/iio/adc/aspeed_adc.c                  | 562 +++++++++++++++---
 2 files changed, 569 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml

-- 
2.25.1


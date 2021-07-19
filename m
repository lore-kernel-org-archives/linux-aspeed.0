From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 19 Jul 2021 16:06:00 +0800
Subject: [v1 0/7] Add support for ast2600 ADC
Message-ID: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch serials make aspeed_adc.c can support ast2600.
In additional,
patch #6 is used to improve the adc accurate and 
patch #7 is used to fix the clock issue in the original code.

Billy Tsai (7):
  dt-bindings: iio: adc: rename the aspeed adc yaml
  dt-bindings: iio: adc: Binding ast2600 adc.
  iio: adc: aspeed: completes the bitfield declare.
  iio: adc: aspeed: Allow driver to support ast2600
  iio: adc: aspeed: Add func to set sampling rate.
  iio: adc: aspeed: Add compensation phase.
  iio: adc: aspeed: Fix the calculate error of clock.

 ...speed,ast2400-adc.yaml => aspeed,adc.yaml} |  23 +-
 drivers/iio/adc/aspeed_adc.c                  | 313 ++++++++++++++----
 2 files changed, 266 insertions(+), 70 deletions(-)
 rename Documentation/devicetree/bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} (53%)

-- 
2.25.1


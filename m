From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 13 Oct 2020 18:32:42 +0800
Subject: [PATCH 0/3] Make driver compatible with ast2600
Message-ID: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ast2600 is a new generation of SoC from ASPEED.
The adc device in this generation adds some changes and features.
This patch series handles the changes below:
1. Define the new register fields.
2. Split into two individual IPs and each contains 8 voltage channels.
3. Remove the pre-scaler and extend the field length of the scaler.
4. Ref_voltage becomes configurable.

Billy Tsai (3):
  iio: adc: aspeed: Orgnaize and add the define of adc
  iio: adc: aspeed: Make driver compatible with ast2600
  iio: adc: aspeed: Setting ref_voltage in probe

 .../bindings/iio/adc/aspeed_adc.txt           |  16 +-
 drivers/iio/adc/aspeed_adc.c                  | 168 ++++++++++++++----
 2 files changed, 148 insertions(+), 36 deletions(-)

-- 
2.17.1


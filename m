From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 28 Feb 2022 07:02:37 +0700
Subject: [PATCH v1 0/5] Enable second flash,
 update gpios pin and merge adc channels
Message-ID: <20220228000242.1884-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset adds the second flash support, merge all ADC channels to
single iio-hwmon node and update various gpios pin name.

Link:https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

Quan Nguyen (5):
  ARM: dts: aspeed: mtjade: Enable secondary flash
  ARM: dts: aspeed: mtjade: Update rtc-battery-voltage-read-enable pin
  ARM: dts: aspeed: mtjade: Update host0-ready pin
  ARM: dts: aspeed: mtjade: Rename GPIO hog nodes to match schema.
  ARM: dts: aspeed: mtjade: Move all adc sensors into iio-hwmon node

 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

-- 
2.28.0


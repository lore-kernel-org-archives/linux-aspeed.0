From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Tue, 19 Oct 2021 13:01:52 +0700
Subject: [PATCH v2 0/3] Update gpios, nvme i2c busses and uefi partition
Message-ID: <20211019060155.945-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset adds gpios, i2c configuration busses for NVMe
slots and uefi spi nor partition for BMC on Mt.Jade hardware
reference platform.

v2: 
  + Added changes for NVMe slot i2c busses and uefi partition [Quan]

v1:
  + Add some gpios                                            [Quan]
  https://lore.kernel.org/r/all/20210917082945.19111-1-quan at os.amperecomputing.com

Quan Nguyen (3):
  ARM: dts: aspeed: mtjade: Add some gpios
  ARM: dts: aspeed: mtjade: Add I2C buses for NVMe devices
  ARM: dts: aspeed: mtjade: Add uefi partition

 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 288 +++++++++++++++++-
 1 file changed, 287 insertions(+), 1 deletion(-)

-- 
2.28.0


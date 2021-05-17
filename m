From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 17 May 2021 11:00:33 +0700
Subject: [PATCH 0/3] Add support PSU and OCP card on Mt. Jade BMC
Message-ID: <20210517040036.13667-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Mt. Jade BMC is an ASPEED AST2500-based BMC for the Mt. Jade
hardware reference platform with Ampere's Altra Processor family.
This series adds support PSU and OCP card on the Ampere's Mt. Jade BMC
and switch to use the 64MB flash layout as the 32MB layout will soon be
exhausted.

Quan Nguyen (3):
  ARM: dts: aspeed: mtjade: Enable OCP card support via NC-SI
  ARM: dts: aspeed: mtjade: Add PSU support
  ARM: dts: aspeed: mtjade: switch to 64MB flash layout

 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 57 +++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

-- 
2.28.0


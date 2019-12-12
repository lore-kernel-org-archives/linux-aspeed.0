From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu, 12 Dec 2019 15:16:20 -0800
Subject: [PATCH 0/2] ARM: dts: aspeed: delete no-hw-checksum from Facebook
 NetBMC dts
Message-ID: <20191212231622.302-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series is to delete "no-hw-checksum" from all Facebook Network
BMC platforms, because ftgmac100's checksum issue has been fixed by
commit 88824e3bf29a ("net: ethernet: ftgmac100: Fix DMA coherency issue
with SW checksum").

Patch #1 removes "no-hw-checksum" from Minipack and CMM BMCs (MAC-PHY
connection), and patch #2 deletes the property from Yamp BMC (MAC/NC-SI
connection).

Tao Ren (2):
  ARM: dts: aspeed: delete no-hw-checksum from Facebook NetBMC Common
    dtsi
  ARM: dts: aspeed: delete no-hw-checksum from yamp dts

 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts        | 1 -
 arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi | 1 -
 2 files changed, 2 deletions(-)

-- 
2.17.1


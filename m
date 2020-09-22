From: Joel Stanley <joel@jms.id.au>
Date: Tue, 22 Sep 2020 16:12:34 +0930
Subject: [PATCH] ARM: dts: aspeed: s2600wf: Fix VGA memory region location
Message-ID: <20200922064234.163799-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The VGA memory region is always from the top of RAM. On this board, that
is 0x80000000 + 0x20000000 - 0x01000000 = 0x9f000000.

This was not an issue in practice as the region is "reserved" by the
vendor's u-boot reducing the amount of available RAM, and the only user
is the host VGA device poking at RAM over PCIe. That is, nothing from
the ARM touches it.

It is worth fixing as developers copy existing device trees when
building their machines, and the XDMA driver does use the memory region
from the ARM side.

Fixes: c4043ecac34a ("ARM: dts: aspeed: Add S2600WF BMC Machine")
Reported-by: John Wang <wangzhiqiang.bj@bytedance.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
index 1deb30ec912c..6e9baf3bba53 100644
--- a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
@@ -22,9 +22,9 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
-		vga_memory: framebuffer at 7f000000 {
+		vga_memory: framebuffer at 9f000000 {
 			no-map;
-			reg = <0x7f000000 0x01000000>;
+			reg = <0x9f000000 0x01000000>; /* 16M */
 		};
 	};
 
-- 
2.28.0


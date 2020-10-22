From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Oct 2020 12:17:31 +1030
Subject: [PATCH v2 6/6] ARM: dts: tacoma: Add reserved memory for ramoops
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
Message-ID: <20201022014731.2035438-7-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Reserve a 1.5MiB region of memory to record kmsg dumps, console and
userspace message state into 16kiB ring-buffer slots. The sizing allows
for up to 16 dumps to be captured and read out.

Set max-reason to KMSG_DUMP_EMERG to capture bad-path reboots.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 09b561429579..04efabe70d9f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -34,6 +34,15 @@ flash_memory: region at b8000000 {
 
 		/* 48MB region from the end of flash to start of vga memory */
 
+		ramoops at bc000000 {
+			compatible = "ramoops";
+			reg = <0xbc000000 0x180000>; /* 16 * (3 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
 		/* VGA region is dictated by hardware strapping */
 		vga_memory: region at bf000000 {
 			no-map;
-- 
2.25.1


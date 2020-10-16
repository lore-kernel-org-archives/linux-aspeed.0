From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 16 Oct 2020 15:05:12 +1030
Subject: [PATCH 1/2] ARM: dts: rainier: Add reserved memory for ramoops
In-Reply-To: <20201016043513.119841-1-andrew@aj.id.au>
References: <20201016043513.119841-1-andrew@aj.id.au>
Message-ID: <20201016043513.119841-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Reserve a 1.5MiB region of memory to record kmsg dumps, console and
userspace message state into 16kiB ring-buffer slots. The sizing allows
for up to 32 dumps to be captured and read out.

Set max-reason to KMSG_DUMP_EMERG to capture bad-path reboots.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 183e1a4dcc65..89729ee698c5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -47,6 +47,15 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
+		ramoops at b7e80000 {
+			compatible = "ramoops";
+			reg = <0xb7e80000 0x180000>;
+			record-size = <0x4000>;
+			console-size = <0x4000>;
+			pmsg-size = <0x4000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
 		flash_memory: region at b8000000 {
 			no-map;
 			reg = <0xb8000000 0x04000000>; /* 64M */
-- 
2.25.1


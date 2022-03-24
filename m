From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 24 Mar 2022 17:59:16 +0100
Subject: [PATCH 1/3] Documentation/ABI: sysfs-driver-aspeed-uart-routing: Fix
 sphinx warning
In-Reply-To: <20220324165918.22005-1-hdegoede@redhat.com>
References: <20220324165918.22005-1-hdegoede@redhat.com>
Message-ID: <20220324165918.22005-2-hdegoede@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix the following warning from "make htmldocs":

Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing:2:
  WARNING: Inline emphasis start-string without end-string.

This is caused by the used of '*' in the example cat command,
mark the command as code to fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
index b363827da437..1e25cd2cacc1 100644
--- a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
+++ b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
@@ -8,9 +8,10 @@ Description:	Selects the RX source of the UARTx device.
 		selected option marked by brackets "[]". The list of available options
 		depends on the selected file.
 
-		e.g.
-		cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
-		[io1] io2 io3 io4 uart2 uart3 uart4 io6
+		e.g.::
+
+			# cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
+			[io1] io2 io3 io4 uart2 uart3 uart4 io6
 
 		In this case, UART1 gets its input from IO1 (physical serial port 1).
 
-- 
2.35.1


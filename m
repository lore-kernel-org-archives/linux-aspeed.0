From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 29 May 2019 13:10:04 -0500
Subject: [PATCH v3 4/8] Documentation: ABI: Add aspeed-xdma sysfs documentation
In-Reply-To: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1559153408-31190-5-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the pcidev sysfs attribute used by the aspeed-xdma driver.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma b/Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma
new file mode 100644
index 0000000..27189bbd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma
@@ -0,0 +1,11 @@
+What:		/sys/bus/platform/devices/1e6e7000.xdma/pcidev
+Date:		May 2019
+KernelVersion:	5.2
+Contact:	Eddie James <eajames@linux.ibm.com>
+Description:	When written, this file sets the PCI device that will be used
+		for DMA operations by the XDMA engine. When read, it provides
+		the current PCI device being used by the XDMA engine.
+		Valid values: vga or bmc.
+		Default vga, can be set by aspeed-xdma.pcidev= module
+		parameter.
+Users:		aspeed-xdma driver
-- 
1.8.3.1


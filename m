From: Corona, Ernesto <ernesto.corona@intel.com>
Date: Tue, 30 Jan 2024 23:32:33 +0000
Subject: [PATCH 30 6/7] Add JTAG core driver Maintainers
Message-ID: <LV8PR11MB846312B6C1F23325DACDF3778B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

JTAG class driver provide infrastructure to support hardware/software JTAG platform drivers. It provide user layer API interface for flashing and debugging external devices which equipped with JTAG interface using standard transactions.

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Luke Chen <luke_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rgrs <rgrs@protonmail.com>
---
MAINTAINERS | 13 +++++++++++++
1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..764732f1fe19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11532,6 +11532,19 @@ L:                linux-serial at vger.kernel.org
S:           Orphan
F:           drivers/tty/serial/jsm/
+JTAG SUBSYSTEM
+M:        Oleksandr Shamray <oleksandrs@mellanox.com>
+M:        Vadim Pasternak <vadimp@mellanox.com>
+M         Ernesto Corona <ernesto.corona@intel.com>
+M:        Omar Castro <omar.eduardo.castro@linux.intel.com>
+M:        Jiri Pirko <jiri@nvidia.com>
+S:          Maintained
+F:          Documentation/ABI/testing/jtag-dev
+F:          Documentation/devicetree/bindings/jtag/
+F:          drivers/jtag/
+F:          include/linux/jtag.h
+F:          include/uapi/linux/jtag.h
+
K10TEMP HARDWARE MONITORING DRIVER
M:         Clemens Ladisch <clemens@ladisch.de>
L:            linux-hwmon at vger.kernel.org
--
2.25.1
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240130/80a37789/attachment-0001.htm>

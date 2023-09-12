From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 12 Sep 2023 15:15:49 -0700
Subject: [PATCH v3 1/2] soc/aspeed: Add host side BMC device driver
In-Reply-To: <20230912220923.3701688-2-ninad@linux.ibm.com>
References: <20230912220923.3701688-1-ninad@linux.ibm.com>
 <20230912220923.3701688-2-ninad@linux.ibm.com>
Message-ID: <c3981a8d-de56-448d-adb5-6685530b85f7@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index f579ee0b5afa..8a4f096d84cd 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -52,6 +52,17 @@ config ASPEED_SOCINFO
 	help
 	  Say yes to support decoding of ASPEED BMC information.
 
+config ASPEED_HOST_BMC_DEV
+	bool "ASPEED SoC Host BMC device driver"
+	select SOC_BUS
+	default ARCH_ASPEED
+	depends on PCI
+	help
+	  Say yes to support PCIe based VUARTs from the host side. The end to
+          end VUART communication between host and BMC requires BMC side driver
+	  to activate VUART functionality. This is a driver for the BMC device
+          on host.

~~~
Please clean up that indentation. Consistently use one tab + 2 spaces,
as documented in coding-style.rst.

Also, can this be tristate instead of bool?  If not, why not?

Thanks.
-- 
~Randy

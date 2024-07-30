From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 30 Jul 2024 14:44:34 -0000
Subject: [PATCH 4/5] fsi: add missing MODULE_DESCRIPTION() macros
In-Reply-To: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
References: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
Message-ID: <20240730-module_description_orphans-v1-4-7094088076c8@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o

Add the missing invocations of the MODULE_DESCRIPTION() macro, and fix the
copy/paste of the module description comment in fsi-master-ast-cf.c.

Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/fsi/fsi-core.c          | 1 +
 drivers/fsi/fsi-master-aspeed.c | 1 +
 drivers/fsi/fsi-master-ast-cf.c | 3 ++-
 drivers/fsi/fsi-master-gpio.c   | 1 +
 drivers/fsi/fsi-master-hub.c    | 1 +
 drivers/fsi/fsi-scom.c          | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 46ac5a8beab7..e2e1e9df6115 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1444,5 +1444,6 @@ static void fsi_exit(void)
 }
 module_exit(fsi_exit);
 module_param(discard_errors, int, 0664);
+MODULE_DESCRIPTION("FSI core driver");
 MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(discard_errors, "Don't invoke error handling on bus accesses");
diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index b0b624c3717b..6f5e1bdf7e40 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -670,4 +670,5 @@ static struct platform_driver fsi_master_aspeed_driver = {
 };
 
 module_platform_driver(fsi_master_aspeed_driver);
+MODULE_DESCRIPTION("FSI master driver for AST2600");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index f8c776ce1b56..a4c37ff8edd6 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright 2018 IBM Corp
 /*
- * A FSI master controller, using a simple GPIO bit-banging interface
+ * A FSI master based on Aspeed ColdFire coprocessor
  */
 
 #include <linux/crc4.h>
@@ -1438,5 +1438,6 @@ static struct platform_driver fsi_master_acf = {
 };
 
 module_platform_driver(fsi_master_acf);
+MODULE_DESCRIPTION("A FSI master based on Aspeed ColdFire coprocessor");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FW_FILE_NAME);
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 10fc344b6b22..f761344f4873 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -892,4 +892,5 @@ static struct platform_driver fsi_master_gpio_driver = {
 };
 
 module_platform_driver(fsi_master_gpio_driver);
+MODULE_DESCRIPTION("A FSI master controller, using a simple GPIO bit-banging interface");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 6d8b6e8854e5..6568fed7db3c 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -295,4 +295,5 @@ static struct fsi_driver hub_master_driver = {
 };
 
 module_fsi_driver(hub_master_driver);
+MODULE_DESCRIPTION("FSI hub master driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 61dbda9dbe2b..411ddc018cd8 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -625,4 +625,5 @@ static void scom_exit(void)
 
 module_init(scom_init);
 module_exit(scom_exit);
+MODULE_DESCRIPTION("SCOM FSI Client device driver");
 MODULE_LICENSE("GPL");

-- 
2.42.0


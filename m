From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 22 Jan 2021 13:53:34 +1030
Subject: [PATCH] mmc: sdhci-of-aspeed: Fix kunit-related build error
Message-ID: <20210122032334.3663056-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Randy found that with the following Kconfig settings we have duplicate
definitions (e.g. __inittest()) in sdhci-of-aspeed due to competing
module_init()/module_exit() calls from kunit and driver the itself.

```
CONFIG_MMC_SDHCI_OF_ASPEED=m
CONFIG_MMC_SDHCI_OF_ASPEED_TEST=y
```

Conditionally open-code the kunit initialisation to avoid the error.

Fixes: 7efa02a981d6 ("mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed-test.c |  9 ++++++++-
 drivers/mmc/host/sdhci-of-aspeed.c      | 27 ++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
index 34070605b28b..e5edda6c6e60 100644
--- a/drivers/mmc/host/sdhci-of-aspeed-test.c
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -95,4 +95,11 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
 	.name = "sdhci-of-aspeed",
 	.test_cases = aspeed_sdhci_test_cases,
 };
-kunit_test_suite(aspeed_sdhci_test_suite);
+
+static struct kunit_suite *aspeed_sdhci_test_suite_array[] = {
+	&aspeed_sdhci_test_suite,
+	NULL,
+};
+
+static struct kunit_suite **aspeed_sdhci_test_suites
+	__used __section(".kunit_test_suites") = aspeed_sdhci_test_suite_array;
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 3b0d381e1215..1446f23a2bfb 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -556,6 +556,10 @@ static struct platform_driver aspeed_sdc_driver = {
 	.remove		= aspeed_sdc_remove,
 };
 
+#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
+#include "sdhci-of-aspeed-test.c"
+#endif
+
 static int __init aspeed_sdc_init(void)
 {
 	int rc;
@@ -566,7 +570,20 @@ static int __init aspeed_sdc_init(void)
 
 	rc = platform_driver_register(&aspeed_sdc_driver);
 	if (rc < 0)
-		platform_driver_unregister(&aspeed_sdhci_driver);
+		goto cleanup_sdhci;
+
+#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
+	rc = __kunit_test_suites_init(aspeed_sdhci_test_suites);
+	if (rc < 0) {
+		platform_driver_unregister(&aspeed_sdc_driver);
+		goto cleanup_sdhci;
+	}
+#endif
+
+	return 0;
+
+cleanup_sdhci:
+	platform_driver_unregister(&aspeed_sdhci_driver);
 
 	return rc;
 }
@@ -574,15 +591,15 @@ module_init(aspeed_sdc_init);
 
 static void __exit aspeed_sdc_exit(void)
 {
+#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
+	__kunit_test_suites_exit(aspeed_sdhci_test_suites);
+#endif
+
 	platform_driver_unregister(&aspeed_sdc_driver);
 	platform_driver_unregister(&aspeed_sdhci_driver);
 }
 module_exit(aspeed_sdc_exit);
 
-#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
-#include "sdhci-of-aspeed-test.c"
-#endif
-
 MODULE_DESCRIPTION("Driver for the ASPEED SD/SDIO/SDHCI Controllers");
 MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
-- 
2.27.0


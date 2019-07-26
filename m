From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 26 Jul 2019 15:09:56 +0930
Subject: [RFC PATCH 14/17] ipmi: kcs: Finish configuring ASPEED KCS device
 before enable
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
Message-ID: <20190726053959.2003-15-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The currently interrupts are configured after the channel was enabled.

Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: openipmi-developer at lists.sourceforge.net
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 3c955946e647..e3dd09022589 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -268,13 +268,14 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	kcs_bmc->io_inputb = aspeed_kcs_inb;
 	kcs_bmc->io_outputb = aspeed_kcs_outb;
 
+	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
+	if (rc)
+		return rc;
+
 	dev_set_drvdata(dev, kcs_bmc);
 
 	aspeed_kcs_set_address(kcs_bmc, addr);
 	aspeed_kcs_enable_channel(kcs_bmc, true);
-	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
-	if (rc)
-		return rc;
 
 	rc = misc_register(&kcs_bmc->miscdev);
 	if (rc) {
-- 
2.20.1


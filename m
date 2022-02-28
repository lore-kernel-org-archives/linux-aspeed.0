From: Jakob Koschel <jakobkoschel@gmail.com>
Date: Mon, 28 Feb 2022 12:08:19 +0100
Subject: [PATCH 3/6] treewide: fix incorrect use to determine if list is empty
In-Reply-To: <20220228110822.491923-1-jakobkoschel@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
Message-ID: <20220228110822.491923-4-jakobkoschel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The list iterator value will *always* be set by list_for_each_entry().
It is incorrect to assume that the iterator value will be NULL if the
list is empty.

Instead of checking the pointer it should be checked if
the list is empty.
In acpi_get_pmu_hw_inf() instead of setting the pointer to NULL
on the break, it is set to the correct value and leaving it
NULL if no element was found.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/powerpc/sysdev/fsl_gtm.c            |  4 ++--
 drivers/media/pci/saa7134/saa7134-alsa.c |  4 ++--
 drivers/perf/xgene_pmu.c                 | 13 +++++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
index 8963eaffb1b7..39186ad6b3c3 100644
--- a/arch/powerpc/sysdev/fsl_gtm.c
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -86,7 +86,7 @@ static LIST_HEAD(gtms);
  */
 struct gtm_timer *gtm_get_timer16(void)
 {
-	struct gtm *gtm = NULL;
+	struct gtm *gtm;
 	int i;

 	list_for_each_entry(gtm, &gtms, list_node) {
@@ -103,7 +103,7 @@ struct gtm_timer *gtm_get_timer16(void)
 		spin_unlock_irq(&gtm->lock);
 	}

-	if (gtm)
+	if (!list_empty(&gtms))
 		return ERR_PTR(-EBUSY);
 	return ERR_PTR(-ENODEV);
 }
diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index fb24d2ed3621..d3cde05a6eba 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -1214,7 +1214,7 @@ static int alsa_device_exit(struct saa7134_dev *dev)

 static int saa7134_alsa_init(void)
 {
-	struct saa7134_dev *dev = NULL;
+	struct saa7134_dev *dev;

 	saa7134_dmasound_init = alsa_device_init;
 	saa7134_dmasound_exit = alsa_device_exit;
@@ -1229,7 +1229,7 @@ static int saa7134_alsa_init(void)
 			alsa_device_init(dev);
 	}

-	if (dev == NULL)
+	if (list_empty(&saa7134_devlist))
 		pr_info("saa7134 ALSA: no saa7134 cards found\n");

 	return 0;
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 2b6d476bd213..e255f9e665d1 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1460,7 +1460,8 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 	struct hw_pmu_info *inf;
 	void __iomem *dev_csr;
 	struct resource res;
-	struct resource_entry *rentry;
+	struct resource_entry *rentry = NULL;
+	struct resource_entry *tmp;
 	int enable_bit;
 	int rc;

@@ -1475,16 +1476,16 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 		return NULL;
 	}

-	list_for_each_entry(rentry, &resource_list, node) {
-		if (resource_type(rentry->res) == IORESOURCE_MEM) {
-			res = *rentry->res;
-			rentry = NULL;
+	list_for_each_entry(tmp, &resource_list, node) {
+		if (resource_type(tmp->res) == IORESOURCE_MEM) {
+			res = *tmp->res;
+			rentry = tmp;
 			break;
 		}
 	}
 	acpi_dev_free_resource_list(&resource_list);

-	if (rentry) {
+	if (!rentry) {
 		dev_err(dev, "PMU type %d: No memory resource found\n", type);
 		return NULL;
 	}
--
2.25.1


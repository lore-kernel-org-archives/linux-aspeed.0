From: Zhang Zekun <zhangzekun11@huawei.com>
Date: Mon, 9 Sep 2024 20:29:21 +0800
Subject: [PATCH 4/4] soc: qcom: smp2p: Simplify code with dev_err_probe()
In-Reply-To: <20240909122921.12627-1-zhangzekun11@huawei.com>
References: <20240909122921.12627-1-zhangzekun11@huawei.com>
Message-ID: <20240909122921.12627-5-zhangzekun11@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use dev_err_probe() directly in the driver probe phase, and we
don't need to judge if the error code is not equal to -EPROBE_DEFER.
This can simplify the code a bit.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/soc/qcom/smp2p.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index cefcbd61c628..2731449e2201 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -467,12 +467,9 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
 	int ret;
 
 	ret = qcom_smem_alloc(pid, smem_id, sizeof(*out));
-	if (ret < 0 && ret != -EEXIST) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(smp2p->dev,
-				"unable to allocate local smp2p item\n");
-		return ret;
-	}
+	if (ret < 0 && ret != -EEXIST)
+		return dev_err_probe(smp2p->dev, ret,
+				     "unable to allocate local smp2p item\n");
 
 	out = qcom_smem_get(pid, smem_id, NULL);
 	if (IS_ERR(out)) {
-- 
2.17.1


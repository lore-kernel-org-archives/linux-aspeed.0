From: Zhang Zekun <zhangzekun11@huawei.com>
Date: Mon, 9 Sep 2024 20:29:20 +0800
Subject: [PATCH 3/4] soc: qcom: smem: Simplify code with dev_err_probe()
In-Reply-To: <20240909122921.12627-1-zhangzekun11@huawei.com>
References: <20240909122921.12627-1-zhangzekun11@huawei.com>
Message-ID: <20240909122921.12627-4-zhangzekun11@huawei.com>
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
 drivers/soc/qcom/smem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e4411771f482..a8ab99c9c996 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1180,11 +1180,9 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	}
 
 	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
-	if (hwlock_id < 0) {
-		if (hwlock_id != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to retrieve hwlock\n");
-		return hwlock_id;
-	}
+	if (hwlock_id < 0)
+		return dev_err_probe(&pdev->dev, hwlock_id,
+				     "failed to retrieve hwlock\n");
 
 	smem->hwlock = hwspin_lock_request_specific(hwlock_id);
 	if (!smem->hwlock)
-- 
2.17.1


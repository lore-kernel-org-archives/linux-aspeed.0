From: Zhang Zekun <zhangzekun11@huawei.com>
Date: Mon, 9 Sep 2024 20:29:18 +0800
Subject: [PATCH 1/4] soc: qcom: rpmh-rsc: Simplify code with dev_err_probe()
In-Reply-To: <20240909122921.12627-1-zhangzekun11@huawei.com>
References: <20240909122921.12627-1-zhangzekun11@huawei.com>
Message-ID: <20240909122921.12627-2-zhangzekun11@huawei.com>
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
 drivers/soc/qcom/rpmh-rsc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index de86009ecd91..cb82e887b51d 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1045,12 +1045,9 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	 * do. To avoid adding this check to our children we'll do it now.
 	 */
 	ret = cmd_db_ready();
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Command DB not available (%d)\n",
-									ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Command DB not available\n");
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
-- 
2.17.1


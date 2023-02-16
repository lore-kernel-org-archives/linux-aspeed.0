From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 16 Feb 2023 15:41:55 +0800
Subject: [PATCH 4/4] i3c: dw: Add compatible string for ASPEED AST2600 BMC platform
In-Reply-To: <cover.1676532146.git.jk@codeconstruct.com.au>
References: <cover.1676532146.git.jk@codeconstruct.com.au>
Message-ID: <90e8fd66b42bc27e6b8c01085c40721232217a5d.1676532146.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that we have platform-specific code for the ast2600, enable it
through a new compatible string.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/i3c/master/dw-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9be3348cba0e..5ac226e0c558 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1269,6 +1269,7 @@ static const struct dw_i3c_platform_ops ast2600_platform_ops = {
 
 static const struct of_device_id dw_i3c_master_of_match[] = {
 	{ .compatible = "snps,dw-i3c-master-1.00a", },
+	{ .compatible = "aspeed,ast2600-i3c", .data = &ast2600_platform_ops },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
-- 
2.39.1


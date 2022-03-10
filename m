From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 10 Mar 2022 18:41:18 +0700
Subject: [PATCH v6 3/4] ipmi: ssif_bmc: Return -EFAULT if copy_from_user()
 fails
In-Reply-To: <20220310114119.13736-1-quan@os.amperecomputing.com>
References: <20220310114119.13736-1-quan@os.amperecomputing.com>
Message-ID: <20220310114119.13736-4-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Dan Carpenter <dan.carpenter@oracle.com>

The copy_from_user() function returns the number of bytes remaining to
be copied but we should return -EFAULT here.

Fixes: 501c25b59508 ("ipmi: ssif_bmc: Add SSIF BMC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v6:
  + New add in v6, thanks Dan for the patch     [Dan]

 drivers/char/ipmi/ssif_bmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index 62db97773654..91ac2cae756e 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -87,9 +87,8 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
 	if (count > sizeof(struct ssif_msg))
 		return -EINVAL;
 
-	ret = copy_from_user(&msg, buf, count);
-	if (ret)
-		return ret;
+	if (copy_from_user(&msg, buf, count))
+		return -EFAULT;
 
 	if (!msg.len || count < ssif_msg_len(&msg))
 		return -EINVAL;
-- 
2.35.1


From: trix@redhat.com <trix@redhat.com>
Date: Sun,  1 Nov 2020 07:06:22 -0800
Subject: [PATCH] soc: aspeed: remove unneeded semicolon
Message-ID: <20201101150622.2288203-1-trix@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 26db42ef6aae..20a1d4aeb051 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -51,7 +51,7 @@ static const char *siliconid_to_rev(u32 siliconid)
 		return "A1";
 	case 3:
 		return "A2";
-	};
+	}
 
 	return "??";
 }
-- 
2.18.1


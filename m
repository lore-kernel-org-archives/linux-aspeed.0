From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:19:03 -0500
Subject: [PATCH v3 36/40] fsi: i2cr: Adjust virtual CFAM ID to match Odyssey chip
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-37-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The CFAM ID for the I2CR should be the same as the Odyssey chip.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-i2cr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 40f1f4d231e52..c032ba7938815 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -22,7 +22,7 @@
 #define I2CR_LOG_CMD		0x60008
 
 static const u8 i2cr_cfam[] = {
-	0xc0, 0x02, 0x0d, 0xa6,
+	0xc0, 0x01, 0x0c, 0x07,
 	0x80, 0x01, 0x10, 0x02,
 	0x80, 0x01, 0x10, 0x02,
 	0x80, 0x01, 0x10, 0x02,
-- 
2.39.3


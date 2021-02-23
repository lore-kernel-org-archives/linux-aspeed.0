From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 23 Feb 2021 14:02:13 +0800
Subject: [PATCH] fsi: aspeed: Emit fewer barriers in opb operations
In-Reply-To: <20210223041737.171274-1-joel@jms.id.au>
References: <20210223041737.171274-1-joel@jms.id.au>
Message-ID: <b8578a7cb7c0db81442e7a13e62ad0fb818b7297.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey Joel,

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 90dbe58ca1ed..09fff86b2bac 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -101,11 +101,11 @@ static int __opb_write(struct fsi_master_aspeed *aspeed, u32 addr,
????????u32 reg, status;
????????int ret;
?
-???????writel(CMD_WRITE, base + OPB0_RW);
-???????writel(transfer_size, base + OPB0_XFER_SIZE);
-???????writel(addr, base + OPB0_FSI_ADDR);
-???????writel(val, base + OPB0_FSI_DATA_W);
-???????writel(0x1, base + OPB_IRQ_CLEAR);
+???????writel_relaxed(CMD_WRITE, base + OPB0_RW);
+???????writel_relaxed(transfer_size, base + OPB0_XFER_SIZE);
+???????writel_relaxed(addr, base + OPB0_FSI_ADDR);
+???????writel_relaxed(val, base + OPB0_FSI_DATA_W);
+???????writel_relaxed(0x1, base + OPB_IRQ_CLEAR);
????????writel(0x1, base + OPB_TRIGGER);

Future-joel is going to be angry at you if you don't add a comment
about the ordering requirements there.

Otherwise,

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy


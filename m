From: Hongwei Zhang <hongweiz@ami.com>
Date: Tue, 15 Dec 2020 14:23:23 -0500
Subject: [Aspeed, ncsi-rx,
 v1 1/1] net: ftgmac100: Fix AST2600 EVB NCSI RX issue
In-Reply-To: <20201215192323.24359-1-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
Message-ID: <20201215192323.24359-2-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix AST2600 EVB NCSI RX timeout issue by removing FTGMAC100_RXDES0_RX_ERR bit
from macro RXDES0_ANY_ERROR.

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 drivers/net/ethernet/faraday/ftgmac100.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 63b3e02fab16..734477e6f72f 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -252,7 +252,6 @@ struct ftgmac100_rxdes {
 
 /* Errors we care about for dropping packets */
 #define RXDES0_ANY_ERROR		( \
-	FTGMAC100_RXDES0_RX_ERR		| \
 	FTGMAC100_RXDES0_CRC_ERR	| \
 	FTGMAC100_RXDES0_FTL		| \
 	FTGMAC100_RXDES0_RUNT		| \
-- 
2.17.1


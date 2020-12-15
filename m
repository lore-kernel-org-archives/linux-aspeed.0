From: Hongwei Zhang <hongweiz@ami.com>
Date: Tue, 15 Dec 2020 14:23:22 -0500
Subject: [Aspeed, ncsi-rx,
 v1 0/1] net: ftgmac100: Fix AST2600EVB NCSI RX issue 
Message-ID: <20201215192323.24359-1-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Reviewer,

Fix AST2600 EVB NCSI RX timeout issue by removing FTGMAC100_RXDES0_RX_ERR bit 
from macro RXDES0_ANY_ERROR.

Hongwei Zhang (1):
  net: ftgmac100: Fix AST2600 EVB NCSI RX issue

 drivers/net/ethernet/faraday/ftgmac100.h | 1 -
 1 file changed, 1 deletion(-)

-- 
2.17.1


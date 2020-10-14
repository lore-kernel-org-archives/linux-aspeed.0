From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Wed, 14 Oct 2020 14:06:31 +0800
Subject: [PATCH 0/1] Fix Aspeed ast2600 MAC TX hang
Message-ID: <20201014060632.16085-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch fixes the TX hang issue on Aspeed AST2600.
Two HW arbitration features are added onto ast2600, but these features will
cause MAC TX to hang when handling scatter-gather DMA.  These two
problematic features can be disabled by setting MAC register 0x58 bit28
and bit27.

Dylan Hung (1):
  net: ftgmac100: Fix Aspeed ast2600 TX hang issue

 drivers/net/ethernet/faraday/ftgmac100.c | 5 +++++
 drivers/net/ethernet/faraday/ftgmac100.h | 8 ++++++++
 2 files changed, 13 insertions(+)

-- 
2.17.1


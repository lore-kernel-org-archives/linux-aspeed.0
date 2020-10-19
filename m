From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Mon, 19 Oct 2020 16:57:13 +0800
Subject: [PATCH 0/4] fix ftgmac100 issues on aspeed soc
Message-ID: <20201019085717.32413-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series fixes the ftgmac100 mac hw issues on aspeed soc.

Fixes: 52c0cae ("ftgmac100: Remove tx descriptor accessors")
Fixes: 39bfab8 ("net: ftgmac100: Add support for DT phy-handle property")
Fixes: 10cbd64 ("ftgmac100: Rework NAPI & interrupts handling")


Dylan Hung (4):
  ftgmac100: Fix race issue on TX descriptor[0]
  ftgmac100: Fix missing-poll issue
  ftgmac100: Add a dummy read to ensure running sequence
  ftgmac100: Restart MAC HW once

 drivers/net/ethernet/faraday/ftgmac100.c | 53 ++++++++++++++----------
 1 file changed, 32 insertions(+), 21 deletions(-)

-- 
2.17.1


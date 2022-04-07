From: Potin Lai <potin.lai@quantatw.com>
Date: Thu,  7 Apr 2022 09:17:35 +0800
Subject: [PATCH net-next v3 0/3] Add Clause 45 support for Aspeed MDIO
Message-ID: <20220407011738.7189-1-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series add Clause 45 support for Aspeed MDIO driver, and
separate c22 and c45 implementation into different functions.


LINK: [v1] https://lore.kernel.org/all/20220329161949.19762-1-potin.lai at quantatw.com/
LINK: [v2] https://lore.kernel.org/all/20220406170055.28516-1-potin.lai at quantatw.com/

Changes v2 --> v3:
 - sort local variable sequence in reverse Christmas tree format.

Changes v1 --> v2:
 - add C45 to probe_capabilities
 - break one patch into 3 small patches

Potin Lai (3):
  net: mdio: aspeed: move reg accessing part into separate functions
  net: mdio: aspeed: Introduce read write function for c22 and c45
  net: mdio: aspeed: Add c45 support

 drivers/net/mdio/mdio-aspeed.c | 123 ++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 34 deletions(-)

-- 
2.17.1


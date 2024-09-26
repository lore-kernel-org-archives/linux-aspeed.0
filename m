From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 14:55:30 +0800
Subject: [PATCH 0/2] ARM: dts: aspeed: catalina: dts update for EVT and DVT
 schematic
Message-ID: <20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update Catalina devicetree based on EVT and DVT schematic changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      ARM: dts: aspeed: catalina: move hdd board i2c mux bus to i2c5
      ARM: dts: aspeed: catalina: enable mac2

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 172 +++++++++++----------
 1 file changed, 90 insertions(+), 82 deletions(-)
---
base-commit: e56a4f51601d8d874237557a359a3db0dc50b0a9
change-id: 20240926-catalina-evt-dvt-system-modify-386be551ef59

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


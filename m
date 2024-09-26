From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 15:10:43 +0800
Subject: [PATCH v2 0/3] ARM: dts: aspeed: catalina: dts update for EVT and
 DVT schematic
Message-ID: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update Catalina devicetree based on EVT and DVT schematic changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v2:
- add new commit for change NIC1 EEPROM address
- Link to v1: https://lore.kernel.org/r/20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b at gmail.com

---
Potin Lai (3):
      ARM: dts: aspeed: catalina: move hdd board i2c mux bus to i2c5
      ARM: dts: aspeed: catalina: enable mac2
      ARM: dts: aspeed: catalina: update NIC1 fru address

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 176 +++++++++++----------
 1 file changed, 92 insertions(+), 84 deletions(-)
---
base-commit: e56a4f51601d8d874237557a359a3db0dc50b0a9
change-id: 20240926-catalina-evt-dvt-system-modify-386be551ef59

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


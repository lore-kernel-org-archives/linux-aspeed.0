From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Jun 2024 09:25:12 +0800
Subject: [PATCH v2 2/2] dt-bindings: pinctrl: aspeed,ast2600-pinctrl: add NCSI group
In-Reply-To: <20240620012512.3109518-1-potin.lai.pt@gmail.com>
References: <20240620012512.3109518-1-potin.lai.pt@gmail.com>
Message-ID: <20240620012512.3109518-3-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
needed on the management controller side.

Add NCSI group to distinguish the pin group between RMII and NCSI.

- RMII pins:
  - RMIIXRCLKI
  - RMIIXRXD0
  - RMIIXRXD1
  - RMIIXCRSDV
  - RMIIXRXER
  - RMIIXRCLKO
  - RMIIXTXEN
  - RMIIXTXD0
  - RMIIXTXD1

- NCSI pins:
  - RMIIXRCLKI
  - RMIIXRXD0
  - RMIIXRXD1
  - RMIIXCRSDV
  - RMIIXRXER
  - RMIIXTXEN
  - RMIIXTXD0
  - RMIIXTXD1

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index 00b6974a5ed3d..3f02dc94a7ce2 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -337,6 +337,8 @@ additionalProperties:
         - MDIO2
         - MDIO3
         - MDIO4
+        - NCSI3
+        - NCSI4
         - NCTS1
         - NCTS2
         - NCTS3
-- 
2.31.1


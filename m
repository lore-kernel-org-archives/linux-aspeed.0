From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 22 Jul 2024 22:58:56 +0800
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
In-Reply-To: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
References: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
Message-ID: <20240722145857.2131100-2-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on Meta Catalina.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e386d0ebfb14a..2f92b8ab08fa2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
+              - facebook,catalina-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
-- 
2.31.1


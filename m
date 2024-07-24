From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 25 Jul 2024 00:19:18 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
In-Reply-To: <20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc@gmail.com>
References: <20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc@gmail.com>
Message-ID: <20240725-potin-catalina-dts-v3-1-3a5b5d9e6dbc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on Meta Catalina.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 95113df178cc..f1bc2bb7b670 100644
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


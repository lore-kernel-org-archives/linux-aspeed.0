From: Joel Stanley <joel@jms.id.au>
Date: Wed, 21 Aug 2019 15:25:24 +0930
Subject: [PATCH 1/7] dt-bindings: arm: cpus: Add ASPEED SMP
In-Reply-To: <20190821055530.8720-1-joel@jms.id.au>
References: <20190821055530.8720-1-joel@jms.id.au>
Message-ID: <20190821055530.8720-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 SoC contains two CPUs and requires the operating system to
bring the second one out of firmware.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index aa40b074b864..727e0ffc702b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -175,6 +175,7 @@ properties:
               - amlogic,meson8-smp
               - amlogic,meson8b-smp
               - arm,realview-smp
+              - aspeed,ast2600-smp
               - brcm,bcm11351-cpu-method
               - brcm,bcm23550
               - brcm,bcm2836-smp
-- 
2.23.0.rc1


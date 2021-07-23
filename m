From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 23 Jul 2021 16:16:14 +0800
Subject: [v2 1/8] dt-bindings: iio: adc: rename the aspeed adc yaml
In-Reply-To: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
Message-ID: <20210723081621.29477-2-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aspeed,ast2400-adc.yaml not only descriptor the bindings of ast2400.
Rename it to aspeed,adc.yaml for all of the aspeed adc bindings.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml}        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} (93%)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
rename to Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
index 7f534a933e92..23f3da1ffca3 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2400-adc.yaml#
+$id: http://devicetree.org/schemas/iio/adc/aspeed,adc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ADC that forms part of an ASPEED server management processor.
-- 
2.25.1


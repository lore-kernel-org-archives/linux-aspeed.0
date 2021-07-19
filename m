From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 19 Jul 2021 16:06:01 +0800
Subject: [v1 1/7] dt-bindings: iio: adc: rename the aspeed adc yaml
In-Reply-To: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
References: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
Message-ID: <20210719080607.28712-2-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aspeed,ast2400-adc.yaml not only descriptor the bindings of ast2400.
Rename it to aspeed,adc.yaml for all of the aspeed adc bindings.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
rename to Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
-- 
2.25.1


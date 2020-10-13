From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 13 Oct 2020 18:32:45 +0800
Subject: [PATCH 3/3] iio: adc: aspeed: Setting ref_voltage in probe
In-Reply-To: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
References: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
Message-ID: <20201013103245.16723-4-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

At ast2600 ref_voltage becomes configurable and this property is board
dependency.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../devicetree/bindings/iio/adc/aspeed_adc.txt   | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
index 034fc2ba100e..0ba1980c4e06 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
@@ -3,8 +3,11 @@ Aspeed ADC
 This device is a 10-bit converter for 16 voltage channels.  All inputs are
 single ended.
 
+At ast2600, this device split into two individual IPs and each contains 8 voltage channels.
+
+Chip level dtsi:
 Required properties:
-- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
+- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc" or "aspeed,ast2600-adc"
 - reg: memory window mapping address and length
 - clocks: Input clock used to derive the sample clock. Expected to be the
           SoC's APB clock.
@@ -20,3 +23,14 @@ Example:
 		resets = <&syscon ASPEED_RESET_ADC>;
 		#io-channel-cells = <1>;
 	};
+
+Board level dts:
+Required properties:
+- ref_voltage: (ast2600 only)
+	- Reference voltage in millivolts for the conversions.
+	- The range of value is 900 to 2700 mv.
+
+Example:
+&adc0 {
+	ref_voltage = <2500>;
+};
\ No newline at end of file
-- 
2.17.1


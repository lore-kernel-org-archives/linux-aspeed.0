From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon, 21 Oct 2019 13:24:13 -0700
Subject: [PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: add hardware timeout
 support
In-Reply-To: <20191021202414.17484-1-jae.hyun.yoo@linux.intel.com>
References: <20191021202414.17484-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20191021202414.17484-2-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Append a binding to support hardware timeout feature.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
index b47f6ccb196a..133bfedf4cdd 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -17,6 +17,8 @@ Optional Properties:
 - bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
 		  specified
 - multi-master	: states that there is another master active on this bus.
+- aspeed,hw-timeout-ms	: Hardware timeout in milliseconds. If it's not
+			  specified, the H/W timeout feature will be disabled.
 
 Example:
 
-- 
2.23.0


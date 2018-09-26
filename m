From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 26 Sep 2018 14:58:40 -0700
Subject: [PATCH i2c-next v3 1/3] dt-bindings: i2c: aspeed: Add 'timeout'
 property as an optional property
In-Reply-To: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
References: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180926215842.23125-2-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commit adds 'aspeed,timeout' property as an optional property
which can be used for setting 'timeout' value of
'struct i2c_adapter'. With this patch, the timeout value can be
set through an I2C_TIMEOUT ioctl on cdev, or through this optional
DT property.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
index 8fbd8633a387..d6965b360fbc 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -17,6 +17,9 @@ Optional Properties:
 		  specified
 - multi-master	: states that there is another master active on this bus.
 
+- aspeed,timeout : I2C bus timeout in microseconds defaults to 5 seconds when
+		   not specified.
+
 Example:
 
 i2c {
-- 
2.19.0


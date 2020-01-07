From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon,  6 Jan 2020 17:15:02 -0800
Subject: [PATCH 2/3] Documentation: dt-bindings: media: add AST2600 Video
 Engine support
In-Reply-To: <20200107011503.17435-1-jae.hyun.yoo@linux.intel.com>
References: <20200107011503.17435-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20200107011503.17435-3-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 has Video Engine so add the compatible string into the
document.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 Documentation/devicetree/bindings/media/aspeed-video.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
index ce2894506e1f..d2ca32512272 100644
--- a/Documentation/devicetree/bindings/media/aspeed-video.txt
+++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
@@ -1,11 +1,12 @@
 * Device tree bindings for Aspeed Video Engine
 
-The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs can
+The Video Engine (VE) embedded in the Aspeed AST2400/2500/2600 SOCs can
 capture and compress video data from digital or analog sources.
 
 Required properties:
  - compatible:		"aspeed,ast2400-video-engine" or
-			"aspeed,ast2500-video-engine"
+			"aspeed,ast2500-video-engine" or
+			"aspeed,ast2600-video-engine"
  - reg:			contains the offset and length of the VE memory region
  - clocks:		clock specifiers for the syscon clocks associated with
 			the VE (ordering must match the clock-names property)
-- 
2.17.1


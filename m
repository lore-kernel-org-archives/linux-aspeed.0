From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 24 Apr 2019 10:16:56 -0500
Subject: [PATCH v2 0/4] Aspeed: Enable video engine
Message-ID: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series enables the video engine on Aspeed BMC platforms. The use of the
video engine reset line, originally planned to be made externally available in
the clock driver, is removed from the video engine driver. A node for the video
engine is added to the AST2500 devicetree.
The series also includes a missing property for reserved memory in the
devicetree documentation, and a small change to make the video engine driver
start without reserved memory.

Changes since v1:
 - Drop clock patch since it's been applied
 - Add a missing semi-colon in the devicetree doc

Eddie James (4):
  media: platform: Aspeed: Remove use of reset line
  media: platform: Aspeed: Make reserved memory optional
  media: dt-bindings: aspeed-video: Add missing memory-region property
  ARM: dts: aspeed-g5: Add video engine

 .../devicetree/bindings/media/aspeed-video.txt     |  6 ++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 10 +++++++
 drivers/media/platform/aspeed-video.c              | 33 ++++------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

-- 
1.8.3.1


From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  2 Apr 2019 18:24:59 +0000
Subject: [PATCH 0/5] Aspeed: Enable video engine
Message-ID: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series enables the video engine on Aspeed BMC platforms. The video engine
clocking is added to the Aspeed clock driver. The use of the video engine reset
line, originally planned to be made externally available in the clock driver,
is removed from the video engine driver. Finally a node for the video engine is
added to the AST2500 devicetree.
The series also includes a missing property for reserved memory in the
devicetree documentation, and a small change to make the video engine driver
start without reserved memory.

Eddie James (5):
  media: platform: Aspeed: Remove use of reset line
  media: platform: Aspeed: Make reserved memory optional
  media: dt-bindings: aspeed-video: Add missing memory-region property
  clk: Aspeed: Setup video engine clocking
  ARM: dts: aspeed-g5: Add video engine

 .../devicetree/bindings/media/aspeed-video.txt     |  6 ++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 10 ++++++
 drivers/clk/clk-aspeed.c                           | 42 ++++++++++++++++++++--
 drivers/media/platform/aspeed-video.c              | 33 ++++-------------
 4 files changed, 61 insertions(+), 30 deletions(-)

-- 
1.8.3.1


From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon, 21 Dec 2020 14:32:24 -0800
Subject: [PATCH v2 0/1] Fix kernel panic issues caused by AST2500 Video Engine
Message-ID: <20201221223225.14723-1-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Video engine uses eclk and vclk for its clock sources and its reset
control is coupled with eclk so the current clock enabling sequence works
like below.

 Enable eclk
 De-assert Video Engine reset
 10ms delay
 Enable vclk

It introduces improper reset on the Video Engine hardware and eventually
the hardware generates unexpected DMA memory transfers that can corrupt
memory region in random and sporadic patterns. This issue is observed
very rarely on some specific AST2500 SoCs but it causes a critical
kernel panic with making a various shape of signature so it's extremely
hard to debug. Moreover, the issue is observed even when the video
engine is not actively used because udevd turns on the video engine
hardware for a short time to make a query in every boot.

To fix this issue, this commit changes the clock handling logic to make
the reset de-assertion triggered after enabling both eclk and vclk. Also,
it adds clk_unprepare call for a case when probe fails.

In case of AST2600, the video engine reset setting should be coupled with
eclk to match it with the setting for previous Aspeed SoCs which is defined
in clk-aspeed.c since all Aspeed SoCs are sharing a single video engine
driver. Also, reset bit 6 is defined as 'Video Engine' reset in datasheet
so it should be de-asserted when eclk is enabled. This commit fixes the
setting too.

Please review this squashed patch.

Changes since v1:
- Squashed two patches due to dependency.

Jae Hyun Yoo (1):
  media: aspeed: fix clock handling logic

 drivers/clk/clk-ast2600.c             | 4 ++--
 drivers/media/platform/aspeed-video.c | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.17.1


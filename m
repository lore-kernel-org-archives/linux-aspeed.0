From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu,  2 May 2019 12:13:10 -0700
Subject: [PATCH 0/7] Improve stability of Aspeed video engine driver
Message-ID: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series improves stability of Aspeed video engine driver by fixing
clock control and irq handling logic in the driver.

This series should be applied on top of:
https://www.spinics.net/lists/linux-media/msg150193.html

Jae Hyun Yoo (7):
  media: aspeed: fix a kernel warning on clk control
  media: aspeed: refine clock control logic
  media: aspeed: change irq to threaded irq
  media: aspeed: remove IRQF_SHARED flag
  media: aspeed: reduce noisy log printing outs
  media: aspeed: remove checking of VE_INTERRUPT_CAPTURE_COMPLETE
  media: aspeed: refine interrupt handling logic

 drivers/media/platform/aspeed-video.c | 103 ++++++++++++++++++--------
 1 file changed, 73 insertions(+), 30 deletions(-)

-- 
2.21.0


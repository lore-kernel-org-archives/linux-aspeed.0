From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 24 May 2019 16:17:14 -0700
Subject: [PATCH v2 00/11] Improve stability and add bug fixes of Aspeed video
 engine driver
Message-ID: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series improves stability of Aspeed video engine driver by fixing
clock control and irq handling logic in the driver. Also, it adds a couple of
bug fixes and a workaroud for a silicon bug.

Changes since v1:
- Removed spinlock handling code from 0001 patch.
- Added 4 more patches.

Jae Hyun Yoo (11):
  media: aspeed: fix a kernel warning on clk control
  media: aspeed: refine clock control logic
  media: aspeed: change irq to threaded irq
  media: aspeed: remove IRQF_SHARED flag
  media: aspeed: reduce noisy log printing outs
  media: aspeed: remove checking of VE_INTERRUPT_CAPTURE_COMPLETE
  media: aspeed: refine interrupt handling logic
  media: aspeed: remove source buffer allocation before mode detection
  media: aspeed: use different delays for triggering VE H/W reset
  media: aspeed: fix an incorrect timeout checking in mode detection
  media: aspeed: add a workaround to fix a silicon bug

 drivers/media/platform/aspeed-video.c | 140 +++++++++++++++-----------
 1 file changed, 80 insertions(+), 60 deletions(-)

-- 
2.21.0


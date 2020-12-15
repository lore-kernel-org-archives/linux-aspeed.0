From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 14 Dec 2020 20:45:39 -0600
Subject: [PATCH 0/3] aspeed-video: extend spurious interrupt handling
Message-ID: <20201215024542.18888-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These patches build on commit 65d270acb2d6 to address a similar
problem we've observed with a different interrupt.  The first patch
adds an error message so that any others that are discovered in the
future are easier to diagnose (this one took a while to reproduce and
identify).

Zev Weiss (3):
  aspeed-video: add error message for unhandled interrupts
  aspeed-video: clear spurious interrupt bits unconditionally
  aspeed-video: add COMP_READY to VE_SPURIOUS_IRQS

 drivers/media/platform/aspeed-video.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.29.2


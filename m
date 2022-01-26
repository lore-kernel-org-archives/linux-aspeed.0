From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 26 Jan 2022 09:47:23 +0800
Subject: [PATCH v5 0/2] Fix incorrect resolution detected
Message-ID: <20220126014725.1511-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series fixes incorrect resolution detected.
We found this problem happened occasionally in the switch between bios
and bootloader.

Changes in v5:
 - Rebase on top of 5.18f

Changes in v4:
 - Correct the subject of patch

Changes in v3:
 - In v2, we tried to increase the min-required-count of stable signal
   to avoid incorrect transient state in timing detection. But it is
   not working for all conditions.
   Thus, we go another way in v3. Use regs, which can represent the
   signal status, to decide if we needs to do detection again.
 
Changes in v2:
 - Separate the patch into two patches

Jammy Huang (2):
  media: aspeed: Add macro for the fields of the mode-detect registers
  media: aspeed: Fix unstable timing detection

 drivers/media/platform/aspeed-video.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
2.25.1


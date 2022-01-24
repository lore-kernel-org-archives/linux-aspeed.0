From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Mon, 24 Jan 2022 17:33:41 +0800
Subject: [PATCH v3 0/4] Correct timing report
Message-ID: <20220124093345.3935-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series will correct the value of timing detected.

Changes in v3:
 - Add API, aspeed_video_get_timings(), for the calculation of timings
 - Use active rather than 'total/2' as critera for sync polarity workaround
Changes in v2:
 - code refined to improve readability

Jammy Huang (4):
  media: aspeed: Correct value for h-total-pixels
  media: aspeed: Use FIELD_GET to improve readability
  media: aspeed: Correct values for detected timing
  media: aspeed: Fix timing polarity incorrect

 drivers/media/platform/aspeed-video.c | 139 ++++++++++++++++++++------
 1 file changed, 111 insertions(+), 28 deletions(-)

-- 
2.25.1


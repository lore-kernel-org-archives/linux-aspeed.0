From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 25 Jan 2022 14:44:06 +0800
Subject: [PATCH v4 0/3] Correct timing report
Message-ID: <20220125064409.5502-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series will correct the value of timing detected.

Changes in v4:
 - Combine patch 3 and 4
Changes in v3:
 - Add API, aspeed_video_get_timings(), for the calculation of timings
 - Use active rather than 'total/2' as critera for sync polarity workaround
Changes in v2:
 - code refined to improve readability

Jammy Huang (3):
  media: aspeed: Correct value for h-total-pixels
  media: aspeed: Use FIELD_GET to improve readability
  media: aspeed: Correct values for detected timing

 drivers/media/platform/aspeed-video.c | 137 ++++++++++++++++++++------
 1 file changed, 109 insertions(+), 28 deletions(-)

-- 
2.25.1


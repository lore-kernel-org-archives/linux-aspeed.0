From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 17 Dec 2021 17:53:59 +0800
Subject: [PATCH 0/4] Correct timing report
Message-ID: <20211217095403.2618-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series will correct the value of timing detected.

Jammy Huang (4):
  media: aspeed: Correct value for h-total-pixels
  media: aspeed: Use FIELD_GET to improve readability
  media: aspeed: Correct values for detected timing
  media: aspeed: Fix timing polarity incorrect

 drivers/media/platform/aspeed-video.c | 83 +++++++++++++++++++--------
 1 file changed, 59 insertions(+), 24 deletions(-)

-- 
2.25.1


From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 10 Nov 2021 16:00:10 +0800
Subject: [PATCH v2 0/2] Fix incorrect resolution detected
Message-ID: <20211110080012.20759-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series fixes incorrect resolution detected once in a while.

Changes in v2:
 - Separate the patch into two patches

Jammy Huang (2):
  media: aspeed: Add macro for the fields of the mode-detect registers
  media: aspeed: Fix incorrect resolution detected

 drivers/media/platform/aspeed-video.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.25.1


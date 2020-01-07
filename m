From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Jan 2020 14:13:21 +1030
Subject: [PATCH 0/3] video: aspeed video engine cleanups
Message-ID: <20200107034324.38073-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When reviewing some patches from Jae I noticed the driver used compile
time tests for some registers. When thinking about how to avoid that, I
came up with a few cleanups.

Jae, feel free to base your patches on this series if you, Eddie and
Mauro are ok with the changes.

Joel Stanley (3):
  media: aspeed: Rework memory mapping in probe
  media: aspeed: Use runtime configuration
  video: aspeed: Update copyright information

 drivers/media/platform/aspeed-video.c | 73 ++++++++++++++++++---------
 1 file changed, 48 insertions(+), 25 deletions(-)

-- 
2.24.1


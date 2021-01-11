From: Joel Stanley <joel@jms.id.au>
Date: Mon, 11 Jan 2021 15:16:36 +1030
Subject: [PATCH 0/2] drm: aspeed: Support more chip families
Message-ID: <20210111044638.290909-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The out of tree vendor driver was recently updated to support the
ast2400 and ast2600. These patches begin to add that support to the
mainline driver.

With these two cleanups it should be easier to support different
families of BMC system on chip with this driver.

I will merge them through drm-misc once they have been reviewed.

Joel Stanley (2):
  drm/aspeed: Look up syscon by phandle
  drm/aspeed: Use dt matching for default register values

 drivers/gpu/drm/aspeed/aspeed_gfx.h      |  7 +--
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 10 ++--
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 58 +++++++++++++++++++-----
 3 files changed, 56 insertions(+), 19 deletions(-)

-- 
2.29.2


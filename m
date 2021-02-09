From: Joel Stanley <joel@jms.id.au>
Date: Tue,  9 Feb 2021 23:07:32 +1030
Subject: [PATCH v3 0/2] drm: aspeed: Support more chip families
Message-ID: <20210209123734.130483-1-joel@jms.id.au>
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

v2 fixes review from Jeremy. Thanks!
v3 fixes the dt match table declaration

Joel Stanley (2):
  drm/aspeed: Look up syscon by phandle
  drm/aspeed: Use dt matching for default register values

 drivers/gpu/drm/aspeed/aspeed_gfx.h      |  8 +--
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 11 ++--
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 67 ++++++++++++++++++------
 3 files changed, 62 insertions(+), 24 deletions(-)

-- 
2.30.0


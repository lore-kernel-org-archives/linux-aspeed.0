From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Jan 2020 14:13:24 +1030
Subject: [PATCH 3/3] video: aspeed: Update copyright information
In-Reply-To: <20200107034324.38073-1-joel@jms.id.au>
References: <20200107034324.38073-1-joel@jms.id.au>
Message-ID: <20200107034324.38073-4-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the preferred form for GPL2+, and add IBM and Intel as the authors.
The driver was initially upstreamed by Eddie from IBM, and has had major
contributions from Jae at Intel.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/media/platform/aspeed-video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index d70b893fd4cf..71e0dbdb37dc 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1,4 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2020 IBM Corp.
+// Copyright (c) 2019 Intel Corporation
 
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
-- 
2.24.1


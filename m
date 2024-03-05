From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Tue,  5 Mar 2024 22:20:56 +0100
Subject: [PATCH 0/4] fsi: Convert to platform remove callback returning void
Message-ID: <cover.1709673414.git.u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series converts all drivers below drivers/fsi to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

All conversations are trivial, because their .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they could be
picked up individually. But I'd hope that they get picked up all
together.

Best regards
Uwe

Uwe Kleine-K?nig (4):
  fsi: master-aspeed: Convert to platform remove callback returning void
  fsi: master-ast-cf: Convert to platform remove callback returning void
  fsi: master-gpio: Convert to platform remove callback returning void
  fsi: occ: Convert to platform remove callback returning void

 drivers/fsi/fsi-master-aspeed.c | 6 ++----
 drivers/fsi/fsi-master-ast-cf.c | 6 ++----
 drivers/fsi/fsi-master-gpio.c   | 6 ++----
 drivers/fsi/fsi-occ.c           | 6 ++----
 4 files changed, 8 insertions(+), 16 deletions(-)

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0


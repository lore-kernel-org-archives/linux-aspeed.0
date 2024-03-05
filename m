From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Tue,  5 Mar 2024 17:26:57 +0100
Subject: [PATCH 0/6] ipmi: Convert to platform remove callback returning void
Message-ID: <cover.1709655755.git.u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series converts all drivers below drivers/char/ipmi to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform: Provide a
remove callback that returns no value") for an extended explanation and the
eventual goal.

All conversations are trivial, because their .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they could be
picked up individually. But I'd hope that they get picked up all
together by Corey.

Best regards
Uwe

Uwe Kleine-K?nig (6):
  ipmi: bt-bmc: Convert to platform remove callback returning void
  ipmi: ipmi_powernv: Convert to platform remove callback returning void
  ipmi: ipmi_si_platform: Convert to platform remove callback returning void
  ipmi: ipmi_ssif: Convert to platform remove callback returning void
  ipmi: kcs_bmc_aspeed: Convert to platform remove callback returning void
  ipmi: kcs_bmc_npcm7xx: Convert to platform remove callback returning void

 drivers/char/ipmi/bt-bmc.c           | 5 ++---
 drivers/char/ipmi/ipmi_powernv.c     | 6 ++----
 drivers/char/ipmi/ipmi_si_platform.c | 6 ++----
 drivers/char/ipmi/ipmi_ssif.c        | 5 ++---
 drivers/char/ipmi/kcs_bmc_aspeed.c   | 6 ++----
 drivers/char/ipmi/kcs_bmc_npcm7xx.c  | 6 ++----
 6 files changed, 12 insertions(+), 22 deletions(-)

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0


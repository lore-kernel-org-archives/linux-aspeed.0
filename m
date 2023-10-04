From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Wed,  4 Oct 2023 15:12:33 +0200
Subject: [PATCH 00/21] EDAC: Convert to platform remove callback returning void
Message-ID: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series converts all platform drivers below drivers/edac to use
.remove_new(). The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side. However none of the edac drivers suffered from the easy
to make bug, so all drivers are converted in a trivial way.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

The patch for npcm was already sent back in June
(https://lore.kernel.org/linux-edac/20230628071354.665300-1-u.kleine-koenig at pengutronix.de)
but didn't result in enthusiastic review comments and it wasn't picked
up.

There are no interdependencies between the patches. As there are still
quite a few drivers to convert, I'm happy about every patch that makes
it in. So even if there is a merge conflict with one patch until you
apply, please apply the remainder of this series anyhow. I'll come back
to the part that you (maybe) skipped at a later point.

Best regards
Uwe

Uwe Kleine-K?nig (21):
  EDAC/altera: Convert to platform remove callback returning void
  EDAC/armada_xp: Convert to platform remove callback returning void
  EDAC/aspeed: Convert to platform remove callback returning void
  EDAC/bluefield: Convert to platform remove callback returning void
  EDAC/cell: Convert to platform remove callback returning void
  EDAC/cpc925: Convert to platform remove callback returning void
  EDAC/dmc520: Convert to platform remove callback returning void
  EDAC/highbank_l2: Convert to platform remove callback returning void
  EDAC/highbank_mc: Convert to platform remove callback returning void
  EDAC/mpc85xx: Convert to platform remove callback returning void
  EDAC/npcm: Convert to platform remove callback returning void
  EDAC/octeon-l2c: Convert to platform remove callback returning void
  EDAC/octeon-lmc: Convert to platform remove callback returning void
  EDAC/octeon-pc: Convert to platform remove callback returning void
  EDAC/octeon-pci: Convert to platform remove callback returning void
  EDAC/ppc4xx: Convert to platform remove callback returning void
  EDAC/qcom: Convert to platform remove callback returning void
  EDAC/synopsys: Convert to platform remove callback returning void
  EDAC/ti: Convert to platform remove callback returning void
  EDAC/xgene: Convert to platform remove callback returning void
  EDAC/zynqmp: Convert to platform remove callback returning void

 drivers/edac/altera_edac.c      | 12 ++++--------
 drivers/edac/armada_xp_edac.c   | 12 ++++--------
 drivers/edac/aspeed_edac.c      |  6 ++----
 drivers/edac/bluefield_edac.c   |  6 ++----
 drivers/edac/cell_edac.c        |  5 ++---
 drivers/edac/cpc925_edac.c      |  6 ++----
 drivers/edac/dmc520_edac.c      |  6 ++----
 drivers/edac/highbank_l2_edac.c |  5 ++---
 drivers/edac/highbank_mc_edac.c |  5 ++---
 drivers/edac/mpc85xx_edac.c     | 11 ++++-------
 drivers/edac/npcm_edac.c        |  6 ++----
 drivers/edac/octeon_edac-l2c.c  |  6 ++----
 drivers/edac/octeon_edac-lmc.c  |  5 ++---
 drivers/edac/octeon_edac-pc.c   |  5 ++---
 drivers/edac/octeon_edac-pci.c  |  6 ++----
 drivers/edac/ppc4xx_edac.c      |  7 ++-----
 drivers/edac/qcom_edac.c        |  6 ++----
 drivers/edac/synopsys_edac.c    |  6 ++----
 drivers/edac/ti_edac.c          |  6 ++----
 drivers/edac/xgene_edac.c       |  6 ++----
 drivers/edac/zynqmp_edac.c      |  6 ++----
 21 files changed, 48 insertions(+), 91 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1


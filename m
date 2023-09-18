From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 Sep 2023 21:50:43 +0200
Subject: [PATCH net-next 00/19] net: mdio: Convert to platform remove callback returning void
Message-ID: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series convert all platform drivers below drivers/net/mdio to
use remove_new. The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

There are no interdependencies between the patches. As there are still
quite a few drivers to convert, I'm happy about every patch that makes
it in. So even if there is a merge conflict with one patch until you
apply, please apply the remainder of this series anyhow.

Best regards
Uwe

Uwe Kleine-K?nig (19):
  net: mdio: aspeed: Convert to platform remove callback returning void
  net: mdio: bcm-iproc: Convert to platform remove callback returning
    void
  net: mdio: bcm-unimac: Convert to platform remove callback returning
    void
  net: mdio: gpio: Convert to platform remove callback returning void
  net: mdio: hisi-femac: Convert to platform remove callback returning
    void
  net: mdio: ipq4019: Convert to platform remove callback returning void
  net: mdio: ipq8064: Convert to platform remove callback returning void
  net: mdio: moxart: Convert to platform remove callback returning void
  net: mdio: mscc-miim: Convert to platform remove callback returning
    void
  net: mdio: mux-bcm-iproc: Convert to platform remove callback
    returning void
  net: mdio: mux-bcm6368: Convert to platform remove callback returning
    void
  net: mdio: mux-gpio: Convert to platform remove callback returning
    void
  net: mdio: mux-meson-g12a: Convert to platform remove callback
    returning void
  net: mdio: mux-meson-gxl: Convert to platform remove callback
    returning void
  net: mdio: mux-mmioreg: Convert to platform remove callback returning
    void
  net: mdio: mux-multiplexer: Convert to platform remove callback
    returning void
  net: mdio: octeon: Convert to platform remove callback returning void
  net: mdio: sun4i: Convert to platform remove callback returning void
  net: mdio: xgene: Convert to platform remove callback returning void

 drivers/net/mdio/mdio-aspeed.c          | 6 ++----
 drivers/net/mdio/mdio-bcm-iproc.c       | 6 ++----
 drivers/net/mdio/mdio-bcm-unimac.c      | 6 ++----
 drivers/net/mdio/mdio-gpio.c            | 6 ++----
 drivers/net/mdio/mdio-hisi-femac.c      | 6 ++----
 drivers/net/mdio/mdio-ipq4019.c         | 6 ++----
 drivers/net/mdio/mdio-ipq8064.c         | 7 ++-----
 drivers/net/mdio/mdio-moxart.c          | 6 ++----
 drivers/net/mdio/mdio-mscc-miim.c       | 6 ++----
 drivers/net/mdio/mdio-mux-bcm-iproc.c   | 6 ++----
 drivers/net/mdio/mdio-mux-bcm6368.c     | 6 ++----
 drivers/net/mdio/mdio-mux-gpio.c        | 5 ++---
 drivers/net/mdio/mdio-mux-meson-g12a.c  | 6 ++----
 drivers/net/mdio/mdio-mux-meson-gxl.c   | 6 ++----
 drivers/net/mdio/mdio-mux-mmioreg.c     | 6 ++----
 drivers/net/mdio/mdio-mux-multiplexer.c | 6 ++----
 drivers/net/mdio/mdio-octeon.c          | 5 ++---
 drivers/net/mdio/mdio-sun4i.c           | 6 ++----
 drivers/net/mdio/mdio-xgene.c           | 6 ++----
 19 files changed, 38 insertions(+), 75 deletions(-)

base-commit: 7fc7222d9680366edeecc219c21ca96310bdbc10
-- 
2.40.1


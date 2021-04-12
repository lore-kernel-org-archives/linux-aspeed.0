From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 12 Apr 2021 17:54:53 +0800
Subject: [PATCH 0/4] Support pwm driver for aspeed ast26xx
Message-ID: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The legacy driver of aspeed pwm is binding with tach controller and it
doesn't follow the pwm framworks usage. In addition, the pwm register
usage of the 6th generation of ast26xx has drastic change. So these
patch serials add the new aspeed pwm driver to fix up the problem above.

Billy Tsai (4):
  dt-bindings: Add bindings for aspeed pwm-tach.
  dt-bindings: Add bindings for aspeed pwm
  pwm: Add Aspeed ast2600 PWM support
  pwm: Add support for aspeed pwm controller

 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  52 ++++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  47 +++
 drivers/pwm/Kconfig                           |   6 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-aspeed-g6.c                   | 291 ++++++++++++++++++
 5 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
 create mode 100644 drivers/pwm/pwm-aspeed-g6.c

-- 
2.25.1


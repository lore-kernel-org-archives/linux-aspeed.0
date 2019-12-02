From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon,  2 Dec 2019 16:44:25 +1030
Subject: [PATCH 0/7] pinctrl: aspeed-g6: USB and pinconf support
Message-ID: <20191202061432.3996-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series adds USB and pinconf support to the AST2600 pincontrol driver. The
patches have largely been developed by Johnny Huang from ASPEED and have been
used for bringup and verification of the chip. The were developed around the
time of the 5.4 merge window but I got distracted for a while and haven't had
an opportunity to send them until now. They've had a run in the OpenBMC kernel
tree and so shouldn't cause any issues, but given where we are for 5.5 I'm just
getting them in early for 5.6 so we don't miss another release.

Please review!

Andrew Jeffery (1):
  dt-bindings: pinctrl: aspeed-g6: Add USB functions and groups

Johnny Huang (6):
  pinctrl: aspeed-g6: Add AST2600 I3C1 and I3C2 pinmux config
  pinctrl: aspeed-g6: Add support for the AST2600 USB pinmux
  pinctrl: aspeed: Add ASPEED_SB_PINCONF() helper
  pinctrl: aspeed: Move aspeed_pin_config_map to separate source file
  pinctrl: aspeed: Use masks to describe pinconf bitfields
  pinctrl: aspeed-g6: Add AST2600 pinconf support

 .../pinctrl/aspeed,ast2600-pinctrl.yaml       |   9 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c    | 170 ++++----
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    | 212 +++++-----
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    | 387 +++++++++++++++++-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c       |  50 +--
 drivers/pinctrl/aspeed/pinctrl-aspeed.h       |  38 +-
 drivers/pinctrl/aspeed/pinmux-aspeed.h        |   1 +
 7 files changed, 640 insertions(+), 227 deletions(-)

-- 
2.20.1


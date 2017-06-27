From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Jun 2017 11:42:10 +0930
Subject: [PATCH 0/4] pinctrl: Add USB support for Aspeed SoCs
Message-ID: <20170627021214.23323-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

With recent interest in the USB virtual hub in the Aspeed SoCs[1] it is a good
time to add pinmux support for the USB ports and controllers. The earlier
series of pinmux patches for the Aspeed SoCs focussed on supporting pins which
were capable of GPIO. This is not the case for the USB pins, hence they have
been unsupported until now.

Rob: I know you've mentioned previously you desired complete bindings to be
provided up front, so apologies for continuing to add functionality. This looks
to be the last of it.

Cheers,

Andrew

[1] https://www.spinics.net/lists/linux-usb/msg158506.html

Andrew Jeffery (4):
  ARM: aspeed: g4: Add USB functions to pinctrl bindings
  ARM: aspeed: g5: Add USB functions to pinctrl bindings
  pinctrl: aspeed: g4: Add USB device and host support
  pinctrl: aspeed: g5: Add USB device and host support

 .../devicetree/bindings/pinctrl/pinctrl-aspeed.txt |  8 ++-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c         | 66 +++++++++++++++++++---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         | 58 ++++++++++++++++++-
 3 files changed, 121 insertions(+), 11 deletions(-)

-- 
2.11.0


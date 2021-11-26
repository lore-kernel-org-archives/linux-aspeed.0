From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 26 Nov 2021 19:09:51 +0800
Subject: [PATCH 0/3] Refactor Aspeed USB vhub driver
Message-ID: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These patch series include 2 parts. One is adding more features
to pass USB30CV compliance test, the other is fixing hw issues.
More detail descriptions are included below patchsets.

*** BLURB HERE ***

Neal Liu (3):
  usb: aspeed-vhub: add qualifier descriptor
  usb: aspeed-vhub: support remote wakeup feature
  usb: aspeed-vhub: fix ep0 OUT ack received wrong length issue

 drivers/usb/gadget/udc/aspeed-vhub/core.c |  3 ++
 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 18 ++++++--
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c  |  7 ++++
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 51 +++++++++++++++++++----
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  2 +
 5 files changed, 68 insertions(+), 13 deletions(-)

-- 
2.25.1


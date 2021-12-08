From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 8 Dec 2021 18:05:41 +0800
Subject: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
Message-ID: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These patch series include 2 parts. One is adding more features
to pass USB30CV compliance test, the other is fixing hw issues.
More detail descriptions are included below patchsets.

Change since v2:
- Add more description in changelog.
- Fix remote wakeup issue patch and make it more configurable.

Change since v1:
- Remove unnecessary configs for SET_CONFIGURATION.
- Separate supporting test mode to new patch.

*** BLURB HERE ***

Neal Liu (4):
  usb: aspeed-vhub: add qualifier descriptor
  usb: aspeed-vhub: fix remote wakeup failure in iKVM use case
  usb: aspeed-vhub: fix ep0 OUT ack received wrong length issue
  usb: aspeed-vhub: support test mode feature

 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 19 +++++++--
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c  |  7 ++++
 drivers/usb/gadget/udc/aspeed-vhub/epn.c  |  5 +++
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 47 ++++++++++++++++++++---
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  1 +
 5 files changed, 69 insertions(+), 10 deletions(-)

-- 
2.25.1


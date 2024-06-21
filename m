From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Jun 2024 17:31:40 +0800
Subject: [PATCH v4 0/2] add ast2600 NCSI pin groups
Message-ID: <20240621093142.698529-1-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
needed on the management controller side.

LINK: [v1] https://lore.kernel.org/all/20240613080725.2531580-1-potin.lai.pt at gmail.com/
LINK: [v2] https://lore.kernel.org/all/20240620012512.3109518-1-potin.lai.pt at gmail.com/
LINK: [v3] https://lore.kernel.org/all/20240620084337.3525690-1-potin.lai.pt at gmail.com/

changes v3 --> v4:
- remove pin list in dt-bindings commit message
- add note in dt-bindings document to descript the reason of adding NCSI
  groups

changes v2 --> v3:
- fix commit message typo
- move dt-bindings patch forward

changes v1 --> v2:
- add NCSI pin group in dt-bindings document

Potin Lai (2):
  dt-bindings: pinctrl: aspeed,ast2600-pinctrl: add NCSI groups
  pinctrl: aspeed-g6: Add NCSI pin group config

 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml       |  7 +++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c             | 10 ++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.31.1


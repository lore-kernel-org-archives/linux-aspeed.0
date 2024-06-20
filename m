From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Jun 2024 09:25:10 +0800
Subject: [PATCH v2 0/2] add ast2600 NCSI pin group
Message-ID: <20240620012512.3109518-1-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
needed on the management controller side.

LINK: [v1] https://lore.kernel.org/all/20240613080725.2531580-1-potin.lai.pt at gmail.com/

changes v1 --> v2:
- add NCSI pin group in dt-bindings document

Potin Lai (2):
  pinctrl: aspeed-g6: Add NCSI pin group config
  dt-bindings: pinctrl: aspeed,ast2600-pinctrl: add NCSI group

 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml       |  2 ++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c             | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.31.1


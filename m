From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 24 Sep 2024 22:02:12 +0800
Subject: [PATCH v1 0/3] Revise Meta (Facebook) Minerva BMC (AST2600)
Message-ID: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Revise linux device tree entry related to Meta (Facebook) Minerva specific
devices connected to BMC (AST2600) SoC.

Yang Chen (3):
  ARM: dts: aspeed: minerva: Revise the SGPIO line name
  ARM: dts: aspeed: minerva: change the i2c mux number for FCBs
  ARM: dts: aspeed: minerva: add fru device for other blades

 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 475 +++++++++++++++---
 1 file changed, 405 insertions(+), 70 deletions(-)

-- 
2.34.1


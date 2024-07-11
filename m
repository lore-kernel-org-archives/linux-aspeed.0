From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Thu, 11 Jul 2024 21:05:00 +0800
Subject: [PATCH v1 0/1] Add gpio line name in Meta Minerva BMC(AST2600)
Message-ID: <20240711130501.2900301-1-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Based on: https://lore.kernel.org/all/f7412b65e1844ea9f3ad9fe5825e5d1da422ad69.camel at codeconstruct.com.au/

Change log:

v1
  Patch 0001 - Add host0-ready pin.

Yang Chen (1):
  ARM: dts: aspeed: minerva: add host0-ready pin

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


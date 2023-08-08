From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Tue, 8 Aug 2023 23:42:38 +0800
Subject: [PATCH 0/3] Add Aspeed AST2600 I3C support
Message-ID: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series introduces the necessary changes to enable I3C support
for the Aspeed AST2600 I3C controller. Specifically, it addresses the
missing pinctrl configuration and reset control for the I3C
functionality.

Dylan Hung (3):
  ARM: dts: pinctrl-aspeed-g6: Add I3C1 and I3C2 control pins
  dt-bindings: i3c: ast2600: Add resets and reset-names
  i3c: ast2600: Add reset deassertion for global registers

 .../devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml  | 12 ++++++++++--
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi      | 10 ++++++++++
 drivers/i3c/master/ast2600-i3c-master.c              |  9 +++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.25.1


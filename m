From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Mon, 6 May 2024 18:51:18 +0800
Subject: [PATCH 0/2] [RFC] i3c: ast2600: Add MCTP-over-I3C support
Message-ID: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add Aspeed AST2600 I3C controllers and add minimal changes to validate
the functionality for MCTP-over-I3C.

Dylan Hung (2):
  [RFC] ARM: dts: aspeed-g6: Add AST2600 I3Cs
  [RFC] i3c: ast2600: Validate AST2600 I3C for MCTP-over-I3C

 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 137 +++++++
 drivers/i3c/master/ast2600-i3c-master.c | 137 +++++++
 drivers/i3c/master/dw-i3c-master.c      | 513 ++++++++++++++++++++----
 drivers/i3c/master/dw-i3c-master.h      |  12 +
 4 files changed, 718 insertions(+), 81 deletions(-)

-- 
2.25.1


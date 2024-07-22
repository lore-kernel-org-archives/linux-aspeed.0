From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 22 Jul 2024 22:58:55 +0800
Subject: [PATCH 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Message-ID: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

Potin Lai (2):
  dt-bindings: arm: aspeed: add Meta Catalina board
  ARM: dts: aspeed: catalina: add Meta Catalina BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-catalina.dts   | 1032 +++++++++++++++++
 3 files changed, 1034 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts

-- 
2.31.1


From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Mon,  9 Sep 2024 16:04:57 +0800
Subject: [PATCH v3 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Message-ID: <20240909080459.3457853-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on: https://lore.kernel.org/all/799dbd97b09693fba6f837e73d4ef3421d604a8a.camel at codeconstruct.com.au/

v2->v3
  - Revise sgpio line name.

v1->v2
  - Fixed the mail and author.
  - Revise presence-cmm to sgpio.

v1
  - Patch 0001 - add rtc device
  - Patch 0002 - update sgpio line name


Peter Yin (2):
  ARM: dts: aspeed: Harma: add rtc device
  ARM: dts: aspeed: Harma: revise sgpio line name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 45 +++++++++----------
 1 file changed, 21 insertions(+), 24 deletions(-)

-- 
2.25.1


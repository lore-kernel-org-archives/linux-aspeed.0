From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue, 20 Aug 2024 18:29:01 +0800
Subject: [PATCH v1 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Message-ID: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on: https://lore.kernel.org/all/799dbd97b09693fba6f837e73d4ef3421d604a8a.camel at codeconstruct.com.au/

v1
  - Patch 0001 - add rtc device
  - Patch 0002 - update sgpio line name


Peter Yin (2):
  ARM: dts: aspeed: Harma: add rtc device
  ARM: dts: aspeed: Harma: update sgpio line name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.25.1


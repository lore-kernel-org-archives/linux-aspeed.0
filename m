From: Joel Stanley <joel@jms.id.au>
Date: Mon, 19 Feb 2018 17:24:35 +1030
Subject: [PATCH 0/3] reset: simple: enable for ASPEED SoCs
Message-ID: <20180219065438.19933-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Philip,

Here is a series that enables the simple reset driver for the ASPEED
SoCs. You may recall I posted a patch back in May 2017 with a
similar idea[1]. I was happy to see that you merged a driver that solves
the problem, and suits our purpose for the ASPEED. Thanks!

Cheers,

Joel

[1] https://lkml.org/lkml/2017/5/25/940


Joel Stanley (3):
  dt-bindings: aspeed-lpc: Add reset controller
  reset: simple: Enable for ASPEED systems
  reset: simple: Allow user selection of driver

 .../devicetree/bindings/mfd/aspeed-lpc.txt          | 21 +++++++++++++++++++++
 drivers/reset/Kconfig                               | 12 ++++++++----
 drivers/reset/reset-simple.c                        |  2 ++
 3 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.15.1


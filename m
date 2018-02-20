From: Joel Stanley <joel@jms.id.au>
Date: Tue, 20 Feb 2018 12:13:27 +1030
Subject: [PATCH v2 0/3] reset: simple: enable for ASPEED SoCs
Message-ID: <20180220014330.23425-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v2: Fix typos in bindings document, add Rob's ack

This series that enables the simple reset driver for the ASPEED SoCs.

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


From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 17 Oct 2022 11:16:21 +0200
Subject: [PATCH linux v2 0/3] spi: aspeed: Add a "ranges" property
Message-ID: <20221017091624.130227-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

Currently, the Linux Aspeed SMC driver computes the decoding ranges of
each CS (AHB memory window on which the flash contents are mapped)
from the size of the detected flash device. It seems that some chips
have issues with the computed ranges and for these, it would be nice
to be able to define custom decoding ranges in the DT.

Here is a little series doing that. 

Thanks,

C. 

Changes in v2 :

 - Tested by Naresh Solanki
 - sent preliminary fix independently
   https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221016155722.3520802-1-clg at kaod.org/
 - changed the sysfs file exposing the register values to debugfs.
 - refresh on 6.1-rc1

C?dric Le Goater (3):
  spi: dt-bindings: aspeed: Add a ranges property
  spi: aspeed: Handle custom decoding ranges
  spi: aspeed: Introduce a "ranges" debugfs file

 drivers/spi/spi-aspeed-smc.c                  | 131 +++++++++++++++++-
 .../bindings/spi/aspeed,ast2600-fmc.yaml      |   9 ++
 2 files changed, 138 insertions(+), 2 deletions(-)

-- 
2.37.3


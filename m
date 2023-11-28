From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Tue, 28 Nov 2023 14:52:34 +0700
Subject: [PATCH v2 RESEND 0/2] i2c: aspeed: Late ack Tx done irqs and fix unhandled Tx done with NAK
Message-ID: <20231128075236.2724038-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rebase on the v6.7-rc3 and resend the series as per discussion at
https://lore.kernel.org/all/d0773df55a6fe8a5c9b1a3d7c8dd2e1343643272.camel at codeconstruct.com.au/

The prior discussion could be found at
https://lore.kernel.org/all/20210616031046.2317-1-quan at os.amperecomputing.com/

This series consists of two patches to fix the below issues observed
when testing with slave mode:
  + Unhandled Tx done with NAK
  + Early ack'ed of Tx done (ACK and NAK) causing "Unexpected Ack on
  read request".

v2:
  + Split these patches to separate series [Joel]
  + Added the Fixes lines [Joel]
  + Fixed multiline comment [Joel]
  + Refactor irq clearing code [Joel, Guenter]
  + Revised commit message [Joel, Quan]

v1:
  + These patches are first introduced from this disscusstion
https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/

Quan Nguyen (2):
  i2c: aspeed: Fix unhandled Tx done with NAK
  i2c: aspeed: Acknowledge Tx done with and without ACK irq late

 drivers/i2c/busses/i2c-aspeed.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.35.1


From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 11 Dec 2023 17:22:15 +0700
Subject: [PATCH v4 0/2] i2c: aspeed: Late ack Tx done irqs and handle coalesced start with stop conditions
Message-ID: <20231211102217.2436294-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series consists of two patches to handle the below issues observed
when testing with slave mode:
  + The coalesced stop condition with the start conditions
  + Early ack'ed of Tx done (ACK and NAK) causing "Unexpected Ack on
  read request".

This series was verified with ast2500 and ast2600.

The prior discussion could be found at:
https://lore.kernel.org/all/20231208033142.1673232-1-quan at os.amperecomputing.com/

v4:
  + Switch to use define macro instead of variable             [Andrew]
  + Make the early ack conditionally to avoid unnecessary
writel()/readl()                                                 [Quan]
  + Add an extra empty line before the comment in patch 1      [Andrew]

v3:
  + Fix the unconditional write when ack the irqs              [Andrew]
  + Handle the coalesced stop condition with the
start conditions                                               [Andrew]
  + Refactor the code to enhance code readability                [Quan]
  + Revised commit message                                       [Quan]

v2:
  + Split these patches to separate series                       [Joel]
  + Added the Fixes lines                                        [Joel]
  + Fixed multiline comment                                      [Joel]
  + Refactor irq clearing code                          [Joel, Guenter]
  + Revised commit message                                 [Joel, Quan]

v1:
  + These patches are first introduced from this disscusstion
https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/

Quan Nguyen (2):
  i2c: aspeed: Handle the coalesced stop conditions with the start
    conditions.
  i2c: aspeed: Acknowledge Tx done with and without ACK irq late

 drivers/i2c/busses/i2c-aspeed.c | 75 +++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 23 deletions(-)

-- 
2.35.1


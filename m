From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri,  8 Dec 2023 10:31:40 +0700
Subject: [PATCH v3 0/2] i2c: aspeed: Late ack Tx done irqs and handle coalesced start with stop conditions
Message-ID: <20231208033142.1673232-1-quan@os.amperecomputing.com>
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
https://lore.kernel.org/all/20231128075236.2724038-1-quan at os.amperecomputing.com/

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

 drivers/i2c/busses/i2c-aspeed.c | 68 +++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 24 deletions(-)

-- 
2.35.1


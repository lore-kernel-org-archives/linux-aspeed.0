From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 16 Jun 2021 10:10:44 +0700
Subject: [PATCH v2 0/2] i2c: aspeed: Late ack Tx done irqs and fix unhandled
 Tx done with NAK
Message-ID: <20210616031046.2317-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
  + These patches are first introduced in
  https://lkml.org/lkml/2021/5/19/205

Quan Nguyen (2):
  i2c: aspeed: Fix unhandled Tx done with NAK
  i2c: aspeed: Acknowledge Tx done with and without ACK irq late

 drivers/i2c/busses/i2c-aspeed.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.28.0


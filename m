From: Joel Stanley <joel@jms.id.au>
Date: Sun, 25 Aug 2019 23:48:46 +0930
Subject: [PATCH v2 0/2] clk: Add driver for ast2600
Message-ID: <20190825141848.17346-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello clock maintainers,

v2 of the clock driver addresses most review comments from Stephen, and
contains a few fixes found while testing on hardware.

Stephen, I did not get a chance to move to the new parent registration scheme.
If you would be comfortable with taking these patches for 5.4 I can work
on to moving to the new parent scheme next merge window, for both the
ast2600 and the existing driver.

Joel Stanley (2):
  clk: aspeed: Move structures to header
  clk: Add support for AST2600 SoC

 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-aspeed.c                  |  67 +-
 drivers/clk/clk-aspeed.h                  |  82 +++
 drivers/clk/clk-ast2600.c                 | 704 ++++++++++++++++++++++
 include/dt-bindings/clock/ast2600-clock.h | 113 ++++
 5 files changed, 903 insertions(+), 64 deletions(-)
 create mode 100644 drivers/clk/clk-aspeed.h
 create mode 100644 drivers/clk/clk-ast2600.c
 create mode 100644 include/dt-bindings/clock/ast2600-clock.h

-- 
2.23.0.rc1


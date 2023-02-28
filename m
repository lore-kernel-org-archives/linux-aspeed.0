From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 28 Feb 2023 17:16:33 +0800
Subject: [PATCH v4 0/5] Add definitions for AST2600 i3c clocks and resets
Message-ID: <20230228091638.206569-1-jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds some base configuration for the i3c controllers on
ast2600 hardware. We'll use the reset and clock definitions in the
proposed dt binding example, hence sending these first.

v4:
 - ensure we have enough space in ASPEED_G6_NUM_CLKS
v3:
 - split dt-bindings from clk changes
 - unify subject prefixes
v2:
 - based on feedback from Joel Stanley: avoid adding RESERVED clock
   definitions, allowing empty entries in aspeed_g6_gates instead.

Jeremy Kerr (5):
  clk: ast2600: allow empty entries in aspeed_g6_gates
  dt-bindings: clock: ast2600: Add top-level I3C clock
  clk: ast2600: Add full configs for I3C clocks
  dt-bindings: clock: ast2600: remove IC36 & I3C7 clock definitions
  dt-bindings: clock: ast2600: Add reset config for I3C

 drivers/clk/clk-ast2600.c                 | 43 ++++++++++++++++++-----
 include/dt-bindings/clock/ast2600-clock.h |  9 +++--
 2 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.39.1


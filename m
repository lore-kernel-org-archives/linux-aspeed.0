From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu,  2 Mar 2023 08:58:28 +0800
Subject: [PATCH v5 0/6] Add definitions for AST2600 i3c clocks
Message-ID: <20230302005834.13171-1-jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds some base configuration for the i3c controllers on
ast2600 hardware. We'll use the reset and clock definitions in the
proposed dt binding example, hence sending these first.

v5:
 - use regmap_update_bits rather than FIELD_PREP
 - drop reset defines; resets should be handled by clock control
 - add comments for the above
 - add comment for NUM_CLKS semantics
v4:
 - ensure we have enough space in ASPEED_G6_NUM_CLKS
v3:
 - split dt-bindings from clk changes
 - unify subject prefixes
v2:
 - based on feedback from Joel Stanley: avoid adding RESERVED clock
   definitions, allowing empty entries in aspeed_g6_gates instead.

Jeremy Kerr (6):
  clk: ast2600: allow empty entries in aspeed_g6_gates
  dt-bindings: clock: ast2600: Add top-level I3C clock
  clk: ast2600: Add full configs for I3C clocks
  dt-bindings: clock: ast2600: remove IC36 & I3C7 clock definitions
  clk: ast2600: Add comment about combined clock + reset handling
  dt-bindings: clock: ast2600: Expand comment on reset definitions

 drivers/clk/clk-ast2600.c                 | 67 ++++++++++++++++++++---
 include/dt-bindings/clock/ast2600-clock.h |  5 +-
 2 files changed, 60 insertions(+), 12 deletions(-)

-- 
2.39.1


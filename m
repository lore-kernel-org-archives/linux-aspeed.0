From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 11:48:31 +0800
Subject: [PATCH 0/2] Add definitions for AST2600 i3c clocks and resets
Message-ID: <cover.1676259904.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds some base configuration for the i3c controllers on
ast2600 hardware. We'll use the reset and clock definitions in the
proposed dt binding example, hence sending these first.

Jeremy Kerr (2):
  clk: aspeed: Add full configs for i3c clocks
  dts: ast2600: Add reset config for I3C

 drivers/clk/clk-ast2600.c                 | 39 ++++++++++++++++++-----
 include/dt-bindings/clock/ast2600-clock.h | 12 +++++--
 2 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.39.1


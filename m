From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 11 Dec 2018 14:12:39 -0600
Subject: [PATCH 0/2] clk: aspeed: Setup video engine clocking
Message-ID: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds the parent clock definitions and muxing for the AST2xxx
video engine.

I sent this series before as part of my first patch set for the video engine,
but probably better to send it separately.

Eddie James (2):
  clk: aspeed: Add video engine reset index definition
  clk: aspeed: Setup video engine clocking

 drivers/clk/clk-aspeed.c                 | 41 ++++++++++++++++++++++++++++++--
 include/dt-bindings/clock/aspeed-clock.h |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
1.8.3.1


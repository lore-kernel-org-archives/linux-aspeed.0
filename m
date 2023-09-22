From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri, 22 Sep 2023 03:42:32 -0700
Subject: [PATCH 0/2] watchdog: aspeed: Add aspeed,reset-mask property
Message-ID: <20230922104231.1434-4-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

These patches add a new aspeed,reset-mask DT property for the Aspeed
watchdog timer, which specifies exactly which peripherals should be
reset by the watchdog timer.

This series is a replacement for a patch I sent earlier [0], though
using an entirely different (DT-based) approach and hence not exactly
a v2.

I've tested these patches on ast2500 hardware and a qemu ast2600
model; test results on actual ast2600 hardware would be welcome.


Thanks,
Zev


[0] https://lore.kernel.org/linux-watchdog/20230922013542.29136-2-zev at bewilderbeest.net/

Zev Weiss (2):
  dt-bindings: watchdog: aspeed-wdt: Add aspeed,reset-mask property
  watchdog: aspeed: Add support for aspeed,reset-mask DT property

 .../bindings/watchdog/aspeed-wdt.txt          | 18 +++-
 drivers/watchdog/aspeed_wdt.c                 | 11 +++
 include/dt-bindings/watchdog/aspeed-wdt.h     | 92 +++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/watchdog/aspeed-wdt.h

-- 
2.40.0.5.gf6e3b97ba6d2.dirty


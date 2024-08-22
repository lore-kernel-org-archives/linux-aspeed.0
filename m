From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 22 Aug 2024 14:29:48 +0800
Subject: [PATCH -next 0/8] hwmon: Simplify with scoped for each OF child
Message-ID: <20240822062956.3490387-1-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Jinjie Ruan (8):
  hwmon: (aspeed-g6-pwm-tacho): Simplify with scoped for each OF child
    loop
  hwmon: (aspeed-pwm-tacho): Simplify with scoped for each OF child loop
  hwmon: (ina3221): Simplify with scoped for each OF child loop
  hwmon: (lm90): Simplify with scoped for each OF child loop
  hwmon: (nct7802): Simplify with scoped for each OF child loop
  hwmon: (npcm750-pwm-fan): Simplify with scoped for each OF child loop
  hwmon: (tmp421): Simplify with scoped for each OF child loop
  hwmon: (tmp464): Simplify with scoped for each OF child loop

 drivers/hwmon/aspeed-g6-pwm-tach.c | 4 +---
 drivers/hwmon/aspeed-pwm-tacho.c   | 8 +++-----
 drivers/hwmon/ina3221.c            | 7 ++-----
 drivers/hwmon/lm90.c               | 7 ++-----
 drivers/hwmon/nct7802.c            | 7 ++-----
 drivers/hwmon/npcm750-pwm-fan.c    | 5 ++---
 drivers/hwmon/tmp421.c             | 7 ++-----
 drivers/hwmon/tmp464.c             | 7 ++-----
 8 files changed, 16 insertions(+), 36 deletions(-)

-- 
2.34.1


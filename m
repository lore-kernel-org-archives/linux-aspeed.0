From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed,  1 Jun 2022 12:15:10 +0800
Subject: [PATCH v2 0/2] Add i2c clock manual tuning feature for aspeed-i2c driver
Message-ID: <20220601041512.21484-1-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Current aspeed-i2c driver could calculate a suited clock divisor and
high/low cycles automatically, and it try to assign high/low periods with
close number of cycles.

Because of board schematic design, sometimes we need to manual tune i2c
clock timing register to get longer high clock cycle to match hardware 
requirement, which is not supportted in current driver.

In this patch series, we add new properties for manually assigning clock
divisor, high clock cycles and low clock cycles.

LINK: [v1] https://lore.kernel.org/all/20220530114056.8722-1-potin.lai.pt at gmail.com/

changes v1 --> v2:
* update bt-bindings documentation
* use meaningful values for properties instead of acture value in register

Potin Lai (1):
  aspeed: i2c: add manual clock setting feature

Potin Lai (1):
  dt-bindings: aspeed-i2c: add properties for manual clock setting

 .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 44 ++++++++++++++
 drivers/i2c/busses/i2c-aspeed.c               | 57 ++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

-- 
2.17.1


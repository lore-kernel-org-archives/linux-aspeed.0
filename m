From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 10 Jun 2022 13:47:20 +0800
Subject: [PATCH v4 0/2] Add a property for setting minimum persentage of i2c clock high
Message-ID: <20220610054722.32229-1-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introducing i2c-clk-high-min-percent property for setting minimum
persentage of clock high.

This driver will go through base clock divisor and calculate a set of
high/low clock with duty cycle applied. if driver could not find a suit
high/low clock set, then it will use default duty cycle (50%) recalculate.

LINK: [v1] https://lore.kernel.org/all/20220530114056.8722-1-potin.lai.pt at gmail.com/
LINK: [v2] https://lore.kernel.org/all/20220601041512.21484-1-potin.lai.pt at gmail.com/
LINK: [v3] https://lore.kernel.org/all/20220607163703.26355-1-potin.lai.pt at gmail.com/

changes v3 --> v4:
* rename property to i2c-clk-high-min-percent

changes v2 --> v3:
* discard the properties for manual setting, use duty cycle to calculate
  high/low clock.

changes v1 --> v2:
* update bt-bindings documentation
* use meaningful values for properties instead of acture value in register

Potin Lai (2):
  aspeed: i2c: add clock duty cycle property
  dt-bindings: aspeed-i2c: add properties for setting i2c clock duty
    cycle

 .../devicetree/bindings/i2c/aspeed,i2c.yaml   |  7 +++
 drivers/i2c/busses/i2c-aspeed.c               | 56 +++++++++++++++----
 2 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.17.1


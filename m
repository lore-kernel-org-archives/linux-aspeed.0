From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 15 Jul 2020 21:54:18 +0800
Subject: [PATCH 2/2] gpio/aspeed-sgpio: don't enable all interrupts by default
In-Reply-To: <20200715135418.3194860-1-jk@codeconstruct.com.au>
References: <20200715135418.3194860-1-jk@codeconstruct.com.au>
Message-ID: <20200715135418.3194860-2-jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently, the IRQ setup for the SGPIO driver enables all interrupts for
dual-edge trigger mode. Since the default handler is handle_bad_irq, any
state change on input GPIOs will trigger bad IRQ warnings.

This change applies sensible (disabled) IRQ defaults.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 927d46f159b8..23a3a40901d6 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -451,9 +451,7 @@ static int aspeed_sgpio_setup_irqs(struct aspeed_sgpio *gpio,
 		/* trigger type is edge */
 		iowrite32(0x00000000, bank_reg(gpio, bank, reg_irq_type1));
 		/* dual edge trigger mode. */
-		iowrite32(0xffffffff, bank_reg(gpio, bank, reg_irq_type2));
-		/* enable irq */
-		iowrite32(0xffffffff, bank_reg(gpio, bank, reg_irq_enable));
+		iowrite32(0x00000000, bank_reg(gpio, bank, reg_irq_type2));
 	}
 
 	return 0;
-- 
2.27.0


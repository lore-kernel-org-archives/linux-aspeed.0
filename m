From: Nick Alcock <nick.alcock@oracle.com>
Date: Wed, 22 Feb 2023 12:14:53 +0000
Subject: [PATCH 27/27] kbuild, gpio: gpio-aspeed-sgpio: remove MODULE_LICENSE in non-modules
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Message-ID: <20230222121453.91915-28-nick.alcock@oracle.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Joel Stanley <joel@jms.id.au>
Cc: linux-gpio at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-aspeed at lists.ozlabs.org
---
 drivers/gpio/gpio-aspeed-sgpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 454cefbeecf0..ecc94bfded86 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -609,4 +609,3 @@ static struct platform_driver aspeed_sgpio_driver = {
 
 module_platform_driver_probe(aspeed_sgpio_driver, aspeed_sgpio_probe);
 MODULE_DESCRIPTION("Aspeed Serial GPIO Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303


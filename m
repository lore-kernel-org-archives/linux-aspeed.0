From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 22 Jul 2021 20:48:40 -0700
Subject: [PATCH] pinctrl: aspeed: placate kernel-doc warnings
Message-ID: <20210723034840.8752-1-rdunlap@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Eliminate kernel-doc warnings in drivers/pinctrl/aspeed by using
proper kernel-doc notation.

Fixes these kernel-doc warnings:

drivers/pinctrl/aspeed/pinmux-aspeed.c:61: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Query the enabled or disabled state for a mux function's signal on a pin
drivers/pinctrl/aspeed/pinctrl-aspeed.c:135: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Search for the signal expression needed to enable the pin's signal for the

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-aspeed at lists.ozlabs.org
Cc: openbmc at lists.ozlabs.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio at vger.kernel.org
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c |    4 ++--
 drivers/pinctrl/aspeed/pinmux-aspeed.c  |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20210722.orig/drivers/pinctrl/aspeed/pinmux-aspeed.c
+++ linux-next-20210722/drivers/pinctrl/aspeed/pinmux-aspeed.c
@@ -59,7 +59,8 @@ int aspeed_sig_desc_eval(const struct as
 }
 
 /**
- * Query the enabled or disabled state for a mux function's signal on a pin
+ * aspeed_sig_expr_eval - Query the enabled or disabled state for a
+ * mux function's signal on a pin
  *
  * @ctx: The driver context for the pinctrl IP
  * @expr: An expression controlling the signal for a mux function on a pin
--- linux-next-20210722.orig/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ linux-next-20210722/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -133,8 +133,8 @@ static int aspeed_disable_sig(struct asp
 }
 
 /**
- * Search for the signal expression needed to enable the pin's signal for the
- * requested function.
+ * aspeed_find_expr_by_name - Search for the signal expression needed to
+ * enable the pin's signal for the requested function.
  *
  * @exprs: List of signal expressions (haystack)
  * @name: The name of the requested function (needle)

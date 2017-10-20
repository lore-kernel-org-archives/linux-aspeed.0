From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Oct 2017 14:07:25 +1030
Subject: [RFC PATCH 3/5] gpio: gpiolib: Add chardev support for maintaining
 GPIO values on reset
In-Reply-To: <20171020033727.21557-1-andrew@aj.id.au>
References: <20171020033727.21557-1-andrew@aj.id.au>
Message-ID: <20171020033727.21557-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Similar to devicetree support, add flags and mappings to expose reset
tolerance configuration through the chardev interface.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpiolib.c    | 14 +++++++++++++-
 include/uapi/linux/gpio.h | 11 ++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6b4c5df10e84..442ee5ceee08 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -357,7 +357,8 @@ struct linehandle_state {
 	GPIOHANDLE_REQUEST_OUTPUT | \
 	GPIOHANDLE_REQUEST_ACTIVE_LOW | \
 	GPIOHANDLE_REQUEST_OPEN_DRAIN | \
-	GPIOHANDLE_REQUEST_OPEN_SOURCE)
+	GPIOHANDLE_REQUEST_OPEN_SOURCE | \
+	GPIOHANDLE_REQUEST_RESET_TOLERANT)
 
 static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 			     unsigned long arg)
@@ -498,6 +499,17 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 			set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
 		/*
+		 * Unconditionally configure reset tolerance, as it's possible
+		 * that the tolerance flag itself becomes tolerant to resets.
+		 * Thus it could remain set from a previous environment, but
+		 * the current environment may not expect it so.
+		 */
+		ret = gpiod_set_reset_tolerant(desc,
+				!!(lflags & GPIOHANDLE_REQUEST_RESET_TOLERANT));
+		if (ret < 0)
+			goto out_free_descs;
+
+		/*
 		 * Lines have to be requested explicitly for input
 		 * or output, else the line will be treated "as is".
 		 */
diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index 333d3544c964..1b1ce1af8653 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -56,11 +56,12 @@ struct gpioline_info {
 #define GPIOHANDLES_MAX 64
 
 /* Linerequest flags */
-#define GPIOHANDLE_REQUEST_INPUT	(1UL << 0)
-#define GPIOHANDLE_REQUEST_OUTPUT	(1UL << 1)
-#define GPIOHANDLE_REQUEST_ACTIVE_LOW	(1UL << 2)
-#define GPIOHANDLE_REQUEST_OPEN_DRAIN	(1UL << 3)
-#define GPIOHANDLE_REQUEST_OPEN_SOURCE	(1UL << 4)
+#define GPIOHANDLE_REQUEST_INPUT		(1UL << 0)
+#define GPIOHANDLE_REQUEST_OUTPUT		(1UL << 1)
+#define GPIOHANDLE_REQUEST_ACTIVE_LOW		(1UL << 2)
+#define GPIOHANDLE_REQUEST_OPEN_DRAIN		(1UL << 3)
+#define GPIOHANDLE_REQUEST_OPEN_SOURCE		(1UL << 4)
+#define GPIOHANDLE_REQUEST_RESET_TOLERANT	(1UL << 5)
 
 /**
  * struct gpiohandle_request - Information about a GPIO handle request
-- 
2.11.0


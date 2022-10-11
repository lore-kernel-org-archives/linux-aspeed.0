From: Kent Gibson <warthog618@gmail.com>
Date: Tue, 11 Oct 2022 08:01:27 +0800
Subject: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
In-Reply-To: <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
Message-ID: <Y0SyVwjDl7NGfTPn@sol>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
> 
> While at it, sort headers alphabetically.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f8041d4898d1..60a60e2d60c5 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -10,8 +10,9 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/file.h>
> -#include <linux/gpio.h>
>  #include <linux/gpio/driver.h>
> +#include <linux/gpio.h>
> +#include <linux/hte.h>

Ok with the hte re-order.

But moving the gpio subsystem header after the gpio/driver is not
alphabetical ('.' precedes '/') and it read better and made more sense
to me the way it was.

>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
>  #include <linux/kernel.h>
> @@ -20,11 +21,12 @@
>  #include <linux/mutex.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/poll.h>
> +#include <linux/seq_file.h>

I wasn't aware that we use anything from seq_file.
What am I missing?

Cheers,
Kent.

>  #include <linux/spinlock.h>
>  #include <linux/timekeeping.h>
>  #include <linux/uaccess.h>
>  #include <linux/workqueue.h>
> -#include <linux/hte.h>
> +
>  #include <uapi/linux/gpio.h>
>  
>  #include "gpiolib.h"
> -- 
> 2.35.1
> 

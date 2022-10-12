From: Claudiu.Beznea@microchip.com <Claudiu.Beznea@microchip.com>
Date: Wed, 12 Oct 2022 07:52:49 +0000
Subject: [PATCH v2 06/36] pinctrl: at91: Add missed header(s)
In-Reply-To: <20221010201453.77401-7-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-7-andriy.shevchenko@linux.intel.com>
Message-ID: <6846a969-028c-f499-2e15-4ae2536edaa9@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10.10.2022 23:14, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
> 
> While at it, sort headers alphabetically.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>


> ---
>  drivers/pinctrl/pinctrl-at91-pio4.c | 10 +++++++---
>  drivers/pinctrl/pinctrl-at91.c      | 16 +++++++++-------
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 82b921fd630d..e38c683aba09 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -7,18 +7,22 @@
>   */
> 
>  #include <dt-bindings/pinctrl/at91.h>
> +
>  #include <linux/clk.h>
>  #include <linux/gpio/driver.h>
> +#include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -#include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/pinctrl/pinconf.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +
>  #include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> -#include <linux/slab.h>
> +
>  #include "core.h"
>  #include "pinconf.h"
>  #include "pinctrl-utils.h"
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 81dbffab621f..1e1813d7c550 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -7,22 +7,24 @@
> 
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/pm.h>
> +#include <linux/seq_file.h>
>  #include <linux/slab.h>
> -#include <linux/interrupt.h>
> -#include <linux/io.h>
> -#include <linux/gpio/driver.h>
> +
> +/* Since we request GPIOs from ourself */
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> -/* Since we request GPIOs from ourself */
> -#include <linux/pinctrl/consumer.h>
> -#include <linux/pm.h>
> 
>  #include "pinctrl-at91.h"
>  #include "core.h"
> --
> 2.35.1
> 


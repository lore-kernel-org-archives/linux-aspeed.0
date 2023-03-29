From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 29 Mar 2023 12:07:42 +0200
Subject: [PATCH v3 1/4] eeprom: ee1004: Enable devices on multiple busses
In-Reply-To: <20230322140348.569397-2-eajames@linux.ibm.com>
References: <20230322140348.569397-1-eajames@linux.ibm.com>
 <20230322140348.569397-2-eajames@linux.ibm.com>
Message-ID: <ZCQN7uq7Y3xFY1od@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 22, 2023 at 09:03:45AM -0500, Eddie James wrote:
> The driver previously prevented probing devices on more than one
> bus due to locking constraints with the special page addresses. This
> constraint can be removed by allocating a reference-counted bus
> structure containing the lock, rather than using global variables.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v2:
>  - Remove of_device.h include
> 
>  drivers/misc/eeprom/ee1004.c | 174 +++++++++++++++++++++--------------
>  1 file changed, 105 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
> index c8c6deb7ed89..0aed5760e370 100644
> --- a/drivers/misc/eeprom/ee1004.c
> +++ b/drivers/misc/eeprom/ee1004.c
> @@ -9,9 +9,11 @@
>   * Copyright (C) 2008 Wolfram Sang, Pengutronix
>   */
>  
> +#include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -31,20 +33,24 @@
>   * over performance.
>   */
>  
> -#define EE1004_ADDR_SET_PAGE		0x36
> +#define EE1004_ADDR_SET_PAGE0		0x36
> +#define EE1004_ADDR_SET_PAGE1		0x37
>  #define EE1004_NUM_PAGES		2
>  #define EE1004_PAGE_SIZE		256
>  #define EE1004_PAGE_SHIFT		8
>  #define EE1004_EEPROM_SIZE		(EE1004_PAGE_SIZE * EE1004_NUM_PAGES)
>  
> -/*
> - * Mutex protects ee1004_set_page and ee1004_dev_count, and must be held
> - * from page selection to end of read.
> - */
> -static DEFINE_MUTEX(ee1004_bus_lock);
> -static struct i2c_client *ee1004_set_page[EE1004_NUM_PAGES];
> -static unsigned int ee1004_dev_count;
> -static int ee1004_current_page;
> +struct ee1004_bus {
> +	struct kref kref;
> +	struct list_head list;
> +	struct mutex lock;
> +	struct i2c_adapter *adapter;
> +	struct i2c_client *set_page_clients[EE1004_NUM_PAGES];
> +	int page;
> +};
> +
> +static LIST_HEAD(ee1004_busses);
> +static DEFINE_MUTEX(ee1004_busses_lock);

This really looks like you are just emulating a tiny portion of the
driver core (busses, lists of busses, reference counting, etc.)

Why not just use an aux device instead and get all of that logic "for
free" in a way that will be properly shown to userspace?  Right now it
has no idea what is happening here with individual portions of the
device and the like.

Please look into that instead of this hand-rolled device model.

thanks,

greg k-h

From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 21 Mar 2023 10:39:58 -0500
Subject: [PATCH v2 1/4] eeprom: ee1004: Enable devices on multiple busses
In-Reply-To: <20230321151642.461618-2-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com> <20230321151642.461618-2-eajames@linux.ibm.com>
Message-ID: <CAL_JsqJR2BOX4sk0K3V7-12Pi7Th0G_Dqjfp_MxxoCf0qnNg0A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 21, 2023 at 10:17?AM Eddie James <eajames@linux.ibm.com> wrote:
>
> The driver previously prevented probing devices on more than one
> bus due to locking constraints with the special page addresses. This
> constraint can be removed by allocating a reference-counted bus
> structure containing the lock, rather than using global variables.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/misc/eeprom/ee1004.c | 175 +++++++++++++++++++++--------------
>  1 file changed, 106 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
> index c8c6deb7ed89..950813821087 100644
> --- a/drivers/misc/eeprom/ee1004.c
> +++ b/drivers/misc/eeprom/ee1004.c
> @@ -9,12 +9,15 @@
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
> +#include <linux/of_device.h>

What do you need from here? I don't see anything.

of_device.h is a mess of implicit includes which I'm currently trying
to detangle. See the ~13 year old comment in it about removing
of_platform.h include. When I'm done, pretty much only bus
implementations should include of_device.h.

Rob

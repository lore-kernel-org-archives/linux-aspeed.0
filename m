From: Michal Simek <michal.simek@amd.com>
Date: Fri, 4 Aug 2023 08:51:24 +0200
Subject: [PATCH v2 22/23] soc: xilinx: Explicitly include correct DT
 includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-22-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-22-d8de2cc88bff@kernel.org>
Message-ID: <2cd4f9e5-87b6-64f9-2d50-f146cae6c83a@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On 8/4/23 00:43, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/soc/xilinx/zynqmp_power.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 641dcc958911..913417506468 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -11,6 +11,7 @@
>   
>   #include <linux/mailbox_client.h>
>   #include <linux/module.h>
> +#include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/reboot.h>
>   #include <linux/suspend.h>
> 

I was checking and I was on CC on the v1 but I didn't get this to my inbox.
Anyway let me apply this to my queue.

Arnd: If you want to take it directly I am fine with it too.

Thanks,
Michal

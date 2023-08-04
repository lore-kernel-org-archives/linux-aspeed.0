From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Fri, 4 Aug 2023 18:11:33 +0300
Subject: [PATCH v2 16/23] bus: Explicitly include correct DT includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-16-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-16-d8de2cc88bff@kernel.org>
Message-ID: <485cb11c-3e34-c4a3-bc63-87ac505b7bb0@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 8/4/2023 1:42 AM, Rob Herring wrote:
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
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
>   drivers/bus/fsl-mc/fsl-mc-msi.c | 2 --
>   drivers/bus/hisi_lpc.c          | 2 +-
>   drivers/bus/omap_l3_smx.c       | 1 -
>   drivers/bus/simple-pm-bus.c     | 2 ++
>   drivers/bus/sunxi-rsb.c         | 2 +-
>   drivers/bus/ti-pwmss.c          | 2 +-
>   7 files changed, 6 insertions(+), 6 deletions(-)
> 

For drivers/bus/fsl-mc bits:

Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Thanks & Best Regards, Laurentiu

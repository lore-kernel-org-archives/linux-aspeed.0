From: Sean Young <sean@mess.org>
Date: Sat, 22 Jul 2023 11:00:08 +0100
Subject: [PATCH v2] media: Explicitly include correct DT includes
In-Reply-To: <20230718143118.1065743-1-robh@kernel.org>
References: <20230718143118.1065743-1-robh@kernel.org>
Message-ID: <ZLuoqDxYUAPHCPgo@gofer.mess.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Tue, Jul 18, 2023 at 08:31:14AM -0600, Rob Herring wrote:
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

For:

>  drivers/media/rc/meson-ir.c                                   | 2 +-
>  drivers/media/rc/mtk-cir.c                                    | 3 ++-
>  drivers/media/rc/sunxi-cir.c                                  | 3 ++-

Reviewed-by: Sean Young <sean@mess.org>

Thanks,

Sean

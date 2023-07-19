From: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Date: Wed, 19 Jul 2023 21:39:27 +0300
Subject: [PATCH] clk: Explicitly include correct DT includes
In-Reply-To: <20230714174342.4052882-1-robh@kernel.org>
References: <20230714174342.4052882-1-robh@kernel.org>
Message-ID: <20230719183927.c4ykdjw3iekmugzy@CAB-WSD-L081021>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 14, 2023 at 11:43:29AM -0600, Rob Herring wrote:
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

[...]

For

>  drivers/clk/meson/a1-peripherals.c               | 2 +-
>  drivers/clk/meson/a1-pll.c                       | 2 +-

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

[...]

-- 
Thank you,
Dmitry

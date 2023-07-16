From: Heiko Stuebner <heiko@sntech.de>
Date: Mon, 17 Jul 2023 00:07:49 +0200
Subject: [PATCH] clk: Explicitly include correct DT includes
In-Reply-To: <20230714174342.4052882-1-robh@kernel.org>
References: <20230714174342.4052882-1-robh@kernel.org>
Message-ID: <7247786.Sb9uPGUboI@phil>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am Freitag, 14. Juli 2023, 19:43:29 CEST schrieb Rob Herring:
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

>  drivers/clk/rockchip/clk-rk3568.c                | 2 +-
>  drivers/clk/rockchip/clk-rv1126.c                | 2 +-

Acked-by: Heiko Stuebner <heiko@sntech.de> #rockchip



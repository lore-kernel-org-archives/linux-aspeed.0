From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Date: Mon, 24 Jul 2023 11:52:56 +0000
Subject: [PATCH v2] media: Explicitly include correct DT includes
In-Reply-To: <20230718143118.1065743-1-robh@kernel.org>
References: <20230718143118.1065743-1-robh@kernel.org>
Message-ID: <TYWPR01MB87759F1E08CC1982E6A4866EC202A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

Thanks for your patch!

> From: Rob Herring <robh@kernel.org>
> Subject: [PATCH v2] media: Explicitly include correct DT includes
> 
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
> v2:
> - Fix double include of of.h
> ---

For

>  drivers/media/platform/renesas/rcar_drif.c                    | 3 ++-

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

From: Heiko Stuebner <heiko@sntech.de>
Date: Thu, 29 Nov 2018 14:18:03 +0100
Subject: [PATCH] iio: adc: Replace license text w/ SPDX identifier
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
Message-ID: <3999722.Y4omgby9AG@phil>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am Mittwoch, 28. November 2018, 18:53:12 CET schrieb Matheus Tavares:
> From: Lucas Santos <ilucas.ms@gmail.com>
> 
> This patch removes all license boilerplate texts from the .c and .h
> files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> identifiers.
> 
> Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1f98566d5b3c..234c6df348ce 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -1,16 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Rockchip Successive Approximation Register (SAR) A/D Converter
>   * Copyright (C) 2014 ROCKCHIP, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/module.h>

For the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>



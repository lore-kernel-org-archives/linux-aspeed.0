From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 10 Feb 2023 10:13:31 +0100
Subject: [PATCH 2/4] soc: aspeed: Add UART DMA support
In-Reply-To: <20230210072643.2772-3-chiawei_wang@aspeedtech.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-3-chiawei_wang@aspeedtech.com>
Message-ID: <c1e096fa-5941-cdd8-2cdc-ecf04661a389@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/02/2023 08:26, Chia-Wei Wang wrote:
> This driver provides DMA support for AST26xx UART and VUART
> devices. It is useful to offload CPU overhead while using
> UART/VUART for binary file transfer.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/soc/aspeed/Kconfig             |   9 +
>  drivers/soc/aspeed/Makefile            |   1 +
>  drivers/soc/aspeed/aspeed-udma.c       | 447 +++++++++++++++++++++++++
>  include/linux/soc/aspeed/aspeed-udma.h |  34 ++

NAK.

DMA drivers do not go to soc, but to dma subsystem.

>  4 files changed, 491 insertions(+)
>  create mode 100644 drivers/soc/aspeed/aspeed-udma.c
>  create mode 100644 include/linux/soc/aspeed/aspeed-udma.h
> 

(...)

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_udma_match[] = {
> +	{ .compatible = "aspeed,ast2600-udma" },

Undocumented compatible.

Please run scripts/checkpatch.pl and fix reported warnings.



Best regards,
Krzysztof


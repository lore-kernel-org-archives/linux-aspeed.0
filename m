From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Jan 2020 01:22:33 +0000
Subject: [PATCH AUTOSEL 4.9 1/2] ARM: config: aspeed-g5: Enable 8250_DW
 quirks
In-Reply-To: <20200124011808.18801-1-sashal@kernel.org>
References: <20200124011808.18801-1-sashal@kernel.org>
Message-ID: <CACPK8XdNmF0GN_PkXttSmvAVSqUh7FtDzYOD-=LFeL-0=NHOkA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2020 at 01:18, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Joel Stanley <joel@jms.id.au>
>
> [ Upstream commit a5331a7a87ec81d5228b7421acf831b2d0c0de26 ]
>
> This driver option is used by the AST2600 A0 boards to work around a
> hardware issue.

This hardware was only supported from 5.4+, so I think we can drop this patch.

Cheers,

Joel

>
> Reviewed-by: C?dric Le Goater <clg@kaod.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm/configs/aspeed_g5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 4f366b0370e93..3fb6bcba79942 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -53,6 +53,7 @@ CONFIG_SERIAL_8250_NR_UARTS=6
>  CONFIG_SERIAL_8250_RUNTIME_UARTS=6
>  CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_USB_SUPPORT is not set
> --
> 2.20.1
>

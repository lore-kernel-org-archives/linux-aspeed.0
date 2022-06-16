From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 16 Jun 2022 01:16:55 +0000
Subject: [PATCH] MAINTAINERS: Repair file entry in ASPEED USB UDC DRIVER
In-Reply-To: <20220615194409.11875-1-lukas.bulwahn@gmail.com>
References: <20220615194409.11875-1-lukas.bulwahn@gmail.com>
Message-ID: <HK0PR06MB3202DE01EB506DC97EBBD60E80AC9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Commit 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver") adds
> the section ASPEED USB UDC DRIVER with a file entry to aspeed,udc.yaml, but
> then, commit 0dde9a46a2cf ("dt-bindings: usb: add documentation for aspeed
> udc") actually adds a device tree binding aspeed,ast2600-udc.yaml.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair the reference to the actually added file in ASPEED USB UDC DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for the fix.

Acked-by: Neal Liu <neal_liu@aspeedtech.com>

> ---
> Neal, please ack.
> Greg, please pick this minor non-urgent clean-up patch in your usb-next tree.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9c3576b082f..8830d1adb23b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3144,7 +3144,7 @@ ASPEED USB UDC DRIVER
>  M:	Neal Liu <neal_liu@aspeedtech.com>
>  L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/usb/aspeed,udc.yaml
> +F:	Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
>  F:	drivers/usb/gadget/udc/aspeed_udc.c
> 
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> --
> 2.17.1


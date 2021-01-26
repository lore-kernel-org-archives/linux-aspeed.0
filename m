From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 26 Jan 2021 18:39:58 +0100
Subject: [PATCH -next] usb: gadget: Remove unused including
 <linux/version.h>
In-Reply-To: <1611578492-43121-1-git-send-email-zou_wei@huawei.com>
References: <1611578492-43121-1-git-send-email-zou_wei@huawei.com>
Message-ID: <YBBT7gNiKGmM4jjD@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 25, 2021 at 08:41:32PM +0800, Zou Wei wrote:
> Fix the following versioncheck warning:
> 
> drivers/usb/gadget/udc/aspeed-vhub/hub.c:33:1: unused including <linux/version.h>
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> index 396a7d8..b192d57 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> @@ -30,7 +30,6 @@
>  #include <linux/regmap.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/bcd.h>
> -#include <linux/version.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>

You didn't test this patch either :(

Your script is not correct...

greg k-h

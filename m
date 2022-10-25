From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 25 Oct 2022 09:39:48 +0200
Subject: [PATCH] MAINTAINERS: Add Ben as a reviewer for ASPEED UCD
In-Reply-To: <20221025020856.744202-1-joel@jms.id.au>
References: <20221025020856.744202-1-joel@jms.id.au>
Message-ID: <Y1eSxJE+0T68I5CW@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 25, 2022 at 12:38:56PM +1030, Joel Stanley wrote:
> He wrote the vhub driver and would like to be cc'd on patches.

You also added more files to the entry, but did not document that here
:(

> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  MAINTAINERS | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bb30c0d1cb4..637beabc70f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3232,12 +3232,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>  F:	drivers/media/platform/aspeed/
>  
> -ASPEED USB UDC DRIVER
> +ASPEED USB UDC DRIVERS
>  M:	Neal Liu <neal_liu@aspeedtech.com>
> +R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>

I would need Ben's ack before accepting this.

thanks,

greg k-h

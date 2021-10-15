From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 15 Oct 2021 08:57:56 +0200
Subject: [PATCH] tty: 8250: replace snprintf in show functions with
 sysfs_emit
In-Reply-To: <1634280682-5002-1-git-send-email-wangqing@vivo.com>
References: <1634280682-5002-1-git-send-email-wangqing@vivo.com>
Message-ID: <YWkmdELuWa6ITIIR@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 14, 2021 at 11:51:22PM -0700, Qing Wang wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.

Why must it not?  What is broken in the existing code?

> 
> Fix the coccicheck warnings:
> WARNING: use scnprintf or sprintf.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++---
>  drivers/tty/serial/8250/8250_port.c         | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 2350fb3..082b9bd 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -82,7 +82,7 @@ static ssize_t lpc_address_show(struct device *dev,
>  	addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
>  		(aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
>  
> -	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
> +	return sysfs_emit(buf - 1, "0x%x\n", addr);

what is the buf-1 thing here for?

Doing a tree-wide change for this type of thing might not be wanted by
many maintainers, especially if you introduce bugs like this :(

greg k-h

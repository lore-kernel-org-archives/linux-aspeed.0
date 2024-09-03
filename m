From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Date: Tue, 3 Sep 2024 17:49:54 +0200
Subject: [PATCH -next] serial: 8250_aspeed_vuart: Enable module
 autoloading
In-Reply-To: <20240903131503.961178-1-liaochen4@huawei.com>
References: <20240903131503.961178-1-liaochen4@huawei.com>
Message-ID: <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Tue, Sep 03, 2024 at 01:15:03PM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 53d8eee9b1c8..25c201cfb91e 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -561,6 +561,7 @@ static const struct of_device_id aspeed_vuart_table[] = {
>  	{ .compatible = "aspeed,ast2500-vuart" },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, aspeed_vuart_table);

I wonder if you found this entry missing by code review, or if you have
a machine with that UART and so you actually benefit.

Otherwise looks right to me.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240903/ce209493/attachment-0001.sig>

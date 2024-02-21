From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 21 Feb 2024 10:47:13 -0800
Subject: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset
 port type
In-Reply-To: <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
Message-ID: <d18d4488-aa48-4156-8087-a117664cea7b@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/21/24 10:31, Andy Shevchenko wrote:
> In some APIs we would like to assign the special value to iotype
> and compare against it in another places. Introduce UPIO_UNSET
> for this purpose.
> 
> Note, we can't use 0, because it's a valid value for IO port access.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/linux/serial_core.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 2d2ec99eca93..2b0526ae1fac 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -470,6 +470,7 @@ struct uart_port {
>   
>   	unsigned char		iotype;			/* io access style */
>   
> +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */

Nit: I would name this UPIO_UNKNOWN, or UPIO_NOTSET, unset means to me 
that it was previously set and we undid that action, whereas unknown or 
not set means we never did.
-- 
Florian


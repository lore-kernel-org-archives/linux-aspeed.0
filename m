From: Jiri Slaby <jirislaby@kernel.org>
Date: Thu, 22 Feb 2024 07:58:32 +0100
Subject: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset
 port type
In-Reply-To: <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
Message-ID: <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21. 02. 24, 19:31, Andy Shevchenko wrote:
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

Perhaps making the var u8 and this U8_MAX then? It would make more sense 
to me.

>   #define UPIO_PORT		(SERIAL_IO_PORT)	/* 8b I/O port access */
>   #define UPIO_HUB6		(SERIAL_IO_HUB6)	/* Hub6 ISA card */
>   #define UPIO_MEM		(SERIAL_IO_MEM)		/* driver-specific */

thanks,
-- 
js
suse labs


From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 10 Jun 2019 18:50:40 +0200
Subject: [patch 1/5] AST2500 DMA UART driver
In-Reply-To: <1559737395-28542-2-git-send-email-open.sudheer@gmail.com>
References: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
 <1559737395-28542-2-git-send-email-open.sudheer@gmail.com>
Message-ID: <20190610165040.GB32085@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 05, 2019 at 05:53:11PM +0530, sudheer.v wrote:
> +
> +#define CONFIG_UART_DMA_DEBUG
> +
> +#ifdef CONFIG_UART_DMA_DEBUG
> +#define UART_DBG(fmt, args...) pr_debug("%s() " fmt, __func__, ## args)
> +#else
> +#define UART_DBG(fmt, args...)
> +#endif
> +
> +#define  CONFIG_UART_TX_DMA_DEBUG 1
> +
> +#ifdef CONFIG_UART_TX_DMA_DEBUG
> +#define UART_TX_DBG(fmt, args...) pr_debug("%s()"fmt, __func__, ## args)
> +#else
> +#define UART_TX_DBG(fmt, args...)
> +#endif

Why have you left debugging on here?

Why does your tiny driver have custom debug macros?  Please always use
the in-kernel standard ones so you can dynamically enable/disable them
as needed without having to rebuild the code.

I stopped reading here, sorry.

greg k-h

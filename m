From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 13 Dec 2019 12:02:05 +1030
Subject: [PATCH 04/58] tty/serial: Migrate aspeed_vuart to use has_sysrq
In-Reply-To: <20191213000657.931618-5-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-5-dima@arista.com>
Message-ID: <274285bd-1304-4e35-945a-90c9aecd119b@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 13 Dec 2019, at 10:36, Dmitry Safonov wrote:
> The SUPPORT_SYSRQ ifdeffery is not nice as:
> - May create misunderstanding about sizeof(struct uart_port) between
>   different objects
> - Prevents moving functions from serial_core.h
> - Reduces readability (well, it's ifdeffery - it's hard to follow)
> 
> In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
> Initialise it in driver's probe and remove ifdeffery.
> 
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-aspeed at lists.ozlabs.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

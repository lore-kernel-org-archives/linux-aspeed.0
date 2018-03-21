From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 21 Mar 2018 11:57:12 +0800
Subject: [PATCH 5/5] serial/aspeed-vuart: Implement quick throttle
 mechanism
In-Reply-To: <20180321025241.19785-6-jk@ozlabs.org>
References: <20180321025241.19785-1-jk@ozlabs.org>
 <20180321025241.19785-6-jk@ozlabs.org>
Message-ID: <1db93cf2-21ef-a9ba-e1fd-0e3815ac8316@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

> +static int aspeed_vuart_handle_irq(struct uart_port *port) { struct
> +	uart_8250_port *up = up_to_u8250p(port); unsigned int iir, lsr;
> +	unsigned long flags; int space, count;

Yikes, wrapping is messed up here. v2 coming soon, with the proper timer
API too.

Cheers,


Jeremy

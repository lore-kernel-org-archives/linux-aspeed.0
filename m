From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Dec 2019 08:42:35 +1030
Subject: [PATCH] gpio: aspeed: avoid return type warning
In-Reply-To: <20191210202842.2546758-1-arnd@arndb.de>
References: <20191210202842.2546758-1-arnd@arndb.de>
Message-ID: <f6a514d1-44cb-4577-af07-fd2f3fefc974@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 11 Dec 2019, at 06:58, Arnd Bergmann wrote:
> gcc has a hard time tracking whether BUG_ON(1) ends
> execution or not:
> 
> drivers/gpio/gpio-aspeed-sgpio.c: In function 'bank_reg':
> drivers/gpio/gpio-aspeed-sgpio.c:112:1: error: control reaches end of 
> non-void function [-Werror=return-type]
> 
> Use the simpler BUG() that gcc knows cannot continue.
> 
> Fixes: f8b410e3695a ("gpio: aspeed-sgpio: Rename and add Kconfig/Makefile")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

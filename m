From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 11 Dec 2019 10:07:47 +0100
Subject: [PATCH] gpio: aspeed: avoid return type warning
In-Reply-To: <f6a514d1-44cb-4577-af07-fd2f3fefc974@www.fastmail.com>
References: <20191210202842.2546758-1-arnd@arndb.de>
 <f6a514d1-44cb-4577-af07-fd2f3fefc974@www.fastmail.com>
Message-ID: <CAMpxmJUD8A1qtmZmOxAq3XojFG5LHu_DS94LC7orinz_O9zY=A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

wt., 10 gru 2019 o 23:10 Andrew Jeffery <andrew@aj.id.au> napisa?(a):
>
>
>
> On Wed, 11 Dec 2019, at 06:58, Arnd Bergmann wrote:
> > gcc has a hard time tracking whether BUG_ON(1) ends
> > execution or not:
> >
> > drivers/gpio/gpio-aspeed-sgpio.c: In function 'bank_reg':
> > drivers/gpio/gpio-aspeed-sgpio.c:112:1: error: control reaches end of
> > non-void function [-Werror=return-type]
> >
> > Use the simpler BUG() that gcc knows cannot continue.
> >
> > Fixes: f8b410e3695a ("gpio: aspeed-sgpio: Rename and add Kconfig/Makefile")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Applied for fixes.

Bartosz

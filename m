From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Sep 2018 23:55:50 +0200
Subject: [PATCH 1/2] misc: aspeed: Add Aspeed UART routing control driver.
In-Reply-To: <20180904202018.198707-2-osk@google.com>
References: <20180904202018.198707-1-osk@google.com>
 <20180904202018.198707-2-osk@google.com>
Message-ID: <CACRpkdamHdGH9bANugQchYLWFS_mde6MmcbvBgcG-hrhvGVFWQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 4, 2018 at 10:20 PM Oskar Senft <osk@google.com> wrote:

> This driver adds sysfs files that allow the BMC userspace to configure
> how UARTs and physical serial I/O ports are routed.
>
> Tested: Checked correct behavior (both read & write) on TYAN S7106
> board by manually changing routing settings and confirming that bits
> flow as expected. Tested for UART1 and UART3 as this board doesn't have
> the other UARTs wired up in a testable way.
>
> Signed-off-by: Oskar Senft <osk@google.com>

After reading some other messages about this I realize it's not very
much you can do with the standard frameworks and you definately
need something like this. Not like I have any better idea.

Arnd and Greg are misc maintainers so not you will need to
talk to them.

I would opt to put it in drivers/soc/aspeed though.

Yours,
Linus Walleij

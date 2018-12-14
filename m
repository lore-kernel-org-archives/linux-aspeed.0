From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 14 Dec 2018 15:30:16 -0800
Subject: [PATCH 5/7] [stable-4.19] i2c: aspeed: fix build warning
In-Reply-To: <20181214221023.3878670-6-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
 <20181214221023.3878670-6-arnd@arndb.de>
Message-ID: <CAFd5g45GxxhHuyHWDjd41_8xscYN6p5XJShnmg9Z2-DDGwaE4A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 14, 2018 at 2:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Upstream commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> properly") reworked the interrupt handling and fixed a warning in the process:
>
> drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_bus_irq':
> drivers/i2c/busses/i2c-aspeed.c:567:1: error: label 'out' defined but not used [-Werror=unused-label]
>
> The warning is still present in v4.19.8 and can be fixed either by applying
> that original patch, or by adding a simple #ifdef.
>
> Here, I choose the second simpler option as the original patch seems too
> invasive for a stable backport.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

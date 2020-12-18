From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri, 18 Dec 2020 15:39:52 -0600
Subject: [PATCH] i2c: aspeed: disable additional device addresses on
 ast2[56]xx
In-Reply-To: <20200915184525.29665-1-zev@bewilderbeest.net>
References: <20200915184525.29665-1-zev@bewilderbeest.net>
Message-ID: <20201218213952.refmqjlxdclsquzg@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 15, 2020 at 01:45:25PM CDT, Zev Weiss wrote:
>The ast25xx and ast26xx have, respectively, two and three configurable
>slave device addresses to the ast24xx's one.  We only support using
>one at a time, but the others may come up in an indeterminate state
>depending on hardware/bootloader behavior, so we need to make sure we
>disable them so as to avoid ending up with phantom devices on the bus.
>
>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>---
> drivers/i2c/busses/i2c-aspeed.c | 50 +++++++++++++++++++++++++++------
> 1 file changed, 41 insertions(+), 9 deletions(-)
>
> <snip>

Ping...any thoughts on this patch?


Thanks,
Zev


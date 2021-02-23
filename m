From: Joel Stanley <joel@jms.id.au>
Date: Tue, 23 Feb 2021 11:18:28 +0000
Subject: [PATCH] i2c/busses:remove unneeded variable: "ret"
In-Reply-To: <20210223020925.22856-1-dingsenjie@163.com>
References: <20210223020925.22856-1-dingsenjie@163.com>
Message-ID: <CACPK8XeYaRkgWfG33+3ohCPKupqCay0jPp85hdt-XybWvM1eRA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 23 Feb 2021 at 08:04, <dingsenjie@163.com> wrote:
>
> From: dingsenjie <dingsenjie@yulong.com>
>
> remove unneeded variable: "ret".
>
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>

Thanks for the patch. Instead of removing the unused variable, I think
the code could be improved to return error codes when the recovery
fails.

Cheers,

Joel

> ---
>  drivers/i2c/busses/i2c-aspeed.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 724bf30..efad900 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -175,7 +175,6 @@ struct aspeed_i2c_bus {
>  static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>  {
>         unsigned long time_left, flags;
> -       int ret = 0;
>         u32 command;
>
>         spin_lock_irqsave(&bus->lock, flags);
> @@ -232,7 +231,7 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>  out:
>         spin_unlock_irqrestore(&bus->lock, flags);
>
> -       return ret;
> +       return 0;
>
>  reset_out:
>         spin_unlock_irqrestore(&bus->lock, flags);
> --
> 1.9.1
>
>

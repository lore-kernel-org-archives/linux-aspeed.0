From: Patrick Venture <venture@google.com>
Date: Thu, 22 Apr 2021 07:56:27 -0700
Subject: [PATCH] soc: aspeed: fix a ternary sign expansion bug
In-Reply-To: <YIE90PSXsMTa2Y8n@mwanda>
References: <YIE90PSXsMTa2Y8n@mwanda>
Message-ID: <CAO=notzLH4reOAVu9t=81th+dS52BvBURKveHbg4wDjbdhbH5w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 22, 2021 at 2:12 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The intent here was to return negative error codes but it actually
> returns positive values.  The problem is that type promotion with
> ternary operations is quite complicated.
>
> "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> returns long.  What happens is that "ret" is cast to u32 and becomes
> positive then it's cast to long and it's still positive.
>
> Fix this by removing the ternary so that "ret" is type promoted directly
> to long.
>
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Patrick Venture <venture@google.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 210455efb321..eceeaf8dfbeb 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
>                         return -EINTR;
>         }
>         ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> +       if (ret)
> +               return ret;
>
> -       return ret ? ret : copied;
> +       return copied;
>  }
>
>  static __poll_t snoop_file_poll(struct file *file,
> --
> 2.30.2
>

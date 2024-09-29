From: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 29 Sep 2024 08:03:19 +0200
Subject: [PATCH] soc: aspeed: Add check devm_kasprintf() returned value
In-Reply-To: <20240929012503.18636-1-hanchunchao@inspur.com>
References: <20240929012503.18636-1-hanchunchao@inspur.com>
Message-ID: <2024092910-mobility-waking-758f@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Sep 29, 2024 at 09:25:03AM +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure in
> aspeed_lpc_enable_snoop()  but this returned value is not checked.
> 
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 3 +++
>  1 file changed, 3 insertions(+)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

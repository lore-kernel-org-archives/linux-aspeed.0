From: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 10 Apr 2022 17:18:37 +0200
Subject: [PATCH] usb: gadget: udc: clean up comments
In-Reply-To: <20220410150828.1891123-1-trix@redhat.com>
References: <20220410150828.1891123-1-trix@redhat.com>
Message-ID: <YlL1Takwt2s05igD@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Apr 10, 2022 at 11:08:28AM -0400, Tom Rix wrote:
> SPDX
> *.h use /* */ style comments
> 
> For double words, remove
> with, also
> 
> Spelling replacements
> wayt to way
> wakup to wakeup
> Contrl to Control
> cheks to checks
> initiaization to initialization
> dyanmic to dynamic
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
>  drivers/usb/gadget/udc/at91_udc.c         | 2 +-
>  drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
>  drivers/usb/gadget/udc/core.c             | 4 ++--
>  drivers/usb/gadget/udc/trace.h            | 2 +-
>  9 files changed, 12 insertions(+), 12 deletions(-)
> 

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

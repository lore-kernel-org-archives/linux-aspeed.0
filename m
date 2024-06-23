From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 23 Jun 2024 08:16:20 +0200
Subject: [PATCH] usb: gadget: aspeed_udc: validate endpoint index for ast
 udc
In-Reply-To: <bb23a7b0-dce6-4359-995a-2c12cf30cfff@web.de>
References: <20240622095618.1890093-1-make24@iscas.ac.cn>
 <bb23a7b0-dce6-4359-995a-2c12cf30cfff@web.de>
Message-ID: <2024062313-automated-theology-3f62@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Jun 22, 2024 at 05:24:25PM +0200, Markus Elfring wrote:
> > We should verify the bound of the array to assure that host
> > may not manipulate the index to point past endpoint array.
> 
> * Can an imperative wording be more desirable for such a change description?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc4#n94
> 
> * Will any tags (like ?Fixes?) become relevant here?

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

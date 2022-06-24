From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 24 Jun 2022 13:42:02 +0200
Subject: [PATCH] usb: gadget: Fix unsigned comparison with less than zero
In-Reply-To: <20220623084347.38207-1-jiapeng.chong@linux.alibaba.com>
References: <20220623084347.38207-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <YrWjCnNJohij691b@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 23, 2022 at 04:43:47PM +0800, Jiapeng Chong wrote:
> This was found by coccicheck:
> 
> ./drivers/usb/gadget/udc/aspeed_udc.c:496:8-13: WARNING: Unsigned expression compared with zero: chunk >= 0.

What does this mean?  Where is the error?

Please explain the reason for changes, not just the output of a random
tool that you ran on the code.

> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

What commit does this fix?

thanks,

greg k-h

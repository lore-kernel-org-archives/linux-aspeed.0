From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 13 Jul 2018 22:33:27 +0200
Subject: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
In-Reply-To: <59538d26-f025-28da-63df-f675e80fd68b@linux.intel.com>
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g47nBCbF0mcYqEnQkDpz0Dhh0F0S1-wEL_yBHgs1b3yE5w@mail.gmail.com>
 <59538d26-f025-28da-63df-f675e80fd68b@linux.intel.com>
Message-ID: <20180713203327.47yq4gucidbzn2hd@katana>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> BTW, to whom should I ask applying this patch? Should I send v2 after
> adding your reviewed-by tag?

Not needed, thanks. I use 'patchwork' and this tool collects all the
tags for me. If I see a patch reviewed by a driver maintainer, I'll pick
it up in the next queue.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20180713/d761c31d/attachment.sig>

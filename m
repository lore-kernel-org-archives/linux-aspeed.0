From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Date: Tue, 13 Dec 2022 20:15:20 +0800
Subject: [PATCH] usb: gadget: aspeed_udc: Add check for dma_alloc_coherent
Message-ID: <20221213121520.18088-1-jiasheng@iscas.ac.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks, I found my mistake and I will submit a v2.

> And how did you find this potential problem?  What tool did you use and
> why did you not follow the documentation for properly describing the
> tool?

I used a tool I wrote myself to find it, which is unpublished.
Therefore, I think it is okay to submit patches without description of the
tools.

Thanks,
Jiang


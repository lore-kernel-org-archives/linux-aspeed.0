From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 13 Dec 2022 15:31:44 +0100
Subject: [PATCH] usb: gadget: aspeed_udc: Add check for dma_alloc_coherent
In-Reply-To: <20221213121520.18088-1-jiasheng@iscas.ac.cn>
References: <20221213121520.18088-1-jiasheng@iscas.ac.cn>
Message-ID: <Y5iM0LG2V5zN2D9u@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 13, 2022 at 08:15:20PM +0800, Jiasheng Jiang wrote:
> Thanks, I found my mistake and I will submit a v2.
> 
> > And how did you find this potential problem?  What tool did you use and
> > why did you not follow the documentation for properly describing the
> > tool?
> 
> I used a tool I wrote myself to find it, which is unpublished.
> Therefore, I think it is okay to submit patches without description of the
> tools.

Nope!  Please read:
	Documentation/process/researcher-guidelines.rst
for what you must do.

thanks,

greg k-h

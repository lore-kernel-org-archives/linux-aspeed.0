From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 14 Dec 2022 09:25:51 +0100
Subject: [PATCH v2] usb: gadget: aspeed_udc: Add check for
 dma_alloc_coherent
In-Reply-To: <20221214025414.44866-1-jiasheng@iscas.ac.cn>
References: <20221214025414.44866-1-jiasheng@iscas.ac.cn>
Message-ID: <Y5mIj6yLpObaLfSr@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 14, 2022 at 10:54:14AM +0800, Jiasheng Jiang wrote:
> Add the check for the return value of dma_alloc_coherent in order to
> avoid NULL pointer dereference.
> 
> This flaw was found using an experimental static analysis tool we are
> developing, APP-Miner, which has not been disclosed.
> 
> The allyesconfig build using GCC 9.3.0 shows no new warning. As we
> don't have a UDC device to test with, no runtime testing was able to
> be performed.
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Add "goto err;" when allocation fails.

You already sent a previous v2 that differs from this one, this should
be v3, right?


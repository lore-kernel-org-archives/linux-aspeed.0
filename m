From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 13 Dec 2022 15:32:23 +0100
Subject: [PATCH v2] usb: gadget: aspeed_udc: Add check for
 dma_alloc_coherent
In-Reply-To: <20221213122116.43278-1-jiasheng@iscas.ac.cn>
References: <20221213122116.43278-1-jiasheng@iscas.ac.cn>
Message-ID: <Y5iM90xfRT65Invq@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 13, 2022 at 08:21:16PM +0800, Jiasheng Jiang wrote:
> Add the check for the return value of dma_alloc_coherent
> in order to avoid NULL pointer dereference.
> 
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Again, please prove that you tested this and follow the requirements at:
	Documentation/process/researcher-guidelines.rst
in order for us to be able to accept your changes.

thanks,

greg k-h

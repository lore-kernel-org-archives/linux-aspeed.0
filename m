From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 3 Jul 2019 19:50:50 +0200
Subject: [patch v3 3/5] DT nodes for AST2500 DMA UART driver
In-Reply-To: <1561459476-14268-4-git-send-email-open.sudheer@gmail.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
 <1561459476-14268-4-git-send-email-open.sudheer@gmail.com>
Message-ID: <20190703175050.GC12813@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 25, 2019 at 04:14:34PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> DT node for DMA controller(ast_uart_sdma) doesn't bind to any DMA controller driver.
> This is because Software for DMA controller is not based on DMA framework,but is dedicated
> and serves only UARTs in AST2500. ast_uart_sdma node is searched by compatible string in the 
> driver software.basic use of this node is to provide register base address of DMA controller and DMA irq number(<50>).
> IRQ of DMA controller is of crucial importance, which does RX and TX of UART data. 

Properly line-wrap your changelog.

thanks,

greg k-h

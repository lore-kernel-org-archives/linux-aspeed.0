From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 17 Jan 2020 10:39:33 +1030
Subject: [PATCH v6 07/12] soc: aspeed: xdma: Add user interface
In-Reply-To: <1579123790-6894-8-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-8-git-send-email-eajames@linux.ibm.com>
Message-ID: <3e28410b-805b-4599-88d1-98aa39c926d5@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 16 Jan 2020, at 07:59, Eddie James wrote:
> This commits adds a miscdevice to provide a user interface to the XDMA
> engine. The interface provides the write operation to start DMA
> operations. The DMA parameters are passed as the data to the write call.
> The actual data to transfer is NOT passed through write. Note that both
> directions of DMA operation are accomplished through the write command;
> BMC to host and host to BMC.
> 
> The XDMA driver reserves an area of physical memory for DMA operations,
> as the XDMA engine is restricted to accessing certain physical memory
> areas on some platforms. This memory forms a pool from which users can
> allocate pages for their usage with calls to mmap. The space allocated
> by a client will be the space used in the DMA operation. For an
> "upstream" (BMC to host) operation, the data in the client's area will
> be transferred to the host. For a "downstream" (host to BMC) operation,
> the host data will be placed in the client's memory area.
> 
> Poll is also provided in order to determine when the DMA operation is
> complete for non-blocking IO.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

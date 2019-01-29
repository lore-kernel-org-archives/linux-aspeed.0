From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 29 Jan 2019 09:49:37 -0600
Subject: Aspeed XDMA Engine Driver Interfaces (PCI communications with
 host)
In-Reply-To: <c3ab751d-d3a8-8491-3353-92ad91e73966@linux.vnet.ibm.com>
References: <c3ab751d-d3a8-8491-3353-92ad91e73966@linux.vnet.ibm.com>
Message-ID: <867a30d2-27c2-2c26-be72-959b6c01ebe0@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 01/28/2019 03:50 PM, Eddie James wrote:
> Hi,
>
> I'm working on a driver for the XDMA engine to enable DMA operations 
> between the host and the BMC. I thought I'd get up a proposal for the 
> interfaces to get some feedback.
>
> Driver provides one or two simple read/write file handles under /dev/, 
> depending on whether or not we're restricted to using the VGA memory 
> only.
>
> /dev/xdma:
>
> ??? seek: user sets the host DMA address

Slight revision here; Drop the seek interface and just use the write 
call to specify the host address. Thanks Jeremy for pointing out that 
read/write are expected to increment the seek offset, so this would be 
confusing.

Eddie

>
> ??? write: user provides the BMC address and specifies the operation 
> type ("upstream", meaning from the BMC to the host, or "downstream", 
> meaning from the host to the BMC). If we're using only VGA memory, the 
> BMC address can be skipped, as it will always be from/to the VGA space.
>
> ??? read: the syscall blocks or returns EAGAIN until the operation is 
> complete
>
> If we only use VGA memory, we need another device to interact with 
> that memory space easily, as well as prevent multiple users 
> overwriting each others data. VGA memory space is configurable by HW 
> strap on the Aspeed between 8 and 64MB, but is 16MB by default.
>
> /dev/xdma-buffer:
>
> ??? open/close: lock access to the memory
>
> ??? read/write: read or write the VGA memory
>
> Locking access in this way is quite a limitation, but I'm not sure how 
> else to guarantee user's data is OK...
>
> Suggestions are very welcome, on all aspects of the design.
>
> Thanks,
>
> Eddie
>


From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 5 Nov 2020 16:11:32 +0100
Subject: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
In-Reply-To: <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
Message-ID: <20201105161132.37eb3265@collabora.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 5 Nov 2020 15:09:11 +0100
C?dric Le Goater <clg@kaod.org> wrote:

> Hello Chin-Ting,
> 
> Thanks for this driver. It's much cleaner than the previous and we should 
> try adding support for the AST2500 SoC also. I guess we can keep the old 
> driver for the AST2400 which has a different register layout.
> 
> On the patchset, I think we should split this patch in three : 
> 
>  - basic support
>  - AHB window calculation depending on the flash size
>  - read training support  

I didn't look closely at the implementation, but if the read training
tries to read a section of the NOR, I'd recommend exposing that feature
through spi-mem and letting the SPI-NOR framework trigger the training
instead of doing that at dirmap creation time (remember that spi-mem is
also used for SPI NANDs which use the dirmap API too, and this training
is unlikely to work there).

The SPI-NOR framework could pass a read op template and a reference
pattern such that all the spi-mem driver has to do is execute the
template op and compare the output to the reference buffer.


> 
> We should avoid magic values when setting registers. This is confusing 
> and defines are much better.
>  
> AST2500 support will be a bit challenging because HW does not allow    
> to configure a 128MB AHB window, max is 120MB This is a bug and the work 
> around is to use user mode for the remaining 8MB. Something to keep in
> mind.

Most SPI-MEM controllers don't have such a big dirmap window anyway, and
that shouldn't be a problem, because we don't expose the direct mapping
directly (as would be done if we were trying to support something like
XIP). That means that, assuming your controller allows controlling the
base spi-mem address the direct mapping points to, you should be able
to adjust the window at runtime and make it point where you requested.

Note that dirmap_{read,write}() are allowed to return less data than
requested thus simplifying the case where a specific access requires a
window adjustment in the middle of an read/write operation.

Regards,

Boris

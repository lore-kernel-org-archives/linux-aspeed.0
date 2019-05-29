From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 29 May 2019 11:29:35 +0930
Subject: [PATCH v2 2/7] drivers/soc: Add Aspeed XDMA Engine Driver
In-Reply-To: <687e4a77-0df1-4982-1edd-9d0559c489fe@linux.vnet.ibm.com>
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
 <1558383565-11821-3-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a2HSOsw33VhAk4Z8ARiYn4jG68Ec7fynKbrFWUNDo37Wg@mail.gmail.com>
 <687e4a77-0df1-4982-1edd-9d0559c489fe@linux.vnet.ibm.com>
Message-ID: <39ca244a-1243-4039-9dcb-7eb2183908d4@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 25 May 2019, at 01:39, Eddie James wrote:
> 
> On 5/21/19 7:02 AM, Arnd Bergmann wrote:
> > On Mon, May 20, 2019 at 10:19 PM Eddie James <eajames@linux.ibm.com> wrote:
> >> diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
> >> new file mode 100644
> >> index 0000000..2a4bd13
> >> --- /dev/null
> >> +++ b/include/uapi/linux/aspeed-xdma.h
> >> @@ -0,0 +1,26 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/* Copyright IBM Corp 2019 */
> >> +
> >> +#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
> >> +#define _UAPI_LINUX_ASPEED_XDMA_H_
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +/*
> >> + * aspeed_xdma_op
> >> + *
> >> + * upstream: boolean indicating the direction of the DMA operation; upstream
> >> + *           means a transfer from the BMC to the host
> >> + *
> >> + * host_addr: the DMA address on the host side, typically configured by PCI
> >> + *            subsystem
> >> + *
> >> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
> >> + */
> >> +struct aspeed_xdma_op {
> >> +       __u32 upstream;
> >> +       __u64 host_addr;
> >> +       __u32 len;
> >> +};
> >> +
> >> +#endif /* _UAPI_LINUX_ASPEED_XDMA_H_ */
> > If this is a user space interface, please remove the holes in the
> > data structure.
> 
> 
> Surely it's 4-byte aligned and there won't be holes??

__u64 is 8-byte aligned, so you have a hole after upstream.

Easiest just to put upstream after len?

Andrew

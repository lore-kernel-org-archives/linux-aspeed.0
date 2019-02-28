From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 27 Feb 2019 19:01:41 -0500
Subject: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
In-Reply-To: <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
References: <20190221222537.137331-1-venture@google.com>
 <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
Message-ID: <43124fcc-6560-4a30-8043-727c39e487ab@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 27 Feb 2019, at 15:35, Florian Fainelli wrote:
> 
> 
> On 2/21/2019 2:25 PM, Patrick Venture wrote:
> > The ASPEED AST2400, and AST2500 in some configurations include a
> > PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> > in the BMC's memory space.  This feature is especially useful when using
> > this bridge to send large files to the BMC.
> > 
> > The host may use this to send down a firmware image by staging data at a
> > specific memory address, and in a coordinated effort with the BMC's
> > software stack and kernel, transmit the bytes.
> > 
> > This driver enables the BMC to unlock the PCI bridge on demand, and
> > configure it via ioctl to allow the host to write bytes to an agreed
> > upon location.  In the primary use-case, the region to use is known
> > apriori on the BMC, and the host requests this information.  Once this
> > request is received, the BMC's software stack will enable the bridge and
> > the region and then using some software flow control (possibly via IPMI
> > packets), copy the bytes down.  Once the process is complete, the BMC
> > will disable the bridge and unset any region involved.
> > 
> > The default behavior of this bridge when present is: enabled and all
> > regions marked read-write.  This driver will fix the regions to be
> > read-only and then disable the bridge entirely.
> 
> A complete drive by review, so I could be completely off here (most
> likely am), but have you considered using virtio and doing some sort of
> rudimentary features (regions here) negotiation over that interface?
> 
> If I get your description right in premise maybe emulating the AHB side
> on the BMC as a PCI end-point device driver, and using it as a seemingly
> regular PCI EP from the host side with BARs and stuff might make sense
> here and be less of a security hole than it currently looks like.

It's not immediately clear to me that this is a win; it seems like a lot of
complexity that only prevents the host from accidentally stomping on
areas of BMC RAM; a malicious host would just ignore this constraint
anyway as the hardware capability allows access anywhere in the BMC's
address space. Most of the accidental case is taken care of by Patrick's
strategy anyway, which is disabling the capability entirely when there's
no need for it to be active.

Andrew

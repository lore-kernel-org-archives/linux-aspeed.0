From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Mar 2019 09:01:13 +0100
Subject: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
In-Reply-To: <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
 <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
Message-ID: <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 4, 2019 at 10:37 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
> between the SOC (acting as a BMC) and a host processor in a server.
>
> This commit adds a driver to control the XDMA engine and adds functions
> to initialize the hardware and memory and start DMA operations.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Hi Eddie,

Thanks for your submission! Overall this looks well-implemented, but
I fear we already have too many ways of doing the same thing at
the moment, and I would hope to avoid adding yet another user space
interface for a specific hardware that does this.

Your interface appears to be a fairly low-level variant, just doing
single DMA transfers through ioctls, but configuring the PCIe
endpoint over sysfs.

Please have a look at the drivers/pci/endpoint framework first
and see if you can work on top of that interface instead.
Even if it doesn't quite do what you need here, we may be
able to extend it in a way that works for you, and lets others
use the same user interface extensions in the future.

It may also be necessary to split out the DMA engine portion
into a regular drivers/dma/ back-end to make that fit in with
the PCIe endpoint framework.

If you have already tried this without success, please let us
know in the description what problems you have hit, and why you
decided to create a new framework instead.

> +/*
> + * aspeed_xdma_op
> + *
> + * upstream: boolean indicating the direction of the DMA operation; upstream
> + *           means a transfer from the BMC to the host
> + *
> + * host_addr: the DMA address on the host side, typically configured by PCI
> + *            subsystem
> + *
> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
> + */
> +struct aspeed_xdma_op {
> +       __u8 upstream;
> +       __u64 host_addr;
> +       __u32 len;
> +} __packed;

Side-note: packed structures are generally not great user space
interfaces. Regardless of where we end up with this, I'd recommend
naturally aligning each member inside of the structure, and using
explicit padding here.


     Arnd

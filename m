From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 6 Mar 2019 11:48:49 +0100
Subject: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
In-Reply-To: <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
 <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
 <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
Message-ID: <CAK8P3a2kcaVGXifqrBLt9PfD1n2M6WCBxDDcaF8d7EdYxGRvVg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 5, 2019 at 10:45 PM Eddie James <eajames@linux.ibm.com> wrote:
> On 3/5/19 2:01 AM, Arnd Bergmann wrote:
> > On Mon, Mar 4, 2019 at 10:37 PM Eddie James <eajames@linux.ibm.com> wrote:
> >> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
> >> between the SOC (acting as a BMC) and a host processor in a server.
> >>
> >> This commit adds a driver to control the XDMA engine and adds functions
> >> to initialize the hardware and memory and start DMA operations.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > Hi Eddie,
> >
> > Thanks for your submission! Overall this looks well-implemented, but
> > I fear we already have too many ways of doing the same thing at
> > the moment, and I would hope to avoid adding yet another user space
> > interface for a specific hardware that does this.
> >
> > Your interface appears to be a fairly low-level variant, just doing
> > single DMA transfers through ioctls, but configuring the PCIe
> > endpoint over sysfs.
>
> Hi, thanks for the quick response!
>
> There is actually no PCIe configuration done in this driver. The two
> sysfs entries control the system control unit (SCU) on the AST2500
> purely to enable and disable entire PCIe devices. It might be possible
> to control those devices more finely with a PCI endpoint driver, but
> there is no need to do so. The XDMA engine does that by itself to
> perform DMA fairly automatically.
>
> If the sysfs entries are really troublesome, we can probably remove
> those and find another way to control the SCU.

I think the main advantage of tying this to a PCIe endpoint driver
is that this would give us a logical object in the kernel that we
can add the user space interface to, and have the protocol on
top of it be portable between different SoCs.

> > Please have a look at the drivers/pci/endpoint framework first
> > and see if you can work on top of that interface instead.
> > Even if it doesn't quite do what you need here, we may be
> > able to extend it in a way that works for you, and lets others
> > use the same user interface extensions in the future.
> >
> > It may also be necessary to split out the DMA engine portion
> > into a regular drivers/dma/ back-end to make that fit in with
> > the PCIe endpoint framework.
>
> Right, I did look into the normal DMA framework. There were a couple of
> problems. First and foremost, the "device" (really, host processor)
> address that we use is 64 bit, but the AST2500 is of course 32 bit. So I
> couldn't find a good way to get the address through the DMA API into the
> driver. It's entirely possible I missed something there though.

32-bit ARM SoCs can be built with a 64-bit dma_addr_t. Would that
help you here?

> The other issue was that the vast majority of the DMA framework was
> unused, resulting in a large amount of boilerplate that did nothing
> except satisfy the API... I thought simplicity would be better in this case.

Simplicity is important indeed, but we have to weigh it against
having a consistent interface. What the dmaengine driver would
give us in combination with the PCIe endpoint driver is that it abstracts
the hardware from the protocol on top, which could then be done
in a way that is not specific to an AST2xxx chip.

> Let me know what you think... I could certainly switch to ioctl instead
> of the write() if that's better. Or if you really think the DMA
> framework is required here, let me know.

I don't think that replacing the ioctl() with a write() call specifically
would make much of a difference here. The question I'd like to
discuss further is what high-level user space interface you actually
need in order to implement what kind of functionality. We can then
look at whether this interface can be implemented on top of a
PCIe endpoint and a dmaengine driver in a portable way. If all
of those are true, then I'd definitely go with the modular approach
of having two standard drivers for the PCIe endpoint (should be
a trivial wrapper) and the dma engine (not trivial, but there are
many examples), plus a generic front-end in
drivers/pci/endpoint/functions/.

     Arnd

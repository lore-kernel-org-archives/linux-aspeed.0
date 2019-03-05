From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 5 Mar 2019 15:45:12 -0600
Subject: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
In-Reply-To: <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
 <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
Message-ID: <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 3/5/19 2:01 AM, Arnd Bergmann wrote:
> On Mon, Mar 4, 2019 at 10:37 PM Eddie James <eajames@linux.ibm.com> wrote:
>> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
>> between the SOC (acting as a BMC) and a host processor in a server.
>>
>> This commit adds a driver to control the XDMA engine and adds functions
>> to initialize the hardware and memory and start DMA operations.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Hi Eddie,
>
> Thanks for your submission! Overall this looks well-implemented, but
> I fear we already have too many ways of doing the same thing at
> the moment, and I would hope to avoid adding yet another user space
> interface for a specific hardware that does this.
>
> Your interface appears to be a fairly low-level variant, just doing
> single DMA transfers through ioctls, but configuring the PCIe
> endpoint over sysfs.

Hi, thanks for the quick response!

There is actually no PCIe configuration done in this driver. The two 
sysfs entries control the system control unit (SCU) on the AST2500 
purely to enable and disable entire PCIe devices. It might be possible 
to control those devices more finely with a PCI endpoint driver, but 
there is no need to do so. The XDMA engine does that by itself to 
perform DMA fairly automatically.

If the sysfs entries are really troublesome, we can probably remove 
those and find another way to control the SCU.

>
> Please have a look at the drivers/pci/endpoint framework first
> and see if you can work on top of that interface instead.
> Even if it doesn't quite do what you need here, we may be
> able to extend it in a way that works for you, and lets others
> use the same user interface extensions in the future.
>
> It may also be necessary to split out the DMA engine portion
> into a regular drivers/dma/ back-end to make that fit in with
> the PCIe endpoint framework.

Right, I did look into the normal DMA framework. There were a couple of 
problems. First and foremost, the "device" (really, host processor) 
address that we use is 64 bit, but the AST2500 is of course 32 bit. So I 
couldn't find a good way to get the address through the DMA API into the 
driver. It's entirely possible I missed something there though.

The other issue was that the vast majority of the DMA framework was 
unused, resulting in a large amount of boilerplate that did nothing 
except satisfy the API... I thought simplicity would be better in this case.

Let me know what you think... I could certainly switch to ioctl instead 
of the write() if that's better. Or if you really think the DMA 
framework is required here, let me know.

Thanks,

Eddie

>
> If you have already tried this without success, please let us
> know in the description what problems you have hit, and why you
> decided to create a new framework instead.
>
>> +/*
>> + * aspeed_xdma_op
>> + *
>> + * upstream: boolean indicating the direction of the DMA operation; upstream
>> + *           means a transfer from the BMC to the host
>> + *
>> + * host_addr: the DMA address on the host side, typically configured by PCI
>> + *            subsystem
>> + *
>> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
>> + */
>> +struct aspeed_xdma_op {
>> +       __u8 upstream;
>> +       __u64 host_addr;
>> +       __u32 len;
>> +} __packed;
> Side-note: packed structures are generally not great user space
> interfaces. Regardless of where we end up with this, I'd recommend
> naturally aligning each member inside of the structure, and using
> explicit padding here.

Understood, thanks.

>
>
>       Arnd
>


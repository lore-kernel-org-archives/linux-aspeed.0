From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Mon, 10 Feb 2020 11:10:19 -0600
Subject: [PATCH v6 06/12] soc: aspeed: Add XDMA Engine Driver
In-Reply-To: <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
Message-ID: <1a303336-9ffb-353f-efe3-7d45ed114fd0@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 2/10/20 10:35 AM, Arnd Bergmann wrote:
> On Wed, Jan 15, 2020 at 10:31 PM Eddie James <eajames@linux.ibm.com> wrote:
>> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
>> DMA operations between the SOC (acting as a BMC) and a host processor
>> in a server.
>>
>> This commit adds a driver to control the XDMA engine and adds functions
>> to initialize the hardware and memory and start DMA operations.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Hi Eddie,
>
> I'm missing the bigger picture in the description here, how does this fit into
> the PCIe endpoint framework and the dmaengine subsystem?


Hi,

It doesn't fit into the PCIe endpoint framework. The XDMA engine 
abstracts all the PCIe details away so the BMC cannot configure any of 
the things the PCIe endpoint exposes.

It also doesn't fit into the dmaengine subsystem due to the restriction 
on the ast2500 (and maybe the ast2600) that the XDMA engine can only 
access certain areas of physical memory. Also problematic would be 
pausing/resuming/terminating transfers because the XDMA engine can't do 
those things.


>
> Does the AST2500 show up as a PCIe device in the host, or do you just
> inject DMAs into the host and hope that bypasses the IOMMU?
> If it shows up as an endpoint, how does the endpoint driver link into the
> dma driver?


The AST2500 and AST2600 have two PCIe devices on them, so these will 
show up on the host if the BMC enables both of them. Either or both can 
also be disabled and therefore will not show up. On the host side, in 
order to receive DMA transfers, its simply a matter of registering a PCI 
device driver and allocating some coherent DMA.... Not sure about the 
details of endpoints/dma client driver?


Hopefully this answers your questions. Thanks,

Eddie


>
>       Arnd

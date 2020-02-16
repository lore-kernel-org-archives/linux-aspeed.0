From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 17 Feb 2020 10:26:57 +1030
Subject: [PATCH v6 06/12] soc: aspeed: Add XDMA Engine Driver
In-Reply-To: <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
Message-ID: <3a053c3e-0fec-4ab9-b941-a335524b3303@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 11 Feb 2020, at 03:05, Arnd Bergmann wrote:
> On Wed, Jan 15, 2020 at 10:31 PM Eddie James <eajames@linux.ibm.com> wrote:
> >
> > The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
> > DMA operations between the SOC (acting as a BMC) and a host processor
> > in a server.
> >
> > This commit adds a driver to control the XDMA engine and adds functions
> > to initialize the hardware and memory and start DMA operations.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
> Hi Eddie,
> 
> I'm missing the bigger picture in the description here, how does this fit into
> the PCIe endpoint framework and the dmaengine subsystem?
> 
> Does the AST2500 show up as a PCIe device in the host, or do you just
> inject DMAs into the host and hope that bypasses the IOMMU?

The host needs to coordinate out-of-band with the BMC to communicate host
addresses to be used. The host should configure the IOMMU as required before
triggering transfers (either from it's own XDMA interface or requesting the BMC
queue the transfer).

Andrew

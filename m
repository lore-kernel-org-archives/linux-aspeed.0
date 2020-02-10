From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Feb 2020 17:35:19 +0100
Subject: [PATCH v6 06/12] soc: aspeed: Add XDMA Engine Driver
In-Reply-To: <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
Message-ID: <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 15, 2020 at 10:31 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
> DMA operations between the SOC (acting as a BMC) and a host processor
> in a server.
>
> This commit adds a driver to control the XDMA engine and adds functions
> to initialize the hardware and memory and start DMA operations.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Hi Eddie,

I'm missing the bigger picture in the description here, how does this fit into
the PCIe endpoint framework and the dmaengine subsystem?

Does the AST2500 show up as a PCIe device in the host, or do you just
inject DMAs into the host and hope that bypasses the IOMMU?
If it shows up as an endpoint, how does the endpoint driver link into the
dma driver?

     Arnd

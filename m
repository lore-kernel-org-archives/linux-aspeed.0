From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 03 Apr 2020 11:02:41 +1030
Subject: [PATCH v7 0/5] soc: aspeed: Add XDMA engine driver
In-Reply-To: <20200402194955.16643-1-eajames@linux.ibm.com>
References: <20200402194955.16643-1-eajames@linux.ibm.com>
Message-ID: <8ca08ea0-2f3e-4b44-a595-bfe96ca02b3f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 3 Apr 2020, at 06:19, Eddie James wrote:
> This series adds a driver to control the Aspeed XDMA engine embedded in the
> AST2500 and AST2600. The XDMA engine performs automatic DMA operations
> over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.
> 
> Changes since v6:
>  - See individual patches

v7 is not an evolution on v6 - v7 contains a bunch of bugs that v6 fixed (at least
wrt locking). How did you generate this series?

Also my name is misspelled in each of the Reviewed-by: tags which makes me
think that something has gone quite wrong with the posting of v7, and I'm
concerned that this was based on e.g. v5 but with my tags against v6 applied.

Andrew

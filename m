From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 17 Jan 2020 10:37:02 +1030
Subject: [PATCH v6 06/12] soc: aspeed: Add XDMA Engine Driver
In-Reply-To: <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
Message-ID: <34acf604-d2e4-4efe-91ae-52b7a0dee187@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 16 Jan 2020, at 07:59, Eddie James wrote:
> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
> DMA operations between the SOC (acting as a BMC) and a host processor
> in a server.
> 
> This commit adds a driver to control the XDMA engine and adds functions
> to initialize the hardware and memory and start DMA operations.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

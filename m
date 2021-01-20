From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 20 Jan 2021 15:31:41 +1030
Subject: [PATCH v5 2/5] ARM: dts: Remove LPC BMC and Host partitions
In-Reply-To: <20210114131622.8951-3-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-3-chiawei_wang@aspeedtech.com>
Message-ID: <c05a7bca-df80-4c26-b6dd-802696c9ddab@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> The LPC controller has no concept of the BMC and the Host partitions.
> 
> A concrete instance is that the HICRB[5:4] are for the I/O port address
> configurtaion of KCS channel 1/2. However, the KCS driver cannot access
> HICRB for channel 1/2 initialization via syscon regmap interface due to
> the parition boundary. (i.e. offset 80h)
> 
> In addition, for the HW design backward compatibility, a newly added HW
> control bit could be located at any reserved one over the LPC addressing
> space. Thereby, this patch removes the lpc-bmc and lpc-host child node
> and thus the LPC partitioning.
> 
> Note that this change requires the synchronization between device tree
> change and the driver change. To prevent the misuse of old devicetrees
> with new drivers, or vice versa, the v2 compatible strings are adopted
> for the LPC device as listed:
> 
> 	"aspeed,ast2400-lpc-v2"
> 	"aspeed,ast2500-lpc-v2"
> 	"aspeed,ast2600-lpc-v2"
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

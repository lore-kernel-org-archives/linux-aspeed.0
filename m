From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 21 May 2021 10:36:07 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v4_3/3]_mmc:_sdhci-of-aspeed:_Configure_the_SDHCIs_?=
 =?UTF-8?Q?as_specified_by_the_devicetree.?=
In-Reply-To: <20210520101346.16772-4-steven_lee@aspeedtech.com>
References: <20210520101346.16772-1-steven_lee@aspeedtech.com>
 <20210520101346.16772-4-steven_lee@aspeedtech.com>
Message-ID: <8fc49b36-256e-47ff-8834-bc60fb7a2450@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 20 May 2021, at 19:43, Steven Lee wrote:
> The hardware provides capability configuration registers for each SDHCI
> in the global configuration space for the SD controller. Writes to the
> global capability registers are mirrored to the capability registers in
> the associated SDHCI. Configuration of the capabilities must be written
> through the mirror registers prior to initialisation of the SDHCI.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

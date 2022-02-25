From: Pratyush Yadav <p.yadav@ti.com>
Date: Fri, 25 Feb 2022 13:01:55 +0530
Subject: [PATCH 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
In-Reply-To: <20220214094231.3753686-2-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-2-clg@kaod.org>
Message-ID: <20220225073155.f2cxfhm7surf34d4@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/02/22 10:42AM, C?dric Le Goater wrote:
> To prepare transition to the new Aspeed SMC SPI controller driver using
> the spi-mem interface, change the kernel CONFIG option of the current
> driver to reflect that the implementation uses the MTD SPI-NOR interface.
> Once the new driver is sufficiently exposed, we should remove the old one.

I don't quite understand the reasoning behind this. Why keep the old 
driver around? Why not directly replace it with the new one? Does the 
new one have any limitations that this one doesn't?

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.

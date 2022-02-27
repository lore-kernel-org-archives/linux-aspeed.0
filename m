From: Cédric Le Goater <clg@kaod.org>
Date: Sun, 27 Feb 2022 19:50:35 +0100
Subject: [PATCH 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
In-Reply-To: <20220225073155.f2cxfhm7surf34d4@ti.com>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-2-clg@kaod.org>
 <20220225073155.f2cxfhm7surf34d4@ti.com>
Message-ID: <688b7a65-d4b6-682b-494a-1d4178699dba@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/25/22 08:31, Pratyush Yadav wrote:
> On 14/02/22 10:42AM, C?dric Le Goater wrote:
>> To prepare transition to the new Aspeed SMC SPI controller driver using
>> the spi-mem interface, change the kernel CONFIG option of the current
>> driver to reflect that the implementation uses the MTD SPI-NOR interface.
>> Once the new driver is sufficiently exposed, we should remove the old one.
> 
> I don't quite understand the reasoning behind this. Why keep the old
> driver around? Why not directly replace it with the new one? Does the
> new one have any limitations that this one doesn't?

No. The old one has more limitations than the new one. The old one in
mainline is half baked since we could never merge the necessary bits
for training. We have been keeping a full version on the OpenBMC tree.

Joel, could we simply drop the old driver in mainline and keep the old
one in the OpenBMC tree until we feel comfortable ? I guess we need
more testing.

Thanks,

C.

> 


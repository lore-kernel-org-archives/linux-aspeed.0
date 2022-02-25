From: Pratyush Yadav <p.yadav@ti.com>
Date: Fri, 25 Feb 2022 14:48:09 +0530
Subject: [PATCH 08/10] spi: aspeed: Calibrate read timings
In-Reply-To: <20220214094231.3753686-9-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-9-clg@kaod.org>
Message-ID: <20220225091809.gvup3mcst45szi6x@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/02/22 10:42AM, C?dric Le Goater wrote:
> To accommodate the different response time of SPI transfers on different
> boards and different SPI NOR devices, the Aspeed controllers provide a
> set of Read Timing Compensation registers to tune the timing delays
> depending on the frequency being used. The AST2600 SoC has one of
> these registers per device. On the AST2500 and AST2400 SoCs, the
> timing register is shared by all devices which is a bit problematic to
> get good results other than for one device.
> 
> The algorithm first reads a golden buffer at low speed and then performs
> reads with different clocks and delay cycle settings to find a breaking
> point. This selects a default good frequency for the CEx control register.
> The current settings are bit optimistic as we pick the first delay giving
> good results. A safer approach would be to determine an interval and
> choose the middle value.
> 
> Due to the lack of API, calibration is performed when the direct mapping
> for reads is created.

The dirmap_create mapping says nothing about _when_ it should be called. 
So there is no guarantee that it will only be called after the flash is 
fully initialized. I suggest you either make this a requirement of the 
API, or create a new API that guarantees it will only be called after 
the flash is initialized, like [0].

[0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210311191216.7363-2-p.yadav at ti.com/

> 
> Cc: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.

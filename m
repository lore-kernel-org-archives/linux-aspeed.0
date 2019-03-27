From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Wed, 27 Mar 2019 11:37:34 +0100
Subject: [PATCH v3 2/2] rtc: Add ASPEED RTC driver
In-Reply-To: <20190327010215.10231-3-joel@jms.id.au>
References: <20190327010215.10231-1-joel@jms.id.au>
 <20190327010215.10231-3-joel@jms.id.au>
Message-ID: <20190327103734.GB3682@piout.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27/03/2019 11:32:15+1030, Joel Stanley wrote:
> Read and writes the time to the non-battery backed RTC in the ASPEED BMC
> system on chip families.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3:
>  - Use %ptR
>  - Remove spinlock, as callback happen under the rtc_device.ops_lock
> v2: Address review from Alexandre
>  - Use devm_rtc_allocate_device
>  - Fill in range_min
>  - Direcly fill in tm struct
>  - Return EINVAL when RTC is not enabled
> 
> v1: https://lore.kernel.org/linux-arm-kernel/20181003133155.27494-2-joel at jms.id.au/
> 
> Update kconfig text
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/rtc/Kconfig      |  11 ++++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-aspeed.c | 138 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/rtc/rtc-aspeed.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

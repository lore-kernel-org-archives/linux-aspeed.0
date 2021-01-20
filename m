From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 20 Jan 2021 15:32:55 +1030
Subject: [PATCH v5 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
In-Reply-To: <20210114131622.8951-4-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-4-chiawei_wang@aspeedtech.com>
Message-ID: <c8421730-f8a6-46a7-9e2c-9107eb979276@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> Acked-by: Haiyue Wang <haiyue.wang@linux.intel.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

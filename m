From: Haiyue Wang <haiyue.wang@linux.intel.com>
Date: Tue, 29 Dec 2020 22:53:42 +0800
Subject: [PATCH v4 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
In-Reply-To: <20201229063157.3587-4-chiawei_wang@aspeedtech.com>
References: <20201229063157.3587-1-chiawei_wang@aspeedtech.com>
 <20201229063157.3587-4-chiawei_wang@aspeedtech.com>
Message-ID: <d436cf38-7ce2-3bea-4d0e-03003e36af42@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/29/2020 14:31, Chia-Wei, Wang wrote:
> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
>
> Signed-off-by: Chia-Wei, Wang<chiawei_wang@aspeedtech.com>
> ---
>   drivers/char/ipmi/kcs_bmc_aspeed.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)

Acked-by: Haiyue Wang <haiyue.wang@linux.intel.com>




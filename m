From: Joel Stanley <joel@jms.id.au>
Date: Wed, 12 May 2021 06:34:43 +0000
Subject: [PATCH net-next] net: mdio: Add missing MODULE_DEVICE_TABLE
In-Reply-To: <1620790204-15658-1-git-send-email-zou_wei@huawei.com>
References: <1620790204-15658-1-git-send-email-zou_wei@huawei.com>
Message-ID: <CACPK8XeEHCPXt_xq4YFy5ZAdAuBgoAE0SfcyRX1P39T7Dz6d4g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 12 May 2021 at 03:13, Zou Wei <zou_wei@huawei.com> wrote:
>
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
Acked-by: Joel Stanley <joel@jms.id.au>

Thanks for the patch.

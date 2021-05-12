From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 12 May 2021 14:42:20 +0200
Subject: [PATCH net-next] net: mdio: Add missing MODULE_DEVICE_TABLE
In-Reply-To: <1620790204-15658-1-git-send-email-zou_wei@huawei.com>
References: <1620790204-15658-1-git-send-email-zou_wei@huawei.com>
Message-ID: <YJvNLExb9AtMYGZo@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 12, 2021 at 11:30:04AM +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Please make the subject line more specific. There are a number of MDIO
bus drivers in the kernel. Adding "aspeed:" would make it clear which
one you are changing.

    Andrew

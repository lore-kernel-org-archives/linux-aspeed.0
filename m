From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 14 Apr 2022 14:22:12 +0200
Subject: [PATCH v5 0/3] Add reset deassertion for Aspeed MDIO
In-Reply-To: <20220413121037.23748-1-dylan_hung@aspeedtech.com>
References: <20220413121037.23748-1-dylan_hung@aspeedtech.com>
Message-ID: <20220414142212.258fcb37@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 13 Apr 2022 20:10:34 +0800 Dylan Hung wrote:
> Add missing reset deassertion for Aspeed MDIO bus controller. The reset
> is asserted by the hardware when power-on so the driver only needs to
> deassert it. To be able to work with the old DT blobs, the reset is
> optional since it may be deasserted by the bootloader or the previous
> kernel.

I presume you want this applied to net-next, but it appears there 
is a conflict or something. Could you resend the patches based on
net-next/master?

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 28 Mar 2022 21:45:22 -0700
Subject: [PATCH v3 0/3] Add reset deassertion for Aspeed MDIO
In-Reply-To: <20220325041451.894-1-dylan_hung@aspeedtech.com>
References: <20220325041451.894-1-dylan_hung@aspeedtech.com>
Message-ID: <20220328214522.7cfdff1e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 25 Mar 2022 12:14:48 +0800 Dylan Hung wrote:
> Add missing reset deassertion for Aspeed MDIO bus controller. The reset
> is asserted by the hardware when power-on so the driver only needs to
> deassert it. To be able to work with the old DT blobs, the reset is
> optional since it may be deasserted by the bootloader or the previous
> kernel.

# Form letter - net-next is closed

We have already sent the networking pull request for 5.18
and therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after 5.18-rc1 is cut, in ~1 week.

RFC patches sent for review only are obviously welcome at any time.

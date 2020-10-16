From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 16 Oct 2020 15:37:50 -0700
Subject: [PATCH 1/1] net: ftgmac100: Fix Aspeed ast2600 TX hang issue
In-Reply-To: <20201014060632.16085-2-dylan_hung@aspeedtech.com>
References: <20201014060632.16085-1-dylan_hung@aspeedtech.com>
 <20201014060632.16085-2-dylan_hung@aspeedtech.com>
Message-ID: <20201016153750.1c46de21@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2020 14:06:32 +0800 Dylan Hung wrote:
> The new HW arbitration feature on Aspeed ast2600 will cause MAC TX to
> hang when handling scatter-gather DMA.  Disable the problematic feature
> by setting MAC register 0x58 bit28 and bit27.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Applied, thank you.

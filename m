From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Wed, 24 Nov 2021 12:00:08 +0000
Subject: [PATCH v8] net/ncsi : Add payload to be 32-bit aligned to fix
 dropped packets
In-Reply-To: <20211122163818.GA11306@gmail.com>
References: <20211122163818.GA11306@gmail.com>
Message-ID: <163775520854.1662.10651574507891086617.git-patchwork-notify@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon, 22 Nov 2021 22:08:18 +0530 you wrote:
> Update NC-SI command handler (both standard and OEM) to take into
> account of payload paddings in allocating skb (in case of payload
> size is not 32-bit aligned).
> 
> The checksum field follows payload field, without taking payload
> padding into account can cause checksum being truncated, leading to
> dropped packets.
> 
> [...]

Here is the summary with links:
  - [v8] net/ncsi : Add payload to be 32-bit aligned to fix dropped packets
    https://git.kernel.org/netdev/net/c/ac132852147a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



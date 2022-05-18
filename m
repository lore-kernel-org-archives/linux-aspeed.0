From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Wed, 18 May 2022 13:10:12 +0000
Subject: [PATCH net v3] net: ftgmac100: Disable hardware checksum on
 AST2600
In-Reply-To: <20220517092217.323060-1-joel@jms.id.au>
References: <20220517092217.323060-1-joel@jms.id.au>
Message-ID: <165287941261.26952.17675675280998772661.git-patchwork-notify@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue, 17 May 2022 18:52:17 +0930 you wrote:
> The AST2600 when using the i210 NIC over NC-SI has been observed to
> produce incorrect checksum results with specific MTU values. This was
> first observed when sending data across a long distance set of networks.
> 
> On a local network, the following test was performed using a 1MB file of
> random data.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ftgmac100: Disable hardware checksum on AST2600
    https://git.kernel.org/netdev/net/c/6fd45e79e8b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



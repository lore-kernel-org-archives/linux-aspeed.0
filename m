From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Wed, 09 Feb 2022 12:20:09 +0000
Subject: [PATCH net] net: mdio: aspeed: Add missing MODULE_DEVICE_TABLE
In-Reply-To: <20220209000359.372978-1-joel@jms.id.au>
References: <20220209000359.372978-1-joel@jms.id.au>
Message-ID: <164440920916.21838.3965616722762050917.git-patchwork-notify@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed,  9 Feb 2022 10:33:59 +1030 you wrote:
> Fix loading of the driver when built as a module.
> 
> Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] net: mdio: aspeed: Add missing MODULE_DEVICE_TABLE
    https://git.kernel.org/netdev/net/c/bc1c3c3b10db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 25 Nov 2021 16:00:10 +0000
Subject: [PATCH v2] mdio: aspeed: Fix "Link is Down" issue
In-Reply-To: <20211125024432.15809-1-dylan_hung@aspeedtech.com>
References: <20211125024432.15809-1-dylan_hung@aspeedtech.com>
Message-ID: <163785601008.7926.14064362154729889685.git-patchwork-notify@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Nov 2021 10:44:32 +0800 you wrote:
> The issue happened randomly in runtime.  The message "Link is Down" is
> popped but soon it recovered to "Link is Up".
> 
> The "Link is Down" results from the incorrect read data for reading the
> PHY register via MDIO bus.  The correct sequence for reading the data
> shall be:
> 1. fire the command
> 2. wait for command done (this step was missing)
> 3. wait for data idle
> 4. read data from data register
> 
> [...]

Here is the summary with links:
  - [v2] mdio: aspeed: Fix "Link is Down" issue
    https://git.kernel.org/netdev/net/c/9dbe33cf371b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



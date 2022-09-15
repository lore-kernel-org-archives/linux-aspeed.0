From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 15 Sep 2022 11:00:17 +0000
Subject: [PATCH net-next v3 0/2] net: ftgmac100: support fixed link
In-Reply-To: <20220907054453.20016-1-rentao.bupt@gmail.com>
References: <20220907054453.20016-1-rentao.bupt@gmail.com>
Message-ID: <166323961746.5581.16008979446604456337.git-patchwork-notify@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:

This series was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  6 Sep 2022 22:44:51 -0700 you wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series adds fixed link support to ftgmac100 driver.
> 
> Patch #1 adds fixed link logic into ftgmac100 driver.
> 
> Patch #2 enables mac3 controller in Elbert dts: Elbert mac3 is connected
> to the onboard switch BCM53134P's IMP_RGMII port directly (no PHY
> between BMC MAC and BCM53134P).
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: ftgmac100: support fixed link
    https://git.kernel.org/netdev/net-next/c/38561ded50d0
  - [net-next,v3,2/2] ARM: dts: aspeed: elbert: Enable mac3 controller
    https://git.kernel.org/netdev/net-next/c/ce6ce9176975

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



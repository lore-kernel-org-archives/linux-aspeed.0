From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 28 Apr 2022 08:00:13 +0000
Subject: [PATCH net-next v6 0/3] Add reset deassertion for Aspeed MDIO
In-Reply-To: <20220427035501.17500-1-dylan_hung@aspeedtech.com>
References: <20220427035501.17500-1-dylan_hung@aspeedtech.com>
Message-ID: <165113281383.18320.4392733597031620759.git-patchwork-notify@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:

This series was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 27 Apr 2022 11:54:58 +0800 you wrote:
> Add missing reset deassertion for Aspeed MDIO bus controller. The reset
> is asserted by the hardware when power-on so the driver only needs to
> deassert it. To be able to work with the old DT blobs, the reset is
> optional since it may be deasserted by the bootloader or the previous
> kernel.
> 
> V6:
> - fix merge conflict for net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] dt-bindings: net: add reset property for aspeed, ast2600-mdio binding
    https://git.kernel.org/netdev/net-next/c/65e42ad98e22
  - [net-next,v6,2/3] net: mdio: add reset control for Aspeed MDIO
    https://git.kernel.org/netdev/net-next/c/1585362250fe
  - [net-next,v6,3/3] ARM: dts: aspeed: add reset properties into MDIO nodes
    https://git.kernel.org/netdev/net-next/c/a8db203db05c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 19 Jan 2023 15:30:18 +0000
Subject: [PATCH net-next v2 0/6] net: phy: Remove probe_capabilities
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
Message-ID: <167414221817.31934.14400606803161415762.git-patchwork-notify@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:

This series was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Jan 2023 11:01:35 +0100 you wrote:
> With all the drivers which used .probe_capabilities converted to the
> new c45 MDIO access methods, we can now decide based upon these whether
> a bus driver supports c45 and we can get rid of the not widely used
> probe_capabilites.
> 
> Unfortunately, due to a now broader support of c45 scans, this will
> trigger a bug on some boards with a (c22-only) Micrel PHY. These PHYs
> don't ignore c45 accesses correctly, thinking they are addressed
> themselves and distrupt the MDIO access. To avoid this, a blacklist
> for c45 scans is introduced.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: mdio: Move mdiobus_scan() within file
    https://git.kernel.org/netdev/net-next/c/81d874e7c84e
  - [net-next,v2,2/6] net: mdio: Rework scanning of bus ready for quirks
    https://git.kernel.org/netdev/net-next/c/d41e127757f3
  - [net-next,v2,3/6] net: mdio: Add workaround for Micrel PHYs which are not C45 compatible
    https://git.kernel.org/netdev/net-next/c/348659337485
  - [net-next,v2,4/6] net: mdio: scan bus based on bus capabilities for C22 and C45
    https://git.kernel.org/netdev/net-next/c/1a136ca2e089
  - [net-next,v2,5/6] net: phy: Decide on C45 capabilities based on presence of method
    https://git.kernel.org/netdev/net-next/c/fbfe97597c77
  - [net-next,v2,6/6] net: phy: Remove probe_capabilities
    https://git.kernel.org/netdev/net-next/c/da099a7fb13d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



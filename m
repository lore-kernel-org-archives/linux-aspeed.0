From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Sat, 14 Jan 2023 05:50:18 +0000
Subject: [PATCH net-next 00/10] net: mdio: Continue separating C22 and C45
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <167367541847.15756.1816103460556617097.git-patchwork-notify@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jan 2023 16:15:07 +0100 you wrote:
> I've picked this older series from Andrew up and rebased it onto
> the latest net-next.
> 
> This is the second patch set in the series which separates the C22
> and C45 MDIO bus transactions at the API level to the MDIO bus drivers.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: mdio: cavium: Separate C22 and C45 transactions
    https://git.kernel.org/netdev/net-next/c/93641ecbaa1f
  - [net-next,02/10] net: mdio: i2c: Separate C22 and C45 transactions
    https://git.kernel.org/netdev/net-next/c/87e3bee0f247
  - [net-next,03/10] net: mdio: mux-bcm-iproc: Separate C22 and C45 transactions
    https://git.kernel.org/netdev/net-next/c/d544a25930a7
  - [net-next,04/10] net: mdio: aspeed: Separate C22 and C45 transactions
    https://git.kernel.org/netdev/net-next/c/c3c497eb8b24
  - [net-next,05/10] net: mdio: ipq4019: Separate C22 and C45 transactions
    https://git.kernel.org/netdev/net-next/c/c58e39942adf
  - [net-next,06/10] net: ethernet: mtk_eth_soc: Separate C22 and C45 transactions
    https://git.kernel.org/netdev/net-next/c/900888374e73
  - [net-next,07/10] net: lan743x: Separate C22 and C45 transactions
    https://git.kernel.org/netdev/net-next/c/3d90c03cb416
  - [net-next,08/10] net: stmmac: Separate C22 and C45 transactions for xgmac2
    https://git.kernel.org/netdev/net-next/c/5b0a447efff5
  - [net-next,09/10] net: stmmac: Separate C22 and C45 transactions for xgmac
    https://git.kernel.org/netdev/net-next/c/3c7826d0b106
  - [net-next,10/10] enetc: Separate C22 and C45 transactions
    https://git.kernel.org/netdev/net-next/c/80e87442e69b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



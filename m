From: Heiko Stuebner <heiko@sntech.de>
Date: Wed,  9 Aug 2023 15:57:33 +0200
Subject: (subset) [PATCH v2 00/23] ARM: DT include cleanups
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <169158939237.3288791.15504684466280859190.b4-ty@sntech.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 03 Aug 2023 16:42:40 -0600, Rob Herring wrote:
> Arnd, This is all the remaining ARM and SoC related patches of DT
> include cleanups which have not be applied by sub-arch maintainers.
> 
> A few of these are v2, but most are just resends of v1.
> 
> 

Applied, thanks!

I didn't find a reply to the thread in terms of it going
in alltogether, so went forward and picked the Rockchip things
I missed before.


[12/23] ARM: rockchip: Drop unused includes
        commit: 8cbdf5d2880923070198c240534f4cca3e04dfb1
[20/23] soc: rockchip: Explicitly include correct DT includes
        commit: fc7696e2ae81404c6ca176e7ebbddd4b19c40953

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

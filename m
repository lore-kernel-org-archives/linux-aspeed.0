From: Heiko Stübner <heiko@sntech.de>
Date: Sun, 06 Aug 2023 15:41:22 +0200
Subject: [PATCH v2 12/23] ARM: rockchip: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-12-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-12-d8de2cc88bff@kernel.org>
Message-ID: <21971720.EfDdHjke4D@diego>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am Freitag, 4. August 2023, 00:42:52 CEST schrieb Rob Herring:
> Several includes are not needed, so drop them.
> 
> of_platform.h is not needed, but it implicitly includes of.h which is
> needed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



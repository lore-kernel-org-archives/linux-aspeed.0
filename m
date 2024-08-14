From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 14 Aug 2024 08:07:56 +0200
Subject: [PATCH v4 1/2] ARM: dts: aspeed: Add properties of scu and gfx
 for video
In-Reply-To: <20240814005421.3362441-2-jammy_huang@aspeedtech.com>
References: <20240814005421.3362441-1-jammy_huang@aspeedtech.com>
 <20240814005421.3362441-2-jammy_huang@aspeedtech.com>
Message-ID: <c66a45ca-a526-4865-840e-2fce108eab91@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/08/2024 02:54, Jammy Huang wrote:
> To have video support capture from SoC display(GFX), these properties
> are added to allow video to control related registers.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

NAK, you still keep adding undocumented properties. I commented already
that you did not document the bindings for new properties. I also said
what you need to do, so why doing something entirely else?

Best regards,
Krzysztof


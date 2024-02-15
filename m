From: Chanho Min <chanho.min@lge.com>
Date: Thu, 15 Feb 2024 09:25:50 -0000
Subject: [PATCH 3/6] arm64: dts: Fix dtc interrupt_provider warnings
In-Reply-To: <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
 <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
Message-ID: <f5aeffed-9365-b1db-4c32-4ed6da208ea0@lge.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24. 2. 14. 4:34 Rob Herring wrote:
> The dtc interrupt_provider warning is off by default. Fix all the warnings
> so it can be enabled.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

>   arch/arm64/boot/dts/lg/lg1312.dtsi                  | 1 -
>   arch/arm64/boot/dts/lg/lg1313.dtsi                  | 1 -
Acked-by: Chanho Min <chanho.min@lge.com>


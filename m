From: Shawn Guo <shawn.gsc@gmail.com>
Date: Mon, 05 Feb 2024 09:50:23 -0000
Subject: [PATCH 2/3] arm64: dts: imx93: drop "master" I3C node name suffix
In-Reply-To: <20240117075618.81932-2-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
 <20240117075618.81932-2-krzysztof.kozlowski@linaro.org>
Message-ID: <ZcCvUJNslxafvCab@t480>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 17, 2024 at 08:56:17AM +0100, Krzysztof Kozlowski wrote:
> Following change in the I3C bindings, the "master" suffix in I3C
> controller node name is discouraged (it is "controller" now) and not
> accurate (if device supports also target mode).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

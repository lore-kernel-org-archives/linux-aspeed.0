From: Dinh Nguyen <dinguyen@kernel.org>
Date: Mon, 5 Feb 2024 21:11:03 -0600
Subject: [PATCH 3/3] arm64: dts: intel: agilex5: drop "master" I3C node
 name suffix
In-Reply-To: <20240117075618.81932-3-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
 <20240117075618.81932-3-krzysztof.kozlowski@linaro.org>
Message-ID: <f3ae2e5a-1850-461f-aa9c-2c7bceac8318@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/17/24 01:56, Krzysztof Kozlowski wrote:
> Following change in the I3C bindings, the "master" suffix in I3C
> controller node name is discouraged (it is "controller" now) and not
> accurate (if device supports also target mode).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> The change can be applied through independent trees, if the I3C bindings
> change is applied.  Therefore please take it once I3C bindings is
> applied.
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied.

Thanks,
Dinh


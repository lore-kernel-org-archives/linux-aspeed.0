From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 29 May 2024 09:28:55 +0200
Subject: [PATCH 4/4] dt-bindings: gpio: aspeed,sgpio: Require
 #interrupt-cells
In-Reply-To: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-4-91c42976833b@codeconstruct.com.au>
References: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
 <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-4-91c42976833b@codeconstruct.com.au>
Message-ID: <35b39da8-4efd-44ae-bcc1-7f4d501e0873@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/05/2024 07:13, Andrew Jeffery wrote:
> It shouldn't have been the case that it wasn't required. The kernel
> devicetrees already specified it where compatible nodes were defined,
> and u-boot pulls in the kernel devicetrees, so this should have minimal
> practical impact.
> 

This should be squashed with previous patch.

Best regards,
Krzysztof


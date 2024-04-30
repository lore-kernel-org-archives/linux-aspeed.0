From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 30 Apr 2024 08:51:18 +0200
Subject: [PATCH v4 02/17] dt-bindings: fsi: fsi2spi: Document SPI
 controller child nodes
In-Reply-To: <20240429210131.373487-3-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-3-eajames@linux.ibm.com>
Message-ID: <3b516d27-a676-4d6f-9076-76bebb74ff47@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/04/2024 23:01, Eddie James wrote:
> The FSI2SPI bridge has several SPI controllers behind it, which
> should be documented. Also, therefore the node needs to specify
> address and size cells.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


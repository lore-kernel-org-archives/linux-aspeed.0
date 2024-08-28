From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 28 Aug 2024 09:30:28 +0200
Subject: [PATCH v2 0/3] Add support for AST2700 clk driver
In-Reply-To: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
Message-ID: <12486d33-e70f-49df-b16e-85c99b5027ca@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 28/08/2024 08:27, Ryan Chen wrote:
> This patch series is add clk driver for AST2700.
> 
> AST2700 is the 8th generation of Integrated Remote Management Processor
> introduced by ASPEED Technology Inc. Which is Board Management controller
> (BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
> is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.
> 
> v2:
> -yaml: drop 64bits address example.
> -yaml: add discription about soc0 and soc1

Where?

Proof read your patches before sending.

Best regards,
Krzysztof


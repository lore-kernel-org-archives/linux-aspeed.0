From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Feb 2023 09:30:24 +0100
Subject: [PATCH v5 0/2] Add ASPEED AST2600 I2Cv2 controller driver
In-Reply-To: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
Message-ID: <54ef0dee-30dc-3ba9-d2f7-8270204b5505@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 20/02/2023 07:17, Ryan Chen wrote:
> This series add AST2600 i2cv2 new register set driver. The i2cv2 new
> register set have new clock divider option for more flexiable generation.

Typo: flexible

> And also have separate i2c master and slave register set for control.

Since several of my questions remained unanswered and quite frankly it's
fruitless... so let me read the commit msg directly - it's the same
device, just with different register layout. Having new compatible makes
sense, but this should be part of old binding.

Best regards,
Krzysztof


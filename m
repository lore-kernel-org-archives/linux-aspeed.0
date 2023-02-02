From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 2 Feb 2023 10:00:45 +0100
Subject: [PATCH v4 0/3] Add ASPEED AST2600 I2C new controller driver
In-Reply-To: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
Message-ID: <ac9be40d-bbcb-02b1-2708-61f88095111b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/02/2023 11:33, Ryan Chen wrote:
> This series add AST2600 i2c new register set driver. The i2c new
> register set have new clock divider option for more flexiable generation.
> And also have separate i2c master and slave register set for control.
> 
> v4:
> -fix i2c-ast2600.c driver buffer mode use single buffer conflit in
>  master slave mode both enable.
> -fix kmemleak issue when use dma mode.
> -fix typo aspeed,i2c-ast2600.yaml compatible is "aspeed,ast2600-i2c"
> -fix typo aspeed,i2c-ast2600.ymal to aspeed,i2c-ast2600.yaml
> 

How this can be a v4? Where are all others?

https://lore.kernel.org/all/?q=dfn%3Aaspeed%2Ci2c-ast2600-global.yaml
https://lore.kernel.org/all/?q=dfn%3Aaspeed%2Ci2c-ast2600.yaml

I see it for the first time.

Best regards,
Krzysztof


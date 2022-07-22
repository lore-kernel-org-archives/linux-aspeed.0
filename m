From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 22 Jul 2022 12:15:48 +0930
Subject: [PATCH] ARM: dts: aspeed: vegman: drop unused fttmr010,pwm-outputs
 property
In-Reply-To: <20220529111442.182722-1-krzysztof.kozlowski@linaro.org>
References: <20220529111442.182722-1-krzysztof.kozlowski@linaro.org>
Message-ID: <b5772fef-607c-46cb-9b27-8259c250648e@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sun, 29 May 2022, at 20:44, Krzysztof Kozlowski wrote:
> The "fttmr010,pwm-outputs" property is neither documented, nor used in
> Linux kernel driver, so remove it.  This also fixes warning like:
>
>   aspeed-bmc-vegman-n110.dtb: timer at 1e782000: 'fttmr010,pwm-outputs' 
> does not match any of the regexes:
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

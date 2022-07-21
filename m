From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 21 Jul 2022 17:43:19 +0200
Subject: [PATCH 5/6] ARM: defconfig: remove broken CONFIG_THUMB disables
In-Reply-To: <20220721141325.2413920-6-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-6-arnd@kernel.org>
Message-ID: <ba87edff-6e2c-884f-1afb-cf4b721b6893@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/07/2022 16:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since commit 1515b186c235 ("ARM: make configuration of userspace
> Thumb support an expert option"), CONFIG_THUMB cannot be disabled
> unless one turns on CONFIG_EXPERT first.
> 
> This is probably for the better, so remove the statements that
> turn it off.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
